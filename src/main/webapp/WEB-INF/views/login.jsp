<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/login.css" type="text/css"/>
</head>

<body>

    <img src="image/Logo2.png" style="width: 90%">
    <input id="sId" placeholder="학번을 입력해주세요.">
    <div id="enter" onclick="enter()">입장하기</div>
    <span id="alertSpan">알람 허용 팝업이 뜨면, 반드시 허용해 주세요</span>

</body>
<script>
    setTimeout(function () {
        if (localStorage.getItem('sm_sid') !== null) {
            sid = localStorage.getItem('sm_sid');
            location.href='/index?sid=' + sid;
        }
    }, 1000);

    function enter() {

        var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
        if ( varUA.indexOf("iphone") > -1 || varUA.indexOf("ipad") > -1 || varUA.indexOf("ipod") > -1 ) {
            alert("아이폰 유저라면, 하단의 공유 버튼 → '홈 화면에 추가'해주신 후, 홈 화면에서 실행해 주세요.");
        } else {

        }

        messaging.requestPermission()
            .then(function () {
                var token = messaging.getToken();
                return token;
            })
            .then(async function (token) {
                sid = document.getElementById('sId').value;
                localStorage.setItem('sm_sid', sid);
                location.href='/logindex?sid=' + sid + '&token=' + token;
            });
    }
</script>
</html>
