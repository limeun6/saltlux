from calculation import *
from model import *
from flask import make_response
# 모델 생성
sentiment_model = make_model(3)
emotion_model = make_model(8)

class counselor_object:
    def __init__(self):
        self.multi_list = []
        self.customer = ''
        self.counselor = ''
        self.total_chat = ''

    def chatting_counselor(self, customer_chat=None, counselor_chat=None):
        if customer_chat != None:
            # 싱글턴의 내용을 저장하기 위해서 과거 상담사가 입력한 내용이 공백이 아닌경우
            if self.counselor != '':
                # 멀티턴 대화에 고객, 상담사의 내용을 추가
                self.multi_list.append([self.customer, self.counselor])
                # 저장소를 초기화
                self.counselor = ''
                self.customer = ''

            # 입력값 처리
            input_customer = processing_word(customer_chat)
            self.customer += ' ' + input_customer
            self.total_chat += ' ' + input_customer

            # 고객의 감정값을 취득(문장)
            emotion_result = emotion_predict(emotion_model, input_customer)
            # 고객의 감성값을 취득(문장)
            sentiment_result = sentiment_predict(sentiment_model, input_customer)
            # 입력을 상담사가 한 경우
        else:
            # 입력값 처리
            input_counselor = processing_word(counselor_chat)
            self.counselor += ' ' + input_counselor
            self.total_chat += ' ' + input_counselor

            # 상담사의 감정값을 취득(멀티턴)
            emotion_result = emotion_predict(emotion_model, self.total_chat)
            # 상담사의 감성값을 취득(멀티턴)
            sentiment_result = sentiment_predict(sentiment_model, self.total_chat)

            # 저장값 확인
        # print('customer' + self.customer)
        # print('counselor' + self.counselor)
        # print('total_chat' + self.total_chat)
        # print(self.multi_list)

        result = make_dict(emotion_result, sentiment_result)

        return result