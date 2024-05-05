## 크립토시그널 - RSI 상대강도지수 보조지표를 활용한 매매 시그널 알림 프로젝트

<aside>
💡 상대강도지수 RSI 보조지표를 통해 RSI 30 과매도 또는 RSI 70 과매수 구간을 알림을 통해 알려준다. 항상 RSI 지수를 감시할 수 없기에 알림을 통해 매매시그널을 확인할 수 있다. 또한 RSI 30은 패닉셀 구간이기에 뉴스를 확인해야되는 점에서 오피니언마이닝을 통해 긍정뉴스 부정뉴스를 구분하여 확인할 수 있다.

</aside>

## 1. 기술스택


### Backend

- maven project
- spring 4.x
- flask
    - pandas
    - numpy
- java 11
- MariaDB
- MongoDB
- MyBatis
- Spring MVC
    - Bootstrap5
    - HTML/CSS
    - JSP
    - Jquery
    

### ETC

- 업비트 API

## 2. 담당한 기능

- Bootstrap을 활용해 전체적인 페이지 개발
- Flask 서버를 통해 upbit api 통신 numpy, pandas 라이브러리를 통해 RSI 지수 계산
- Jsoup 라이브러리를 이용하여 뉴스데이터 크롤링 수집과정에서 오피니언마이닝 진행
- Spring 서버의 전체적인 Rest API 비즈니스 로직구현
- Nosql  MongoDB Collection DB구조 설계 및 활용
- RDB 테이블 구조 설계 및 활용
