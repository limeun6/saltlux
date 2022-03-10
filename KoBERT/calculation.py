import re
import json
from collections import OrderedDict
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Kkma
import pickle

emotion_linear_model = pickle.load(open('emotion_ols.pkl', 'rb'))
sentiment_linear_model = pickle.load(open('sentiment_ols.pkl', 'rb'))

#처음 처리 욕 모음 문장화처리
word_df = pd.read_csv("swear_word.csv")
swear_sentence = ""
# 단어들을 문장으로 묶음
for i in word_df['swear_word']:
    swear_sentence = swear_sentence + " " + i

tfidftorizer = TfidfVectorizer()
kkma = Kkma()

"""
문장 전처리
sentence : str : 고객/상담사가 입력한 문장
d2 : str : 처리2단계한 값
"""
def processing_word(input_text):
    """
    문장 전처리-특수문자제거, 중복제거, 맞춤법
    """
    from hanspell import spell_checker
    # 특수문자 제거
    remove = re.sub(r"([?!])", r" \1 ", input_text)
    remove = re.sub(r"([^0-9a-zA-Z가-힣ㄱ-ㅎ!?. ])", '', remove)
    remove = remove.strip()

    # 중복제거


    # 맞춤법
    check = spell_checker.check(remove)

    word = ''

    for key, value in check.words.items():
        word += ' ' + key

    return word

def make_emotion_dict(emotion_result):
    emotion = ["anger", "sad", "surprise", "hurt", "panic", "anxiety", "joy", "neutrality"]
    emotion_dic = dict(zip(emotion, emotion_result.tolist()))
    file_data = {'emotion': emotion_dic}
    return file_data

def make_sentiment_dict(sentiment_result):
    sentiment = ["positive", "negative", "middle"]
    sentiment_dic = dict(zip(sentiment, sentiment_result.tolist()))
    file_data = {'sentiment': sentiment_dic}
    return file_data

"""
대화중의 스트레스값을 계산해서 반환
emotion_result : tensor : 감정 결과값
sentiment_result : tensor : 감정 결과값
swear_word : int : 욕설 포함 여부
"""
def make_dict(emotion_result, sentiment_result,swear_word):
    """
    모델을 통해 취득한 감정/감성값을 json으로 정리
    """
    file_data = OrderedDict()
    # 감정 항목
    emotion = ["anger", "sad", "surprise", "hurt", "panic", "anxiety", "joy", "neutrality"]
    # 감성 항목
    sentiment = ["positive", "negative", "middle"]

    # 항목에 따라 값 설정
    emotion_dic = dict(zip(emotion, emotion_result.tolist()))
    sentiment_dic = dict(zip(sentiment, sentiment_result.tolist()))

    # jso에 값 추가
    file_data["emotion"] = emotion_dic
    file_data["sentiment"] = sentiment_dic
    stress = stress_score(emotion_result, sentiment_result)
    print(stress)
    file_data["stress"] = stress[0]
    print(file_data["stress"])
    file_data["swear"] = swear_word

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
def swear_word_check(sentence):
    """
    욕설이 포함되어 있을경우 0을 반환
    """
    # 초기치 선언 0: 욕설이 포함, 1: 욕설 비포함
    result =1
    # 형태소분석
    sentence_word=""
    # 문장의 명사만을 돌려받음
    sentence_word_list = kkma.nouns(sentence)
    for i in sentence_word_list:
        sentence_word = sentence_word+" "+i
    #비교 리스트화
    sentence_list = (sentence_word, swear_sentence)
    #문장의 벡터화
    tfidf_matrix = tfidftorizer.fit_transform(sentence_list)
    # 코사인 계산
    from sklearn.metrics.pairwise import cosine_similarity
    if cosine_similarity(tfidf_matrix)[0, 1] > 0.0:
        result = 0
    else:
        result = 1
    return result