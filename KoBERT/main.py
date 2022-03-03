from flask import Flask, render_template, request, jsonify, make_response
import numpy as np
import cv2
import base64
import tensorflow as tf
import tensorflow_datasets as tfds
import pandas as pd
import urllib.request
import time
import matplotlib.pyplot as plt
import re
import json
from collections import OrderedDict
import calculation
#import KoBERT
#import KoBERT.model
import model
import torch
#sys.path.append('absolute path')
#from KoBERT.kobert.utils import get_tokenizer
#from KoBERT.kobert.pytorch_kobert import get_pytorch_kobert_model


# 전역함수 정의
sentimentModel="sentiment.pt"
sentimentCount=3
emotionModel="emotion5.pt"
emotionCount=10

# 고객/상담사가 입력한 값을 일시저장
stackSentence=""
customerSentence=""
counselorSentence = ""

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

"""
입력된 값을 처리
customerInput : 고객입력값
counselorInput : 상담사입력값
response : json : java에 반환할 json
"""
@app.route("/chatting", methods=["POST"])
def chatting():
    # 고객의 경우 0, 상담사의 경우 1 을 반환
    InputSelection=0
    global stackSentence
    global customerSentence
    global counselorSentence

    #자바에서 들어온 값 고객인경우와 카운셀러인 경우 둘중 하나의 값을 저장
    InputText = request.form.get('customerInput')
    if InputText==None:
        InputText = request.form.get('counselorInput')
        InputSelection=1
        counselorSentence=InputText
        InputText = calculation.beforSentence(InputText)
    else :
        InputSelection=0
        customerSentence=InputText
        InputText = calculation.beforSentence(InputText)
    
    if(InputSelection==0):
        # 싱글턴입력값
        singleSentence=counselorSentence+" "+customerSentence
    # 멀티턴입력값
    stackSentence=stackSentence+" "+InputText    
    
    print(stackSentence)
    
    # 감성분석결과,결과값3개(p긍정,n부정,m중립)
    sentimentAnswer=model.callmodel(InputText,sentimentModel,sentimentCount)
    multiturnSentimentAnswer=model.callmodel(stackSentence,sentimentModel,sentimentCount)
    # 감정분석결과,결과값10개(분노, 슬픔, 놀람, 혐오, 상처, 당황, 불안, 기쁨, 행복, 중립)
    emotionAnswer=model.callmodel(InputText,emotionModel,emotionCount)
    multiturnEmotionAnswer=model.callmodel(stackSentence,emotionModel,emotionCount)
    # 대화의 한턴이 끝났을 때 싱글턴과 멀티턴 결과를 출력
    if(InputSelection==0):
        singleSentenceSentimentAnswer=model.callmodel(singleSentence,sentimentModel,sentimentCount)
        multiturnSentimentAnswer=model.callmodel(stackSentence,sentimentModel,sentimentCount)
        singleSentenceEmotionAnswer=model.callmodel(singleSentence,emotionModel,emotionCount)
        multiturnEmotionAnswer=model.callmodel(stackSentence,emotionModel,emotionCount)
        print(singleSentenceSentimentAnswer)
        print(multiturnSentimentAnswer)
        print(singleSentenceEmotionAnswer)
        print(multiturnEmotionAnswer)

    #Json으로 값을 정리
    result = makeJson(sentimentAnswer,emotionAnswer)
    
    #자바에 값을 반환
    response=make_response(result)
    response.headers.add("Access-Control-Allow-Origin",	"*")
    return response

"""
모델에서 출력된 결과 값으로 Json생성
sentimentList : tensor : 감성 모델의 결과값
emotionList : tensor : 감정 모델의 결과값
result : json : java에 반환할 json
"""
def makeJson(sentimentList, emotionList):
    #tensor를 list 로 변환
    sentimentAnswerList=sentimentList.tolist()
    emotionAnswerList=emotionList.tolist()
    file_data = OrderedDict()
    sentimentdic={}
    emotiondic={}
    emotion=["anger","sad","surprise","hatred","hurt","panic","anxiety","joy","happy","neutrality"]
    sentiment=["positive","negative","middle"]
    
    #emotion을 딕셔너리화
    for i in range(0,len(emotionAnswerList)):
        emotiondic[emotion[i]]=emotionAnswerList[i]
    
    #sentiment 딕셔너리화
    for i in range(0,len(sentimentAnswerList)):
        sentimentdic[sentiment[i]]=sentimentAnswerList[i]

    #Json으로 변환
    file_data["emotion"]=emotiondic
    file_data["sentiment"]=sentimentdic
    file_data["Stress"]=round(float(calculation.stress_score(emotionList, sentimentList)),2)
    
    result=json.dumps(file_data,ensure_ascii=False).encode('utf8')
    print(json.dumps(file_data,ensure_ascii=False).encode('utf8'))
    return result

if __name__== '__main__':
    app.debug=True
    app.run()
