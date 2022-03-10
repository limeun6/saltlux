from flask import Flask, render_template, request, jsonify, make_response
import json

from model import *
from calculation import *
from collections import OrderedDict

app = Flask(__name__)

# 모델 생성
sentiment_model = make_model(3)
emotion_model = make_model(8)

# 대화내용을 각각 저장
multi_list = []
customer = ''
counselor = ''
total_chat = ''

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
    # 웹에서 입력받은 문장
    customer_chat = request.form.get('customerInput')
    counselor_chat = request.form.get('counselorInput')
    global customer
    global counselor
    global total_chat

    # 입력을 고객이 한 경우
    if customer_chat != None:
        # 싱글턴의 내용을 저장하기 위해서 과거 상담사가 입력한 내용이 공백이 아닌경우
        if counselor != '':
            # 멀티턴 대화에 고객, 상담사의 내용을 추가
            multi_list.append([customer, counselor])
            # 저장소를 초기화
            counselor = ''
            customer = ''
        
        # 입력값 처리
        input_customer = input_processing(customer_chat)
        customer += input_customer
        print(customer)

        # 고객의 감정값을 취득(문장)
        emotion_result = emotion_predict(emotion_model, input_customer)
        print(emotion_result)
        # 고객의 감성값을 취득(문장)
        sentiment_result = sentiment_predict(sentiment_model, input_customer)
        print(sentiment_result)
        print(total_chat)
    # 입력을 상담사가 한 경우
    else:
        # 입력값 처리
        input_counselor = input_processing(counselor_chat)
        counselor = input_counselor

        # 상담사의 감정값을 취득(멀티턴)
        emotion_result = emotion_predict(emotion_model, total_chat)
        # 상담사의 감성값을 취득(멀티턴)
        sentiment_result = sentiment_predict(sentiment_model, total_chat)
    
    # 저장값 확인
    # print(customer)
    # print(counselor)
    # print(total_chat)
    # print(multi_list)

    # 웹으로 반환할 값을 json으로 생성
    result = make_dict(emotion_result, sentiment_result, swear_word)
    print(result)
    result = json.dumps(result, ensure_ascii=False).encode('utf8')
    response = make_response(result)
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response

"""
입력내용 공통처리부분 함수화
input_data : str : 입력된 문장
input_sentence : str : 공통처리 후 문장
"""
def input_processing(input_data):
    """
    맞춤법처리, 욕설확인, 토탈값 저장처리
    """
    global swear_word
    global total_chat
    # 맞춤법 띄어쓰기
    input_sentence = processing_word(input_data)

    # swear_word=0일경우 욕설이 포함되어 있음
    swear_word = swear_word_check(input_sentence)

    # 상담사가 입력한 내용이 공백이 아닌 경우
    if input_sentence != '':
        # 멀티턴 분석을 위해 값을 저장
        total_chat += input_sentence
    return input_sentence

"""
상세보기에 전달할 값 정리
response : json : java에 반환할 json
"""
@app.route("/resultDetail", methods=["GET", 'POST'])
def detail():
    total_sentence_emotion = []
    total_sentence_sentiment = []
    total_single_emotion = []
    total_single_sentiment = []
    total_multi_emotion = []
    total_multi_sentiment = []

    multi_chatting = ''
    for i in multi_list:
        total_sentence_emotion.append(emotion_predict(emotion_model, i[0]))
        total_sentence_emotion.append(emotion_predict(emotion_model, i[1]))
        total_sentence_sentiment.append(sentiment_predict(sentiment_model, i[0]))
        total_sentence_sentiment.append(sentiment_predict(sentiment_model, i[1]))

        total_single_emotion.append(emotion_predict(emotion_model, i[0]+i[1]))
        total_single_sentiment.append(sentiment_predict(sentiment_model, i[0] + i[1]))
        multi_chatting += i[0] + i[1]
        total_multi_emotion.append(emotion_predict(emotion_model, multi_chatting))
        total_multi_sentiment.append(sentiment_predict(sentiment_model, multi_chatting))

    sentence_emotion_json = {}
    sentence_sentiment_json = {}

    for key, value in enumerate(total_sentence_emotion):
        value = make_emotion_dict(value)
        sentence_emotion_json['number'+str(key)] = value

    for key, value in enumerate(total_sentence_sentiment):
        value = make_sentiment_dict(value)
        sentence_sentiment_json['number'+str(key)] = value

    single_emotion_json = {}
    single_sentiment_json = {}


    for key, value in enumerate(total_single_emotion):
        value = make_emotion_dict(value)
        single_emotion_json['number'+str(key)] = value

    for key, value in enumerate(total_single_sentiment):
        value = make_sentiment_dict(value)
        single_sentiment_json['number'+str(key)] = value

    multi_emotion_json = {}
    multi_sentiment_json = {}

    for key, value in enumerate(total_multi_emotion):
        value = make_emotion_dict(value)
        multi_emotion_json['number'+str(key)] = value

    for key, value in enumerate(total_multi_sentiment):
        value = make_sentiment_dict(value)
        multi_sentiment_json['number'+str(key)] = value

    if len(multi_emotion_json) == 0:
        len_multi = 0
        all_emotion_json = {}
        all_sentiment_json = {}
    else:
        len_multi = len(multi_emotion_json) - 1
        all_emotion_json = multi_emotion_json['number' + str(len_multi)]
        all_sentiment_json = multi_sentiment_json['number' + str(len_multi)]

    total_json_list = [sentence_emotion_json, sentence_sentiment_json,
                       single_emotion_json, single_sentiment_json,
                       multi_emotion_json, multi_sentiment_json,
                       all_emotion_json, all_sentiment_json]
    total_json_name = ['sentence_emotion', 'sentence_sentiment',
                       'single_emotion', 'single_sentiment',
                       'multi_emotion', 'multi_sentiment',
                       'all_emotion', 'all_sentiment']
    total_json = dict(zip(total_json_name, total_json_list))
    print(total_json)

    result = json.dumps(total_json, ensure_ascii=False).encode('utf8')
    response = make_response(result)
    print(response)
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response


if __name__== '__main__':
    app.debug=True
    app.run()
