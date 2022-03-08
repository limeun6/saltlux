from flask import Flask, render_template, request, jsonify, make_response
import json

from model import *
from calculation import *
from collections import OrderedDict

app = Flask(__name__)

sentiment_model = make_model(3)
emotion_model = make_model(10)

multi_list = []
customer = ''
counselor = ''
total_chat = ''
start = True


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
    global customer
    global counselor
    global total_chat
    if customer_chat != None:
        if counselor != '':
            multi_list.append([customer, counselor])
            counselor = ''
            customer = ''
        input_customer = processing_word(customer_chat)
        if input_customer != '':
            customer += input_customer
            total_chat += input_customer

        emotion_result = emotion_predict(emotion_model, input_customer)
        sentiment_result = sentiment_predict(sentiment_model, input_customer)


    else:
        input_counselor = processing_word(counselor_chat)
        if input_counselor != '':
            counselor += input_counselor
            total_chat += input_counselor

        emotion_result = emotion_predict(emotion_model, total_chat)
        sentiment_result = sentiment_predict(sentiment_model, total_chat)

    print(stress_score(emotion_result, sentiment_result))

    result = make_dict(emotion_result, sentiment_result)
    result = json.dumps(result, ensure_ascii=False).encode('utf8')
    response = make_response(result)
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response


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
