import pandas as pd
import re

"""
감성/감정의 결과값으로 스트레스 값을 계산
emotion_result : tensor : 감정 결과
sentiment_result : tensor : 감성 결과값
return : float : 스트레스값
"""
def stress_score(emotion_result,sentiment_result) -> float:
    '''
    감성의 결과에 따라 상담사 및 고객의 심리점수를 계산하여 반환한다.
    '''
    negative = sum(emotion_result[0:8])
    positive = sum(emotion_result[8:10])
    if sentiment_result.argmax()==0:
        result_score = 0.7*positive - 0.3*negative
    elif sentiment_result.argmax()==1:
        result_score = 0.3*positive - 0.7*negative
    elif sentiment_result.argmax()==2:
        result_score = 0.5*positive - 0.5*negative
        
    #반환값 텐서->float 2자리수에서 반올림
    return round(float(result_score*100/140*100+ 50),2)

"""
문장 전처리
sentence : str : 고객/상담사가 입력한 문장
d2 : str : 처리2단계한 값
"""
def after_sentence(sentence:str) -> str:
    """
    문장 전처리-특수문자제거,맞춤법
    """
    take1=remove_signal(sentence)
    take2=spelling_spacing_words(take1)
    return take2

"""
특수문자 제거
sentence: str : 고객/상담사가 입력한 문장
remove : str : 처리후 문장
"""
def remove_signal(sentence:str)->str:
    """
    특수문자 제거
    """
    remove = re.sub(r"([?!])",r" \1 ",sentence)
    remove = re.sub(r"([^0-9a-zA-Z가-힣ㄱ-ㅎ!?. ])",'',remove)
    remove = remove.strip()
    return remove


"""
맞춤법,띄어쓰기 수정
sentence: str : 고객/상담사가 입력한 문장
word : str : 처리후 문장
"""
def spelling_spacing_words(sentence:str) -> str:
    """
    맞춤법,띄어쓰기
    """
    from hanspell import spell_checker
    check = spell_checker.check(sentence)
    word = ''

    for key, value in check.words.items():
        word += ' ' + key
    return word