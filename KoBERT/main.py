from flask import Flask, render_template, request, jsonify, make_response
import json
from threading import Thread

from model import *
from calculation import *
from multi import *
from flask_socketio import SocketIO, send
from collections import OrderedDict

app = Flask(__name__)
total_counselor = {}

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
    customer_chat = request.form.get('customerInput')
    counselor_chat = request.form.get('counselorInput')
    sep = request.form.get("sep")

    if sep in total_counselor.keys():
        person = total_counselor[sep]
    else:
        total_counselor[sep] = counselor_object()
        person = total_counselor[sep]

    if customer_chat != None:
        result = person.chatting_counselor(customer_chat=customer_chat)
    else:
        result = person.chatting_counselor(counselor_chat=counselor_chat)
    result = json.dumps(result, ensure_ascii=False).encode('utf8')
    response = make_response(result)
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response





"""
입력내용 공통처리부분 함수화
input_data : str : 입력된 문장
input_sentence : str : 공통처리 후 문장
"""

"""
상세보기에 전달할 값 정리
response : json : java에 반환할 json
"""
@app.route("/resultDetail", methods=["GET", 'POST'])
def detail():
    sep_detail = request.get_json("sep")
    detail_person = total_counselor[sep_detail]
    total_sentence_emotion = []
    total_sentence_sentiment = []
    total_single_emotion = []
    total_single_sentiment = []
    total_multi_emotion = []
    total_multi_sentiment = []

    multi_chatting = ''
    for i in detail_person.multi_list:
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

    result = json.dumps(total_json, ensure_ascii=False).encode('utf8')
    response = make_response(result)
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response

if __name__ == '__main__':
    app.debug = True
    app.run()
