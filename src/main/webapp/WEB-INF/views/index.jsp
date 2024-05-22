<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/index.css" type="text/css"/>
</head>
<body>
    <div id="titleDiv">
        <img src="image/Logo2.png" width="130px" style="margin-right: 50px">
        <span>School Mate</span>
    </div>

    <div id="scheduleContainer">
        <div style="margin-left: 20px">
            <span id="dateSpan" style="font-size: 40px"></span>
            <br>
            <span id="daySpan" style="font-size: 40px"></span>
        </div>
        <div style="margin-left: 50px">
            <span id="startTime" style="font-size: 50px; border-left: 4px solid black; padding-left: 20px"></span><input size="10" id="startLec" placeholder="과목을 입력해주세요." oninput="changeStartLec(this.value)">
            <br>
            <span id="endTime" style="font-size: 50px; border-left: 4px solid black; padding-left: 20px"></span><input size="10" id="endLec" placeholder="과목을 입력해주세요." oninput="changeEndLec(this.value)">
        </div>

    </div>
    <div id="secondLineContainer">
        <div id="startWeather" class="weatherDiv">
            <span>출발</span>
            <br>
            <img id="startIcon">
            <br>
            <div><span id="startTemp"></span> &nbsp <span id="startRain"></span></div>
        </div>
        <div id="endWeather" class="weatherDiv">
            <span>도착</span>
            <br>
            <img id="endIcon">
            <br>
            <div><span id="endTemp"></span> &nbsp <span id="endRain"></span></div>
        </div>
        <div id="dustWeather" class="weatherDiv">
            <span id="fineD">미세먼지 : </span>
            <span id="finerD">초미세먼지 : </span>
            <span id="dustInfo"></span>
        </div>
    </div>

    <div id="finalLineContainer">
        <div id="routeContainer">
            <span id="startStation"></span>
            <div id="route1"></div>
            <span id="changeStation"></span>
            <div id="route2"></div>
            <span id="endStation"></span>
        </div>
        <div id="alarmContainer">
            <span>알람 설정 (탑승하기 직전에 선택)</span>
            <div style="border-top: 2px solid #c1bfb8; width: 90%; margin-bottom: 20px"></div>
            <div id="subwayUp" class="subwayDiv" style="margin-bottom: 30px">
                <span id="upSubwayName">호선 상행</span>
                <br>
                <span id="upSubwayTarget">현재 위치 : </span>
                <br>
                <span id="upSubwayLocation">남은 시간 : </span>
            </div>
            <div id="subwayDown" class="subwayDiv">
                <span id="downSubwayName">호선 상행</span>
                <br>
                <span id="downSubwayTarget">현재 위치 : </span>
                <br>
                <span id="downSubwayLocation">남은 시간 : </span>
            </div>
        </div>
    </div>

    <div id="logout" onclick="logout()">
        로그아웃
    </div>

    <br><br><br><br><br><br><br><br><br><br><br>

    <%@ include file="../layout/menu.jsp"%>
</body>

<script>
    /////////////////////////////////
    // 오늘 날짜 가져오기
    var today = new Date();
    var month = today.getMonth() + 1;
    var day = today.getDate();

    var weekdays = ["일", "월", "화", "수", "목", "금", "토"];
    var weekdayIndex = today.getDay();
    var weekday = weekdays[weekdayIndex];

    document.getElementById("dateSpan").innerText = month + "월 " + day + "일"
    document.getElementById("daySpan").innerText = "(" + weekday + ")"

    //////////////////////////////
    // 시작/종료 시간과 과목 가져오기

    let data = {
        studentId: localStorage.getItem('sm_sid')
    }
    $.ajax({
        type: "POST",
        url: "/getSchedule",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        startTime = null;
        endTime = null;
        startLec = null;
        endLec = null;

        switch (weekdayIndex) {
            case 0:
                startTime = String(resp.sunStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.sunEndTime).padStart(2, '0') + ":00";
                startLec = resp.sunStartLec;
                endLec = resp.sunEndLec;
                break;
            case 1:
                startTime = String(resp.monStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.monEndTime).padStart(2, '0') + ":00";
                startLec = resp.monStartLec;
                endLec = resp.monEndLec;
                break;
            case 2:
                startTime = String(resp.tueStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.tueEndTime).padStart(2, '0') + ":00";
                startLec = resp.tueStartLec;
                endLec = resp.tueEndLec;
                break;
            case 3:
                startTime = String(resp.wedStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.wedEndTime).padStart(2, '0') + ":00";
                startLec = resp.wedStartLec;
                endLec = resp.wedEndLec;
                break;
            case 4:
                startTime = String(resp.thurStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.thurEndTime).padStart(2, '0') + ":00";
                startLec = resp.thurStartLec;
                endLec = resp.thurEndLec;
                break;
            case 5:
                startTime = String(resp.friStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.friEndTime).padStart(2, '0') + ":00";
                startLec = resp.friStartLec;
                endLec = resp.friEndLec;
                break;
            case 6:
                startTime = String(resp.satStartTime).padStart(2, '0') + ":00";
                endTime = String(resp.satEndTime).padStart(2, '0') + ":00";
                startLec = resp.satStartLec;
                endLec = resp.satEndLec;
                break;
        }
        if (startTime == undefined) startTime = "00:00";
        if (endTime == undefined) endTime = "00:00";

        document.getElementById('startTime').innerText = startTime + " - ";
        document.getElementById('endTime').innerText = endTime + " - ";
        document.getElementById('startLec').value = startLec;
        document.getElementById('endLec').value = endLec;
    }).fail(function (error) {
        alert("시간을 불러오는 데 실패하였습니다.");
        console.log(error);
    })

    //////////////////////////////////////////
    // 미세먼지 가져오기
    $.ajax({
        type: "POST",
        url: "/getDust",
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        jsono = JSON.parse(resp);
        document.getElementById("fineD").innerText = "미세먼지 : " + jsono.RealtimeCityAir.row[0].PM10;
        document.getElementById("finerD").innerText = "초미세먼지 : " + jsono.RealtimeCityAir.row[0].PM25;
        document.getElementById("dustInfo").innerText = "- " + jsono.RealtimeCityAir.row[0].IDEX_NM + " -";
    }).fail(function (error) {
        alert("미세먼지 조회에 실패하였습니다.");
        console.log(error);
    });


    ///////////////////////////////////////////////////
    // 날씨 가져오기

    $.ajax({
        type: "POST",
        url: "/getHomeWeather",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        var jsono = JSON.parse(resp);
        var items = jsono.response.body.items.item;

        var startTimereal = startTime.replace(":", "");
        var endTimereal = endTime.replace(":", "");

        for (var i = 0; i < items.length; i++) {
            // 등교출발 날씨 구하기
            if (items[i].fcstTime === startTimereal && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    document.getElementById("startIcon").src = "image/homeweather/sunny.png";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    document.getElementById("startIcon").src = "image/homeweather/cloud.png";
                } else { // 나머지는 비
                    document.getElementById("startIcon").src = "image/homeweather/rain.png";
                }
                document.getElementById("startRain").innerText = "🌧️" + rainypercent + "%";
            }
            // 등교출발 기온 구하기
            if (items[i].fcstTime === startTimereal && items[i].category === "TMP") {
                document.getElementById("startTemp").innerText = "🌡️" + items[i].fcstValue + "°C";
            }

            // 하교도착 날씨 구하기
            if (items[i].fcstTime === endTimereal && items[i].category === "POP") {
                var rainypercent = items[i].fcstValue;
                if (rainypercent < 40) { // 40% 아래로는 맑음
                    document.getElementById("endIcon").src = "image/homeweather/sunny.png";
                } else if (rainypercent < 60) { // 60% 아래로는 흐림
                    document.getElementById("endIcon").src = "image/homeweather/cloud.png";
                } else { // 나머지는 비
                    document.getElementById("endIcon").src = "image/homeweather/rain.png";
                }
                document.getElementById("endRain").innerText = "🌧️" + rainypercent + "%";
            }
            // 하교도착 기온 구하기
            if (items[i].fcstTime === endTimereal && items[i].category === "TMP") {
                document.getElementById("endTemp").innerText = "🌡️" + items[i].fcstValue + "°C";
            }
        }
    }).fail(function (error) {
        console.log(error);
    })


    /////////////////////////////////////////////////////////////
    // 역 가져오기
    $.ajax({
        type: "POST",
        url: "/findLocation",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        station = resp.startName;
        if (resp.startName === null || resp.startName === "") {
            document.getElementById('changeStation').innerText = "역을 설정해 주세요";
        } else {
            if (resp.endName === null || resp.endName === "") {
                document.getElementById('changeStation').innerText = "역을 설정해 주세요";
            } else {
                if (resp.changeName === null || resp.changeName === "") {
                    document.getElementById("startStation").innerText = resp.startName;
                    document.getElementById("endStation").innerText = resp.endName;

                    subwayNo = resp.s_subwayNo;
                    subwayName = resp.s_subwayName;
                    switch(resp.s_subwayNo) {
                        case 1001:
                            document.getElementById("route1").style.backgroundColor = "#0052a4";
                            document.getElementById("route2").style.backgroundColor = "#0052a4";
                            break;
                        case 1002:
                            document.getElementById("route1").style.backgroundColor = "#00a84d";
                            document.getElementById("route2").style.backgroundColor = "#00a84d";
                            break;
                        case 1003:
                            document.getElementById("route1").style.backgroundColor = "#ef7c1c";
                            document.getElementById("route2").style.backgroundColor = "#ef7c1c";
                            break;
                        case 1004:
                            document.getElementById("route1").style.backgroundColor = "#00a4e3";
                            document.getElementById("route2").style.backgroundColor = "#00a4e3";
                            break;
                        case 1005:
                            document.getElementById("route1").style.backgroundColor = "#996cac";
                            document.getElementById("route2").style.backgroundColor = "#996cac";
                            break;
                        case 1006:
                            document.getElementById("route1").style.backgroundColor = "#cd7c2f";
                            document.getElementById("route2").style.backgroundColor = "#cd7c2f";
                            break;
                        case 1007:
                            document.getElementById("route1").style.backgroundColor = "#748000";
                            document.getElementById("route2").style.backgroundColor = "#748000";
                            break;
                        case 1008:
                            document.getElementById("route1").style.backgroundColor = "#e6186c";
                            document.getElementById("route2").style.backgroundColor = "#e6186c";
                            break;
                        case 1009:
                            document.getElementById("route1").style.backgroundColor = "#bdb092";
                            document.getElementById("route2").style.backgroundColor = "#bdb092";
                            break;
                        case 1075:
                            document.getElementById("route1").style.backgroundColor = "#fabe00";
                            document.getElementById("route2").style.backgroundColor = "#fabe00";
                            break;
                        case 1063:
                            document.getElementById("route1").style.backgroundColor = "#77c4a3";
                            document.getElementById("route2").style.backgroundColor = "#77c4a3";
                            break;
                        case 1067:
                            document.getElementById("route1").style.backgroundColor = "#178c72";
                            document.getElementById("route2").style.backgroundColor = "#178c72";
                            break;
                    }
                } else {
                    document.getElementById("startStation").innerText = resp.startName;
                    document.getElementById("endStation").innerText = resp.endName;
                    document.getElementById("changeStation").innerText = resp.changeName;

                    subwayNo = resp.s_subwayNo;
                    subwayName = resp.s_subwayName;
                    switch(resp.s_subwayNo) {
                        case 1001:
                            document.getElementById("route1").style.backgroundColor = "#0052a4";
                            break;
                        case 1002:
                            document.getElementById("route1").style.backgroundColor = "#00a84d";
                            break;
                        case 1003:
                            document.getElementById("route1").style.backgroundColor = "#ef7c1c";
                            break;
                        case 1004:
                            document.getElementById("route1").style.backgroundColor = "#00a4e3";
                            break;
                        case 1005:
                            document.getElementById("route1").style.backgroundColor = "#996cac";
                            break;
                        case 1006:
                            document.getElementById("route1").style.backgroundColor = "#cd7c2f";
                            break;
                        case 1007:
                            document.getElementById("route1").style.backgroundColor = "#748000";
                            break;
                        case 1008:
                            document.getElementById("route1").style.backgroundColor = "#e6186c";
                            break;
                        case 1009:
                            document.getElementById("route1").style.backgroundColor = "#bdb092";
                            break;
                        case 1075:
                            document.getElementById("route1").style.backgroundColor = "#fabe00";
                            break;
                        case 1063:
                            document.getElementById("route1").style.backgroundColor = "#77c4a3";
                            break;
                        case 1067:
                            document.getElementById("route1").style.backgroundColor = "#178c72";
                            break;
                    }
                    switch(resp.c_subwayNo) {
                        case 1001:
                            document.getElementById("route2").style.backgroundColor = "#0052a4";
                            break;
                        case 1002:
                            document.getElementById("route2").style.backgroundColor = "#00a84d";
                            break;
                        case 1003:
                            document.getElementById("route2").style.backgroundColor = "#ef7c1c";
                            break;
                        case 1004:
                            document.getElementById("route2").style.backgroundColor = "#00a4e3";
                            break;
                        case 1005:
                            document.getElementById("route2").style.backgroundColor = "#996cac";
                            break;
                        case 1006:
                            document.getElementById("route2").style.backgroundColor = "#cd7c2f";
                            break;
                        case 1007:
                            document.getElementById("route2").style.backgroundColor = "#748000";
                            break;
                        case 1008:
                            document.getElementById("route2").style.backgroundColor = "#e6186c";
                            break;
                        case 1009:
                            document.getElementById("route2").style.backgroundColor = "#bdb092";
                            break;
                        case 1075:
                            document.getElementById("route2").style.backgroundColor = "#fabe00";
                            break;
                        case 1063:
                            document.getElementById("route2").style.backgroundColor = "#77c4a3";
                            break;
                        case 1067:
                            document.getElementById("route2").style.backgroundColor = "#178c72";
                            break;
                    }
                }
            }
        }


        //////////////////////////////////////////////////////////
        // 실시간 지하철 가져오기
        let data2 = {
            stationName: station
        }
        if (station != null || station != "") {
            $.ajax({
                type: "POST",
                url: "/getSubway",
                data: JSON.stringify(data2),
                contentType: "application/json; charset=utf-8"
            }).done(function (resp2) {
                var goup = 0;
                var godown = 0;

                var subwayList = JSON.parse(resp2).realtimeArrivalList;
                for (let j=0; j<subwayList.length; j++) {
                    if (goup==1 && godown==1) break;

                    if ((subwayList[j].updnLine=="상행" || subwayList[j].updnLine=="외선") && goup == 0 && subwayList[j].subwayId == subwayNo) {
                        var goup = 1;

                        document.getElementById("upSubwayName").innerText = subwayName + " " + subwayList[j].updnLine;
                        document.getElementById("upSubwayTarget").innerText = subwayList[j].trainLineNm;
                        document.getElementById("upSubwayLocation").innerText = subwayList[j].arvlMsg2;

                        document.getElementById("subwayUp").onclick =
                            function() {
                                let subData = null;
                                if (resp.changeName === "" || resp.changeName === null) {
                                    subData = {
                                        studentId: localStorage.getItem('sm_sid'),
                                        subwayLine: subwayNo,
                                        subwayNo: subwayList[j].btrainNo,
                                        goingRoute: subwayList[j].updnLine,
                                        stationID: resp.endNo,
                                        stationName: resp.endName,
                                        subwayName: subwayName
                                    }
                                } else {
                                    subData = {
                                        studentId: localStorage.getItem('sm_sid'),
                                        subwayLine: subwayNo,
                                        subwayNo: subwayList[j].btrainNo,
                                        goingRoute: subwayList[j].updnLine,
                                        stationID: resp.changeNo,
                                        stationName: resp.changeName,
                                        subwayName: subwayName
                                    }
                                }
                                $.ajax({
                                    type: "POST",
                                    url: "/saveAlarmToDB",
                                    data: JSON.stringify(subData),
                                    contentType: "application/json; charset=utf-8"
                                }).done(function (resp3) {
                                    alert("알람이 등록되었습니다.");
                                }).fail(function (error) {
                                    alert("알람을 등록하는 데 실패하였습니다.");
                                    console.log(error);
                                });
                            }
                    }
                    if (goup==1 && godown==1) break;

                    if ((subwayList[j].updnLine=="하행" || subwayList[j].updnLine=="내선") && godown == 0 && subwayList[j].subwayId == subwayNo) {
                        var godown = 1;

                        document.getElementById("downSubwayName").innerText = subwayName + " " + subwayList[j].updnLine;
                        document.getElementById("downSubwayTarget").innerText = subwayList[j].trainLineNm;
                        document.getElementById("downSubwayLocation").innerText = subwayList[j].arvlMsg2;

                        document.getElementById("subwayDown").onclick =
                            function() {
                                let subData = {
                                    studentId: localStorage.getItem('sm_sid'),
                                    subwayLine: subwayNo,
                                    subwayNo: subwayList[j].btrainNo,
                                    goingRoute: subwayList[j].updnLine,
                                    stationID: resp.endNo,
                                    stationName: resp.endName,
                                    subwayName: subwayName
                                }
                                $.ajax({
                                    type: "POST",
                                    url: "/saveAlarmToDB",
                                    data: JSON.stringify(subData),
                                    contentType: "application/json; charset=utf-8"
                                }).done(function (resp3) {
                                    alert("알람이 등록되었습니다.");
                                }).fail(function (error) {
                                    alert("알람을 등록하는 데 실패하였습니다.");
                                    console.log(error);
                                });
                            }
                    }
                }
            }).fail(function (error) {
                alert("지하철 조회에 실패하였습니다.");
                console.log(error);
            });
        }

    }).fail(function (error) {
        alert("위치 목록 조회에 실패하였습니다.");
    });

    function changeStartLec(lecName) {

        let data3 = {
            studentId: localStorage.getItem('sm_sid'),
            lecName: lecName,
            day: weekdayIndex
        }
        $.ajax({
            type: "POST",
            url: "/changeStartLec",
            data: JSON.stringify(data3),
            contentType: "application/json; charset=utf-8"
        }).fail(function (error) {
            alert("과목 이름 변경에 실패하였습니다.");
            console.log(error);
        });
    }
    function changeEndLec(lecName) {

        let data4 = {
            studentId: localStorage.getItem('sm_sid'),
            lecName: lecName,
            day: weekdayIndex
        }
        $.ajax({
            type: "POST",
            url: "/changeEndLec",
            data: JSON.stringify(data4),
            contentType: "application/json; charset=utf-8"
        }).fail(function (error) {
            alert("과목 이름 변경에 실패하였습니다.");
            console.log(error);
        });
    }

    function logout() {
        localStorage.removeItem('sm_sid');
        location.href = "/";
    }
</script>
</html>
