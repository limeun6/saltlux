import re
import json
from collections import OrderedDict
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer

#처음 처리 욕 모음 문장화처리
word_df= pd.read_csv("swear_word.csv")
swear_sentence=""
# 단어들을 문장으로 묶음
for i in word_df['swear_word']:
    swear_sentence= swear_sentence+" "+i

"""
문장 전처리
sentence : str : 고객/상담사가 입력한 문장
d2 : str : 처리2단계한 값
"""
def processing_word(input_text):
    """
    문장 전처리-특수문자제거,맞춤법
    """
    from hanspell import spell_checker
    # 특수문자 제거
    remove = re.sub(r"([?!])", r" \1 ", input_text)
    remove = re.sub(r"([^0-9a-zA-Z가-힣ㄱ-ㅎ!?. ])", '', remove)
    remove = remove.strip()
    
    # 맞춤법
    check = spell_checker.check(remove)

    word = ''

    for key, value in check.words.items():
        word += ' ' + key

    return word

def make_emotion_dict(emotion_result):
    emotion = ["anger", "sad", "surprise", "hatred", "hurt", "panic", "anxiety", "joy", "happy", "neutrality"]
    emotion_dic = dict(zip(emotion, emotion_result.tolist()))
    file_data = {'emotion': emotion_dic}
    return file_data

def make_sentiment_dict(sentiment_result):
    sentiment = ["positive", "negative", "middle"]
    sentiment_dic = dict(zip(sentiment, sentiment_result.tolist()))
    file_data = {'sentiment': sentiment_dic}
    return file_data

def make_dict(emotion_result, sentiment_result,swear_word):
    file_data = OrderedDict()

    emotion = ["anger", "sad", "surprise", "hatred", "hurt", "panic", "anxiety", "joy", "happy", "neutrality"]
    sentiment = ["positive", "negative", "middle"]

    emotion_dic = dict(zip(emotion, emotion_result.tolist()))
    sentiment_dic = dict(zip(sentiment, sentiment_result.tolist()))

    file_data["emotion"] = emotion_dic
    file_data["sentiment"] = sentiment_dic
    file_data["stress"] = stress_score(emotion_result, sentiment_result)
    file_data["swear"] = swear_word

    return file_data

"""
감성/감정의 결과값으로 스트레스 값을 계산
emotion_result : tensor : 감정 결과
sentiment_result : tensor : 감성 결과값
return : float : 스트레스값
"""
def stress_score(emotion_result, sentiment_result) -> float:
    '''
    감성의 결과에 따라 상담사 및 고객의 심리점수를 계산하여 반환한다.
    '''
    negative = sum(emotion_result[0:8])
    positive = sum(emotion_result[8:10])
    if sentiment_result.argmax() == 0:
        result_score = 0.7 * positive - 0.3 * negative
    elif sentiment_result.argmax() == 1:
        result_score = 0.3 * positive - 0.7 * negative
    elif sentiment_result.argmax() == 2:
        result_score = 0.5 * positive - 0.5 * negative

    # 반환값 텐서->float 2자리수에서 반올림
    return round(float(result_score * 100 / 140 * 100 + 50), 2)

"""
입력 텍스트에 욕이 포함 되어 있는가 확인
sentence : str : 고객/상담사가 입력한 값
return : int : 0: 욕설이 포함되어 있는 경우, 1: 욕설 비포함

"""
def swear_word_check(sentence):
    """
    욕설이 포함되어 있을경우 0을 반환
    """
    # 초기치 선언 0: 욕설이 포함, 1: 욕설 비포함
    result =1
    #비교 리스트화
    sentence_list=(sentence,swear_sentence)
    #문장의 벡터화
    tfidftorizer = TfidfVectorizer()
    tfidf_matrix= tfidftorizer.fit_transform(sentence_list)
    # 코사인 계산
    from sklearn.metrics.pairwise import cosine_similarity

    if cosine_similarity(tfidf_matrix)[0,1]>0.0:
        result=0
    else :
        result=1
    return result