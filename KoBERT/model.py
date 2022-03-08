from kobert import get_tokenizer
from kobert import get_pytorch_kobert_model
from torch import nn
import torch
from torch.utils.data import Dataset, DataLoader
import gluonnlp as nlp
import numpy as np
import os

## CPU
device = torch.device("cpu")
## GPU
#device = torch.device("cuda:0")

os.environ['CUDA_LAUNCH_BLOCKING'] = "1"
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
#파라미터
batch_size=32

# 상수선언
emotion_count=10
sentiment_count=3
sentiment_weight="sentiment.pt"
emotion_weight="emotion.pt"

bertmodel, vocab = get_pytorch_kobert_model(cachedir=".cache")

# 토크나이저
tokenizer = get_tokenizer()
tok = nlp.data.BERTSPTokenizer(tokenizer, vocab, lower=False)

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

class BERTClassifier(nn.Module):
    def __init__(self,
                 bert,
                 hidden_size=768,
                 num_classes=10,
                 dr_rate=None,
                 params=None):
        super(BERTClassifier, self).__init__()
        self.bert = bert
        self.dr_rate = dr_rate

        self.classifier = nn.Linear(hidden_size, num_classes)
        if dr_rate:
            self.dropout = nn.Dropout(p=dr_rate)

    def gen_attention_mask(self, token_ids, valid_length):
        attention_mask = torch.zeros_like(token_ids)
        for i, v in enumerate(valid_length):
            attention_mask[i][:v] = 1
        return attention_mask.float()

    def forward(self, token_ids, valid_length, segment_ids):
        attention_mask = self.gen_attention_mask(token_ids, valid_length)

        _, pooler = self.bert(input_ids=token_ids, token_type_ids=segment_ids.long(),
                              attention_mask=attention_mask.float().to(token_ids.device))
        if self.dr_rate:
            out = self.dropout(pooler)
        return self.classifier(out)

"""
모델 생성
num_class : int : 모델 구분을 위한 값 3인경우 감성, 10인경우 감정
load_model : 결과값
"""
def make_model(num_class):
    """
    프로그램 시작시 필요한 모델 생성
    """
    
    if num_class == sentiment_count:
        bertmodel, vocab = get_pytorch_kobert_model(cachedir=".cache")

        tokenizer = get_tokenizer()
        tok = nlp.data.BERTSPTokenizer(tokenizer, vocab, lower=False)

        model_save_name = sentiment_weight

        load_model = BERTClassifier(bertmodel, num_classes=num_class, dr_rate=0.5).to(device)
        load_model.load_state_dict(torch.load(model_save_name, map_location=torch.device("cpu")))
        load_model.eval()

    elif num_class == emotion_count:
        bertmodel, vocab = get_pytorch_kobert_model(cachedir=".cache")

        tokenizer = get_tokenizer()
        tok = nlp.data.BERTSPTokenizer(tokenizer, vocab, lower=False)

        model_save_name = emotion_weight
        load_model = BERTClassifier(bertmodel, num_classes=num_class, dr_rate=0.5).to(device)
        load_model.load_state_dict(torch.load(model_save_name, map_location=torch.device("cpu")))
        load_model.eval()

    return load_model

"""
감정모델 예측 실행
sentece : str : 입력할 문장
model : 불러온 모델
result : tensor : 결과값
"""
def emotion_predict(model, sentence:str):
    """
    문장을 분석해 감정을 예측
    """
    data = [sentence, '0']
    dataset_another = [data]

    another_test = BERTDataset(dataset_another, 0, 1, tok, 150, True, False)
    test_dataloader = torch.utils.data.DataLoader(another_test, batch_size=batch_size)

    model.eval()

    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)

        valid_length = valid_length
        label = label.long().to(device)

        out = model(token_ids, valid_length, segment_ids)

        for i in out:
            logits = i
            logits = logits.detach().cpu().numpy()

    return torch.nn.functional.softmax(out, dim=1)[0]

"""
감성모델 실행
sentece : str : 입력할 문장
model : 불러온 모델
result : tensor : 결과값
"""
def sentiment_predict(model, sentence:str):
    """
    문장을 분석해 감성을 예측
    """

    data = [sentence, '0']
    dataset_another = [data]

    another_test = BERTDataset(dataset_another, 0, 1, tok, 150, True, False)
    test_dataloader = torch.utils.data.DataLoader(another_test, batch_size=batch_size)
    model.eval()

    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)

        valid_length = valid_length
        label = label.long().to(device)

        out = model(token_ids, valid_length, segment_ids)

        for i in out:
            logits = i
            logits = logits.detach().cpu().numpy()

    return torch.nn.functional.softmax(out, dim=1)[0]