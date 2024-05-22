**[SchoolMate]**

SUFY를 만들어서 일상에서 유용하게 사용하다가... 컴퓨터논리개론 수업에서 갑작스레 나온 팀 프로젝트로 인해 급하게 만든 서비스...

SUFY에 있는 푸시 알림 기능에다가 시간표 등록, 날씨 조회, 미세먼지 조회 등을 간편하게 할 수 있는 기능을 넣었다!

<br>

**사용한 기술 스택**
- SpringBoot
- MySQL와 JPA
- HTML, CSS
- JavaScript
- 서울시 REST API
- 카카오 REST API
- 기상청 REST API
- Firebase Cloud Messaging
- PWA Application

<br>

**구현한 기능**
- 모든 지하철 역 DB에 등록 및 조회
- 서울시 공공 API를 활용한 실시간 지하철 위치 조회
- 지하철과 목적지 역을 선택한 후, 알림 객체를 DB에 등록
- @Scheduled을 활용해서 3초마다 실시간 지하철 위치 조회한 후, 푸시 대상자 확인
- Firebase Cloud Message를 활용한 디바이스 별 푸시 알림 전송
- PWA앱을 적용해서 iOS에서도 푸시가 전송되도록 하기
- 기상청 단기예보 REST API를 활용해 매일 자정 출발 시간대와 하교 시간대의 날씨를 조회
- 서울시 REST API를 활용해 매일 자정에 학교의 미세먼지 상태를 조회

<br>

API의 경우, SUFY와 거의 동일하며 기상청과 서울시에서 날씨 단기예보와 미세먼지 상태를 조회해서 응답해주는 API만 추가되었기에 따로 명세하지 않겠습니다.
