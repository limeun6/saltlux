import re
import json
from collections import OrderedDict
import pandas as pd
import pickle
from hanspell import spell_checker
from soynlp.normalizer import *
import numpy as np

emotion_linear_model = pickle.load(open('emotion_ols.pkl', 'rb'))
sentiment_linear_model = pickle.load(open('sentiment_ols.pkl', 'rb'))

"""
문장 전처리
sentence : str : 고객/상담사가 입력한 문장
d2 : str : 처리2단계한 값
"""
def processing_word(input_text):
    """
    문장 전처리-특수문자제거, 중복제거, 맞춤법
    """

    word = ''

    for i in input_text.split():
        # 특수문자 제거
        remove = re.sub(r"([?!])", r" \1 ", i)
        remove = re.sub(r"([^0-9a-zA-Z가-힣ㄱ-ㅎ!?. ])", '', remove)
        remove = remove.strip()

        # 중복제거
        repeat = repeat_normalize(remove, num_repeats=2)

        # 맞춤법
        check = spell_checker.check(repeat)
        spell_check = ''
        for key, value in check.words.items():
            spell_check += ' ' + key
        spell_check = re.sub("<span class='violet_text'>", '', spell_check)
        word = word + ' ' + spell_check

    return word.lstrip()

def make_emotion_dict(emotion_result):
    emotion = ["anger", "sad", "surprise", "hurt", "panic", "anxiety", "joy", "neutrality"]
    emotion_dic = dict(zip(emotion, np.round(emotion_result.tolist(),2)))
    file_data = {'emotion': emotion_dic}
    return file_data

def make_sentiment_dict(sentiment_result):
    sentiment = ["positive", "negative", "middle"]
    sentiment_dic = dict(zip(sentiment, np.round(sentiment_result.tolist(),2)))
    file_data = {'sentiment': sentiment_dic}
    return file_data

"""
대화중의 스트레스값을 계산해서 반환
emotion_result : tensor : 감정 결과값
sentiment_result : tensor : 감정 결과값
swear_word : int : 욕설 포함 여부
"""
def make_dict(emotion_result, sentiment_result):
    """
    모델을 통해 취득한 감정/감성값을 json으로 정리
    """
    file_data = OrderedDict()
    # 감정 항목
    emotion = ["anger", "sad", "surprise", "hurt", "panic", "anxiety", "joy", "neutrality"]
    # 감성 항목
    sentiment = ["positive", "negative", "middle"]

    # 항목에 따라 값 설정
    emotion_dic = dict(zip(emotion, np.round(emotion_result.tolist(),2)))
    sentiment_dic = dict(zip(sentiment, np.round(sentiment_result.tolist(),2)))

    # json에 값 추가
    file_data["emotion"] = emotion_dic
    file_data["sentiment"] = sentiment_dic
    stress = stress_score(emotion_result, sentiment_result)
    file_data["stress"] = stress[0]

    return file_data

"""
감성/감정의 결과값으로 스트레스 값을 계산
emotion_result : tensor : 감정 결과
sentiment_result : tensor : 감성 결과값
return : float : 스트레스값
"""
def stress_score(stress_emotion, stress_sentiment) -> float:
    stress_emotion = stress_emotion.tolist()
    stress_sentiment = stress_sentiment.tolist()
    emotion_cols=['anger', 'sad', 'surprise', 'hurt', 'panic', 'anxiety', 'joy', 'neutrality']
    sentiment_cols = ['positive', 'negative', 'neutrality']
    emotion_result = pd.DataFrame([stress_emotion], columns=emotion_cols)
    sentiment_result = pd.DataFrame([stress_sentiment], columns=sentiment_cols)
    linear_result_emotion = emotion_linear_model.predict(emotion_result[emotion_cols])
    linear_result_sentiment = sentiment_linear_model.predict(sentiment_result[sentiment_cols])
    if linear_result_emotion[0] < 0 :
      linear_result_emotion[0] = 0
    if linear_result_emotion[0] > 4 :
      linear_result_emotion[0] = 4
    if linear_result_sentiment[0] < 0 :
      linear_result_sentiment[0] = 0
    if linear_result_sentiment[0] > 4 :
      linear_result_sentiment[0] = 4
    return round((linear_result_emotion*0.3 + linear_result_sentiment*0.7) * 25,2)

"""
입력 텍스트에 욕이 포함 되어 있는가 확인
sentence : str : 고객/상담사가 입력한 값
return : int : 0: 욕설이 포함되어 있는 경우, 1: 욕설 비포함
"""
