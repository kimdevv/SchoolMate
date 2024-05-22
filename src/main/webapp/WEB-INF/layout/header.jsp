<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-messaging.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&display=swap" rel="stylesheet">
    <title>School Mate</title>


    <style>
        body {
            background-color: #efece4;

            font-family: 'Do Hyeon';
            transform: rotate(0.04deg);
        }
        input {
            font-family: 'Do Hyeon';
            transform: rotate(0.04deg);
        }
        textarea {
            font-family: 'Do Hyeon';
            transform: rotate(0.04deg);
        }
    </style>

    <link rel="manifest" href="/manifest.json" />
    <script type="module">
        import 'https://cdn.jsdelivr.net/npm/@pwabuilder/pwaupdate';
        const el = document.createElement('pwa-update');
        document.body.appendChild(el);
    </script>
</head>

<script>
    ////////////////////////////////////// 푸시 전송 시작 //////////////////////////////////////
    const firebaseConfig = {
        apiKey: "AIzaSyAvuOAKvgRPscwaq4NqNMXvCPgYR1tNZZQ",
        authDomain: "schoolmate-8966b.firebaseapp.com",
        projectId: "schoolmate-8966b",
        storageBucket: "schoolmate-8966b.appspot.com",
        messagingSenderId: "645790550264",
        appId: "1:645790550264:web:335d7e327071c8ce01530d"
    };
    firebase.initializeApp(firebaseConfig);
    const messaging = firebase.messaging();
</script>
</html>