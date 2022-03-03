from kobert import get_tokenizer
from kobert import get_pytorch_kobert_model
from torch import nn
import torch
from torch.utils.data import Dataset, DataLoader
import gluonnlp as nlp
import numpy as np
import time

start = time.time()
## Setting parameters
max_len = 40
batch_size = 32
warmup_ratio = 0.1
num_epochs = 3
max_grad_norm = 1
log_interval = 200
learning_rate =  5e-5
bertmodel, vocab = get_pytorch_kobert_model(cachedir=".cache")
device = torch.device('cpu')

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
tokenizer = get_tokenizer()
tok = nlp.data.BERTSPTokenizer(tokenizer, vocab, lower=False)

"""
모델 실행
sentece : str : 입력할 문장
model : str:모델 웨이트값 저장된 "파일명.확장자"
count : 예측값의 라벨갯수
return : tensor : 결과값
"""
def callmodel(sentence,model,count):
    emotion_model2 = BERTClassifier(bertmodel, dr_rate=0.5, num_classes=count).to()
    emotion_model2.load_state_dict(torch.load(model))
    emotion_model2.eval()
    
    return predict(sentence,emotion_model2)

"""
모델 실행
sentece : str : 입력할 문장
model : 불러온 모델
result : tensor : 결과값
"""
def predict(predict_sentence,model):

    data = [predict_sentence, '0']
    dataset_another = [data]
    another_test = BERTDataset(dataset_another, 0, 1, tok, len(predict_sentence), True, False)
    #num_workers값 수정(전체 반복횟수), num_workers=0으로 변경
    test_dataloader = torch.utils.data.DataLoader(another_test, batch_size=batch_size)
    #print(another_test[0])
    model.eval()

    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)

        valid_length= valid_length
        label = label.long().to(device)

        out = model(token_ids, valid_length, segment_ids)

        test_eval = []
    
    print(torch.nn.functional.softmax(out, dim=1))
    result=torch.nn.functional.softmax(out, dim=1)[0]
    print("time : ", time.time() - start) 
    return result