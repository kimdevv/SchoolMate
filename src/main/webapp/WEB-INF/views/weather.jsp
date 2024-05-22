<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/weather.css" type="text/css"/>
</head>
<body>
    <div id="Container">
        <div id="titleDiv">
            <img src="image/Logo2.png" width="130px" style="margin-right: 50px">
            <span>Today's Weather</span>
        </div>

        <div>
            <div class="weatherContainer">
                <span id="homeStartSpan" class="stationSpan" style="font-size: 40px; margin-right: 50px">등교<br>출발</span>
                <div class="weatherDiv">
                    <img id="homeStartWeather">
                    <div style="margin-right: 20px">
                        <div>
                            <span id="homeStartTemp">출발 역을 설정해 주세요.</span>
                            <span>&nbsp&nbsp&nbsp</span>
                            <span id="homeStartTime"></span>
                        </div>
                        <div>
                            <span class="minTemp"></span>
                            /
                            <span class="maxTemp"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="weatherContainer">
                <span id="schoolStartSpan" class="stationSpan" style="font-size: 40px; margin-right: 50px">등교<br>도착</span>
                <div class="weatherDiv">
                    <img id="schoolStartWeather">
                    <div style="margin-right: 20px">
                        <div>
                            <span id="schoolStartTemp">도착 역을 설정해 주세요.</span>
                            <span>&nbsp&nbsp&nbsp</span>
                            <span id="schoolStartTime"></span>
                        </div>
                        <div>
                            <span class="minTemp"></span>
                            /
                            <span class="maxTemp"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="weatherContainer">
                <span id="schoolEndSpan" class="stationSpan" style="font-size: 40px; margin-right: 50px">하교<br>출발</span>
                <div class="weatherDiv">
                    <img id="schoolEndWeather">
                    <div style="margin-right: 20px">
                        <div>
                            <span id="schoolEndTemp">도착 역을 설정해 주세요.</span>
                            <span>&nbsp&nbsp&nbsp</span>
                            <span id="schoolEndTime"></span>
                        </div>
                        <div>
                            <span class="minTemp"></span>
                            /
                            <span class="maxTemp"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="weatherContainer">
                <span id="homeEndSpan" class="stationSpan" style="font-size: 40px; margin-right: 50px">하교<br>도착</span>
                <div class="weatherDiv">
                    <img id="homeEndWeather">
                    <div style="margin-right: 20px">
                        <div>
                            <span id="homeEndTemp">출발 역을 설정해 주세요.</span>
                            <span>&nbsp&nbsp&nbsp</span>
                            <span id="homeEndTime"></span>
                        </div>
                        <div>
                            <span class="minTemp"></span>
                            /
                            <span class="maxTemp"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    </div>

    <%@ include file="../layout/menu.jsp"%>
</body>

<script>
    var homeStartTemp = null;
    var homeStartWeather = null;
    var schoolStartTemp = null;
    var schoolStartWeather = null;
    var schoolEndTemp = null;
    var schoolEndWeather = null;
    var homeEndTemp = null;
    var homeEndWeather = null;

    var minTemp = 50;
    var maxTemp = -50;

    let data = {
        studentId: localStorage.getItem('sm_sid')
    }

    // 요일 별 시간 가져오기
    var day = new Date().getDay();
    var startTimereal = null;
    var startTime = null;
    var endTime = null;
    var endTimereal = null;

    $.ajax({
        type: "POST",
        url: "/getSchedule",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        switch (day) {
            case 0:
                if (resp.sunStartTime < 10) {
                    startTimereal = "0" + (resp.sunStartTime-1) + "00";
                    startTime = "0" + resp.sunStartTime + "00";
                } else if (resp.sunStartTime == 10) {
                    startTimereal = "0" + (resp.sunStartTime-1) + "00";
                    startTime = resp.sunStartTime + "00";
                } else {
                    startTimereal = (resp.sunStartTime-1) + "00";
                    startTime = resp.sunStartTime + "00";
                }
                if (resp.sunEndTime < 9) {
                    endTime = "0" + resp.sunEndTime + "00";
                    endTimereal = "0" + (resp.sunEndTime+1) + "00";
                } else if (resp.sunEndTime == 9) {
                    endTime = "0" + resp.sunEndTime + "00";
                    endTimereal = (resp.sunEndTime+1) + "00";
                } else {
                    endTime = resp.sunEndTime + "00";
                    endTimereal = (resp.sunEndTime+1) + "00";
                }
                break;
            case 1:
                if (resp.monStartTime < 10) {
                    startTimereal = "0" + (resp.monStartTime-1) + "00";
                    startTime = "0" + resp.monStartTime + "00";
                } else if (resp.monStartTime == 10) {
                    startTimereal = "0" + (resp.monStartTime-1) + "00";
                    startTime = resp.monStartTime + "00";
                } else {
                    startTimereal = (resp.monStartTime-1) + "00";
                    startTime = resp.monStartTime + "00";
                }
                if (resp.monEndTime < 9) {
                    endTime = "0" + resp.monEndTime + "00";
                    endTimereal = "0" + (resp.monEndTime+1) + "00";
                } else if (resp.monEndTime == 9) {
                    endTime = "0" + resp.monEndTime + "00";
                    endTimereal = (resp.monEndTime+1) + "00";
                } else {
                    endTime = resp.monEndTime + "00";
                    endTimereal = (resp.monEndTime+1) + "00";
                }
                break;
            case 2:
                if (resp.tueStartTime < 10) {
                    startTimereal = "0" + (resp.tueStartTime-1) + "00";
                    startTime = "0" + resp.tueStartTime + "00";
                } else if (resp.tueStartTime == 10) {
                    startTimereal = "0" + (resp.tueStartTime-1) + "00";
                    startTime = resp.tueStartTime + "00";
                } else {
                    startTimereal = (resp.tueStartTime-1) + "00";
                    startTime = resp.tueStartTime + "00";
                }
                if (resp.tueEndTime < 9) {
                    endTime = "0" + resp.tueEndTime + "00";
                    endTimereal = "0" + (resp.tueEndTime+1) + "00";
                } else if (resp.tueEndTime == 9) {
                    endTime = "0" + resp.tueEndTime + "00";
                    endTimereal = (resp.tueEndTime+1) + "00";
                } else {
                    endTime = resp.tueEndTime + "00";
                    endTimereal = (resp.tueEndTime+1) + "00";
                }
                break;
            case 3:
                if (resp.wedStartTime < 10) {
                    startTimereal = "0" + (resp.wedStartTime-1) + "00";
                    startTime = "0" + resp.wedStartTime + "00";
                } else if (resp.wedStartTime == 10) {
                    startTimereal = "0" + (resp.wedStartTime-1) + "00";
                    startTime = resp.wedStartTime + "00";
                } else {
                    startTimereal = (resp.wedStartTime-1) + "00";
                    startTime = resp.wedStartTime + "00";
                }
                if (resp.wedEndTime < 9) {
                    endTime = "0" + resp.wedEndTime + "00";
                    endTimereal = "0" + (resp.wedEndTime+1) + "00";
                } else if (resp.wedEndTime == 9) {
                    endTime = "0" + resp.wedEndTime + "00";
                    endTimereal = (resp.wedEndTime+1) + "00";
                } else {
                    endTime = resp.wedEndTime + "00";
                    endTimereal = (resp.wedEndTime+1) + "00";
                }
                break;
            case 4:
                if (resp.thurStartTime < 10) {
                    startTimereal = "0" + (resp.thurStartTime-1) + "00";
                    startTime = "0" + resp.thurStartTime + "00";
                } else if (resp.thurStartTime == 10) {
                    startTimereal = "0" + (resp.thurStartTime-1) + "00";
                    startTime = resp.thurStartTime + "00";
                } else {
                    startTimereal = (resp.thurStartTime-1) + "00";
                    startTime = resp.thurStartTime + "00";
                }
                if (resp.thurEndTime < 9) {
                    endTime = "0" + resp.thurEndTime + "00";
                    endTimereal = "0" + (resp.thurEndTime+1) + "00";
                } else if (resp.thurEndTime == 9) {
                    endTime = "0" + resp.thurEndTime + "00";
                    endTimereal = (resp.thurEndTime+1) + "00";
                } else {
                    endTime = resp.thurEndTime + "00";
                    endTimereal = (resp.thurEndTime+1) + "00";
                }
                break;
            case 5:
                if (resp.friStartTime < 10) {
                    startTimereal = "0" + (resp.friStartTime-1) + "00";
                    startTime = "0" + resp.friStartTime + "00";
                } else if (resp.friStartTime == 10) {
                    startTimereal = "0" + (resp.friStartTime-1) + "00";
                    startTime = resp.friStartTime + "00";
                } else {
                    startTimereal = (resp.friStartTime-1) + "00";
                    startTime = resp.friStartTime + "00";
                }
                if (resp.friEndTime < 9) {
                    endTime = "0" + resp.friEndTime + "00";
                    endTimereal = "0" + (resp.friEndTime+1) + "00";
                } else if (resp.friEndTime == 9) {
                    endTime = "0" + resp.friEndTime + "00";
                    endTimereal = (resp.friEndTime+1) + "00";
                } else {
                    endTime = resp.friEndTime + "00";
                    endTimereal = (resp.friEndTime+1) + "00";
                }
                break;
            case 6:
                if (resp.satStartTime < 10) {
                    startTimereal = "0" + (resp.satStartTime-1) + "00";
                    startTime = "0" + resp.satStartTime + "00";
                } else if (resp.satStartTime == 10) {
                    startTimereal = "0" + (resp.satStartTime-1) + "00";
                    startTime = resp.satStartTime + "00";
                } else {
                    startTimereal = (resp.satStartTime-1) + "00";
                    startTime = resp.satStartTime + "00";
                }
                if (resp.satEndTime < 9) {
                    endTime = "0" + resp.satEndTime + "00";
                    endTimereal = "0" + (resp.satEndTime+1) + "00";
                } else if (resp.satEndTime == 9) {
                    endTime = "0" + resp.satEndTime + "00";
                    endTimereal = (resp.satEndTime+1) + "00";
                } else {
                    endTime = resp.satEndTime + "00";
                    endTimereal = (resp.satEndTime+1) + "00";
                }
                break;
        }
    }).fail(function (error) {
        alert("요일을 불러오는 데 실패하였습니다.");
        console.log(error)
    })

    $.ajax({
        type: "POST",
        url: "/getHomeWeather",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        var jsono = JSON.parse(resp);
        var items = jsono.response.body.items.item;

        // 시간이 입력되어있지 않다면 09:00 ~ 18:00으로 초기화
        if (startTime == "0000") {
            startTimereal = "0800";
            startTime = "0900";
        }
        if (endTime == "0000") {
            endTime = "1800"
            endTimereal = "1900"
        }

        for (var i=0; i<items.length; i++) {
            if (items[i].category === "TMP") {
                let temp = items[i].fcstValue;
                if (temp > maxTemp) maxTemp = temp;
                if (temp < minTemp) minTemp = temp;
            }

            // 등교출발 날씨 구하기
            if (items[i].fcstTime === startTimereal && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    homeStartWeather = "sunny";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    homeStartWeather = "cloud";
                } else { // 나머지는 비
                    homeStartWeather = "rain"
                }
            }
            // 등교출발 기온 구하기
            if (items[i].fcstTime === startTimereal && items[i].category === "TMP") {
                homeStartTemp = items[i].fcstValue;
            }

            // 하교도착 날씨 구하기
            if (items[i].fcstTime === endTimereal && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    homeEndWeather = "sunny";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    homeEndWeather = "cloud";
                } else { // 나머지는 비
                    homeEndWeather = "rain"
                }
            }
            // 하교도착 기온 구하기
            if (items[i].fcstTime === endTimereal && items[i].category === "TMP") {
                homeEndTemp = items[i].fcstValue;
            }

            var minTemps = document.getElementsByClassName("minTemp");
             for (var j=0; j<minTemps.length; j++) {
                 minTemps[j].innerText = "Low " + minTemp + "°C ";
              }
             var maxTemps = document.getElementsByClassName("maxTemp");
             for (var j=0; j<maxTemps.length; j++) {
                 maxTemps[j].innerText = " High " + maxTemp + "°C";
             }

            document.getElementById("homeStartTemp").innerText = homeStartTemp + "°C";
            document.getElementById("homeStartWeather").src = "image/weather/" + homeStartWeather + ".png";
            if (startTimereal < 1200) {
                document.getElementById("homeStartTime").innerText = (startTimereal/100) + ":00 A.M.";
            } else {
                document.getElementById("homeStartTime").innerText = (startTimereal/100) + ":00 P.M.";
            }

            document.getElementById("homeEndTemp").innerText = homeEndTemp + "°C";
            document.getElementById("homeEndWeather").src = "image/weather/" + homeEndWeather + ".png";
            if (startTimereal < 1200) {
                document.getElementById("homeEndTime").innerText = (endTimereal/100) + ":00 A.M.";
            } else {
                document.getElementById("homeEndTime").innerText = (endTimereal/100) + ":00 P.M.";
            }
        }
    }).fail(function (error) {
        console.log(error);
    })

    $.ajax({
        type: "POST",
        url: "/getSchoolWeather",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        var jsono = JSON.parse(resp);
        var items = jsono.response.body.items.item;

        // 시간이 입력되어있지 않다면 09:00 ~ 18:00으로 초기화
        if (startTime == "0000") {
            startTimereal = "0800";
            startTime = "0900";
        }
        if (endTime == "0000") {
            endTime = "1800"
            endTimereal = "1900"
        }

        for (var i=0; i<items.length; i++) {
            // 등교도착 날씨 구하기
            if (items[i].fcstTime === startTime && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    schoolStartWeather = "sunny";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    schoolStartWeather = "cloud";
                } else { // 나머지는 비
                    schoolStartWeather = "rain"
                }
            }
            // 등교도착 기온 구하기
            if (items[i].fcstTime === startTime && items[i].category === "TMP") {
                schoolStartTemp = items[i].fcstValue;
            }
            // 하교출발 날씨 구하기
            if (items[i].fcstTime === endTime && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    schoolEndWeather = "sunny";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    schoolEndWeather = "cloud";
                } else { // 나머지는 비
                    schoolEndWeather = "rain"
                }
            }
            // 하교출발 기온 구하기
            if (items[i].fcstTime === endTime && items[i].category === "TMP") {
                schoolEndTemp = items[i].fcstValue;
            }

            document.getElementById("schoolStartTemp").innerText = schoolStartTemp + "°C";
            document.getElementById("schoolStartWeather").src = "image/weather/" + schoolStartWeather + ".png";
            if (startTimereal < 1200) {
                document.getElementById("schoolStartTime").innerText = (startTime/100) + ":00 A.M.";
            } else {
                document.getElementById("schoolStartTime").innerText = (startTime/100) + ":00 P.M.";
            }

            document.getElementById("schoolEndTemp").innerText = schoolEndTemp + "°C";
            document.getElementById("schoolEndWeather").src = "image/weather/" + schoolEndWeather + ".png";
            if (startTimereal < 1200) {
                document.getElementById("schoolEndTime").innerText = (endTime/100) + ":00 A.M.";
            } else {
                document.getElementById("schoolEndTime").innerText = (endTime/100) + ":00 P.M.";
            }
        }
    }).fail(function (error) {
        console.log(error);
    })

    $.ajax({
        type: "POST",
        url: "/findLocation",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        document.getElementById("homeStartSpan").innerText = resp.startName + "\r\n출발";
        document.getElementById("schoolStartSpan").innerText = resp.endName + "\r\n도착";
        document.getElementById("schoolEndSpan").innerText = resp.endName + "\r\n출발";
        document.getElementById("homeEndSpan").innerText = resp.startName + "\r\n도착";
    }).fail(function (error) {
        alert("설정된 역 정보를 가져오는 데 실패하였습니다.");
        console.log(error);
    })

</script>
</html>
