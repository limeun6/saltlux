from kobert import get_tokenizer
from kobert import get_pytorch_kobert_model
from torch import nn
import torch
from torch.utils.data import Dataset, DataLoader
import gluonnlp as nlp
import numpy as np
import time

# 소요 시간확인
start = time.time()

# 파라미터
max_len = 40
batch_size = 32
warmup_ratio = 0.1
num_epochs = 3
max_grad_norm = 1
log_interval = 200
learning_rate =  5e-5

bertmodel, vocab = get_pytorch_kobert_model(cachedir=".cache")

# 상수 선언
emotion_count=10
sentiment_count=3
category_sentiment=0
category_emotion=1
sentiment_weight="sentiment.pt"
emotion_weight="emotion.pt"

# 토크나이저
tokenizer = get_tokenizer()
tok = nlp.data.BERTSPTokenizer(tokenizer, vocab, lower=False)

class BERTClassifier(nn.Module):
    def __init__(self,
                 bert,
                 hidden_size = 768,
                 num_classes=0,
                dr_rate=None,
                params=None):
        super(BERTClassifier, self).__init__()
        self.bert = bert
        self.dr_rate = dr_rate

        self.classifier = nn.Linear(hidden_size , num_classes)
        if dr_rate:
            self.dropout = nn.Dropout(p=dr_rate)

    def gen_attention_mask(self, token_ids, valid_length):
        attention_mask = torch.zeros_like(token_ids)
        for i, v in enumerate(valid_length):
            attention_mask[i][:v] = 1
        return attention_mask.float()

    def forward(self, token_ids, valid_length, segment_ids):
        attention_mask = self.gen_attention_mask(token_ids, valid_length)

        _, pooler = self.bert(input_ids = token_ids, token_type_ids = segment_ids.long(), attention_mask = attention_mask.float().to(token_ids.device))
        if self.dr_rate:
            out = self.dropout(pooler)
        return self.classifier(out)

# 모델 선언 - 감성
global sentiment_model
sentiment_model = BERTClassifier(bertmodel, dr_rate=0.5, num_classes=sentiment_count).to()
sentiment_model.load_state_dict(torch.load(sentiment_weight))
sentiment_model.eval()
# 모델 선언 - 감정
global emotion_model
emotion_model = BERTClassifier(bertmodel, dr_rate=0.5, num_classes=emotion_count).to()
emotion_model.load_state_dict(torch.load(emotion_weight))
emotion_model.eval()

class BERTDataset(Dataset):
    def __init__(self, dataset, sent_idx, label_idx, bert_tokenizer, max_len,
                 pad, pair):
        transform = nlp.data.BERTSentenceTransform(
            bert_tokenizer, max_seq_length=max_len, pad=pad, pair=pair)

        self.sentences = [transform([i[sent_idx]]) for i in dataset]
        self.labels = [np.int32(i[label_idx]) for i in dataset]

    def __getitem__(self, i):
        return (self.sentences[i] + (self.labels[i], ))

    def __len__(self):
        return (len(self.labels))

"""
모델 실행
sentece : str : 입력할 문장
model : str : 모델 웨이트값 저장된 "파일명.확장자"
category : int : 감정/감성을 구분하는 항목
return : tensor : 결과값
"""
def call_model(sentence:str, category:int):
    """
    감정/감성에 따른 출력값을 예측
    """
    if category==category_emotion:
        model_sample=emotion_model    
    if category==category_sentiment:
        model_sample=sentiment_model
    return predict(sentence,model_sample) 

"""
모델 실행
sentece : str : 입력할 문장
model : 불러온 모델
result : tensor : 결과값
"""
def predict(predict_sentence:str,model):
    """
    문장을 분석해 감정/감성을 예측
    """
    data = [predict_sentence, '0']
    dataset_another = [data]
    another_test = BERTDataset(dataset_another, 0, 1, tok, len(predict_sentence), True, False)
    #num_workers값 수정(전체 반복횟수), num_workers=0으로 변경
    test_dataloader = torch.utils.data.DataLoader(another_test, batch_size=batch_size)
    model.eval()

    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to()
        segment_ids = segment_ids.long().to()

        valid_length= valid_length
        label = label.long().to()

        out = model(token_ids, valid_length, segment_ids)

        test_eval = []
    
    result=torch.nn.functional.softmax(out, dim=1)[0]
    print("모델 소요시간 : ", time.time() - start) 
    return result