<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #Menu {
            background-color: #efece4;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 200px;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .menuButton {
            width: 24%;
            height: 130px;
            border-radius: 6px;
            cursor: pointer;

            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
        }
        .menuImg {
            height: 90%;
        }
    </style>
</head>
<body>
    <div id="Menu" style="border-top: 5px solid black">
        <div class="menuButton" onclick="location.href='/index?sid=' + localStorage.getItem('sm_sid')">
            <img src="image/menu/home.png" class="menuImg">
        </div>
        <div class="menuButton" onclick="location.href='/location'">
            <img src="image/menu/location.png" class="menuImg">
        </div>
        <div class="menuButton" onclick="location.href='/schedule'">
            <img src="image/menu/schedule.png" class="menuImg">
        </div>
        <div class="menuButton" onclick="location.href='/weather'">
            <img src="image/menu/weather.png" class="menuImg">
        </div>
    </div>
</body>
</html>