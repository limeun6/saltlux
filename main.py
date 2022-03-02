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

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/test1', methods=['GET','POST'])
def rest_api_test1():
    print(request.method)
    data={'0':'0.01','1':'0.99' }
    if request.method =='GET':
        param = request.args.get('data')
        print(param)
        data.update({'param':param})

    elif request.method =='POST':
        param = request.form.get('data')
        print(param)
        f= request.files['file']
        f.save(f.filename)
        data.update({'param': param, 'file':f.filename})

    response= make_response(jsonify(data))
    response.headers.add("Access-Control-Allow-Origin", "*")
    return jsonify(data)


@app.route('/test_img',	methods=['POST'])
def rest_img_test():
    param=request.form.get('data')
    print(param)
    f=request.files['file']
    filestr	=f.read()
    npimg=np.fromstring(filestr,np.uint8)
    img = cv2.imdecode(npimg,cv2.IMREAD_COLOR)
    img_gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    cv2.imwrite(f.filename,	img_gray)
    img_str	=base64.b64encode(cv2.imencode('.jpg',img_gray)[1]).decode()
    data={"param":param,"file":img_str}
    response=make_response(jsonify(data))
    response.headers.add("Access-Control-Allow-Origin",	"*")
    return response


@app.route("/ai_bot", methods=["POST"])
def ai_bot():
    question = request.form.get('question')
    answer= predict(question)
    response=make_response(jsonify(answer))
    response.headers.add("Access-Control-Allow-Origin",	"*")
    return response

@app.route("/chatting", methods=["POST"])
def chatting():
    #자바에서 들어온 값
    customerInput = request.form.get('customerInput')
    print(customerInput)
    # 감정/감성분석결과 
    #answer = predict(customerInput)
    #answer의 값을 json으로 변환
    #분노, 슬픔, 놀람, 혐오, 상처, 당황, 불안, 기쁨, 행복, 중립
    answer=[200,300,400,500,600,700,800,900,100,2000,300]
    title=["anger","sad","surprise","hatred","hurt","panic","anxiety","joy","happy","neutrality","stress"]
    #for i in range(0,10):
       # result={'type':title[i],'score':answer[i]}
    #print(type(result))
    #print(result)
    result={
        "result":[
            {
            "type":title[10],
            "score":answer[0]
            }
            ,
            {
            "type":title[1],
            "score":answer[1]
            }
            ]
        }
    #print(type(result))

    emotion = 200
    #자바에 값을 반환
    response=make_response(jsonify(result))
    response.headers.add("Access-Control-Allow-Origin",	"*")
    return response

if __name__== '__main__':
    app.debug=True
    app.run()
