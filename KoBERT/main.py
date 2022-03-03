from flask import Flask, render_template, request, jsonify, make_response
import numpy as np
import pandas as pd
import json
from collections import OrderedDict
import calculation
import model

# 감정/감성 구분
category_sentiment=0
category_emotion=1

# 고객/상담사가 입력한 값을 일시저장
multi_sentence=""
customer_sentence=""
counselor_sentence = ""


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
    input_selection=0
    global multi_sentence
    global customer_sentence
    global counselor_sentence

    #자바에서 들어온 값 고객인경우와 카운셀러인 경우 둘중 하나의 값을 저장
    input_text = request.form.get('customerInput')
    if input_text==None:
        input_text = request.form.get('counselorInput')
        input_selection=1
        counselor_sentence=input_text
        input_text = calculation.after_sentence(input_text)
    else :
        input_selection=0
        customer_sentence=input_text
        input_text = calculation.after_sentence(input_text)
    
    if(input_selection==0):
        # 싱글턴입력값
        single_sentence=counselor_sentence+" "+customer_sentence
    
    # 멀티턴입력값
    multi_sentence=multi_sentence+" "+input_text
    
    # 감성분석결과,결과값3개(p긍정,n부정,m중립)
    sentiment_result=model.call_model(input_text,category_sentiment)

    # 감정분석결과,결과값10개(분노, 슬픔, 놀람, 혐오, 상처, 당황, 불안, 기쁨, 행복, 중립)
    emotion_result=model.call_model(input_text,category_emotion)

    # 대화의 한턴이 끝났을 때 싱글턴과 멀티턴 결과를 출력
    if(input_selection==0):
        # 싱글턴 감성
        single_sentiment_result=model.call_model(single_sentence,category_sentiment)
        # 멀티턴 감성
        multi_sentiment_result=model.call_model(multi_sentence,category_sentiment)
        # 싱글턴 감정
        single_emotion_result=model.call_model(single_sentence,category_emotion)
        # 멀티턴 감정
        multi_emotion_result=model.call_model(multi_sentence,category_emotion)
    
    #Json으로 값을 정리
    result = make_json(sentiment_result,emotion_result)
    
    #자바에 값을 반환
    response=make_response(result)
    response.headers.add("Access-Control-Allow-Origin",	"*")
    return response

"""
모델에서 출력된 결과 값으로 Json생성
sentiment_list : tensor : 감성 모델의 결과값
emotion_list : tensor : 감정 모델의 결과값
result : json : java에 반환할 json
"""
def make_json(sentiment_list, emotion_list):
    """
    예측된 감정/감성 문장을 Json형태로 반환
    """
    
    # 감성/감정 정의
    emotion=["anger","sad","surprise","hatred","hurt","panic","anxiety","joy","happy","neutrality"]
    sentiment=["positive","negative","middle"]
    
    #tensor를 list 로 변환
    sentiment_result_list=sentiment_list.tolist()
    emotion_result_list=emotion_list.tolist()
    file_data = OrderedDict()
    sentiment_dic={}
    emotion_dic={}
    
    #emotion을 딕셔너리화
    for i in range(len(emotion_result_list)):
        emotion_dic[emotion[i]]=emotion_result_list[i]
    
    #sentiment 딕셔너리화
    for i in range(len(sentiment_result_list)):
        sentiment_dic[sentiment[i]]=sentiment_result_list[i]

    #Json으로 변환
    file_data["emotion"]=emotion_dic
    file_data["sentiment"]=sentiment_dic
    file_data["Stress"]=calculation.stress_score(emotion_list, sentiment_list)
    
    result=json.dumps(file_data,ensure_ascii=False).encode('utf8')

    return result

if __name__== '__main__':
    app.debug=True
    app.run()
