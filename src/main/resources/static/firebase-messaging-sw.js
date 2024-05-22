importScripts('https://www.gstatic.com/firebasejs/8.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.0.0/firebase-messaging.js');

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