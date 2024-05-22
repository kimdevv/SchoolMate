<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/schedule.css" type="text/css"/>
</head>
<body>
    <div id="Container">
        <div id="titleDiv">
            <img src="image/Logo2.png" width="130px" style="margin-right: 50px">
            <span>Set Schedule</span>
        </div>
        <br>
        <span style="font-size: 30px; color: #8daba9">첫 수업 시장 시간과 마지막 수업 종료 시간을 입력해 주세요</span>
        <br>

        <div>
            <table style="width: 100%">
                <tr>
                    <td style="width: 140px">월</td>
                    <td>
                        <input id="monStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('mon', 'start', this.value)">
                        ~
                        <input id="monEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('mon', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">화</td>
                    <td>
                        <input id="tueStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('tue', 'start', this.value)">
                        ~
                        <input id="tueEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('tue', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">수</td>
                    <td>
                        <input id="wedStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('wed', 'start', this.value)">
                        ~
                        <input id="wedEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('wed', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">목</td>
                    <td>
                        <input id="thurStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('thur', 'start', this.value)">
                        ~
                        <input id="thurEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('thur', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">금</td>
                    <td>
                        <input id="friStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('fri', 'start', this.value)">
                        ~
                        <input id="friEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('fri', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">토</td>
                    <td>
                        <input id="satStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('sat', 'start', this.value)">
                        ~
                        <input id="satEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('sat', 'end', this.value)">
                    </td>
                </tr>
                <tr>
                    <td style="width: 140px">일</td>
                    <td>
                        <input id="sunStart" type="number" min="9" max="18" step="1" placeholder="시작시간" style="width: 230px", oninput="setScheduleTime('sun', 'start', this.value)">
                        ~
                        <input id="sunEnd" type="number" min="9" max="18" step="1" placeholder="종료시간" style="width: 230px", oninput="setScheduleTime('sun', 'end', this.value)">
                    </td>
                </tr>
                <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
            </table>
        </div>

    </div>

    <%@ include file="../layout/menu.jsp"%>
</body>

<script>
    let data = {
        studentId: localStorage.getItem('sm_sid')
    }
    $.ajax({
        type: "POST",
        url: "/getSchedule",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        document.getElementById("monStart").value = resp.monStartTime != '0' ? resp.monStartTime : "";
        document.getElementById("monEnd").value = resp.monEndTime != '0' ? resp.monEndTime : "";

        document.getElementById("tueStart").value = resp.tueStartTime != '0' ? resp.tueStartTime : "";
        document.getElementById("tueEnd").value = resp.tueEndTime != '0' ? resp.tueEndTime : "";

        document.getElementById("wedStart").value = resp.wedStartTime != '0' ? resp.wedStartTime : "";
        document.getElementById("wedEnd").value = resp.wedEndTime != '0' ? resp.wedEndTime : "";

        document.getElementById("thurStart").value = resp.thurStartTime != '0' ? resp.thurStartTime : "";
        document.getElementById("thurEnd").value = resp.thurEndTime != '0' ? resp.thurEndTime : "";

        document.getElementById("friStart").value = resp.friStartTime != '0' ? resp.friStartTime : "";
        document.getElementById("friEnd").value = resp.friEndTime != '0' ? resp.friEndTime : "";

        document.getElementById("satStart").value = resp.satStartTime != '0' ? resp.satStartTime : "";
        document.getElementById("satEnd").value = resp.satEndTime != '0' ? resp.satEndTime : "";

        document.getElementById("sunStart").value = resp.sunStartTime != '0' ? resp.sunStartTime : "";
        document.getElementById("sunEnd").value = resp.sunEndTime != '0' ? resp.sunEndTime : "";

    }).fail(function (error) {
        alert("시간을 불러오는 데 실패하였습니다.");
        console.log(error);
    })

    function setScheduleTime(day, startend, time) {
        let data = {
            studentId: localStorage.getItem('sm_sid'),
            day: day,
            startend: startend,
            time: time
        }
        $.ajax({
            type: "POST",
            url: "/setScheduleTime",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8"
        }).fail(function (error) {
            alert("시간 설정에 실패하였습니다.");
            console.log(error);
        })
    }
</script>
</html>
