import re
import json
from collections import OrderedDict

def processing_word(input_text):
    from hanspell import spell_checker

    remove = re.sub(r"([?!])", r" \1 ", input_text)
    remove = re.sub(r"([^0-9a-zA-Z가-힣ㄱ-ㅎ!?. ])", '', remove)
    remove = remove.strip()

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

def make_dict(emotion_result, sentiment_result):
    file_data = OrderedDict()

    emotion = ["anger", "sad", "surprise", "hatred", "hurt", "panic", "anxiety", "joy", "happy", "neutrality"]
    sentiment = ["positive", "negative", "middle"]

    emotion_dic = dict(zip(emotion, emotion_result.tolist()))
    sentiment_dic = dict(zip(sentiment, sentiment_result.tolist()))

    file_data["emotion"] = emotion_dic
    file_data["sentiment"] = sentiment_dic
    file_data["Stress"] = stress_score(emotion_result, sentiment_result)

    return file_data

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