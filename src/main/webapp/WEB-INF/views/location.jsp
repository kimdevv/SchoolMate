<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/location.css" type="text/css"/>
</head>
<body>
    <div id="Container">
        <div id="titleDiv">
            <img src="image/Logo2.png" width="130px" style="margin-right: 50px">
            <span>Set Routes</span>
        </div>

        <div>
            <div onclick="location.href='/setStartLocation'" style="margin-top: 60px; margin-bottom: 100px">
                <span class="locSpan">출발위치</span>
                <span id="startLoc" class="whereSpan">역을 설정해 주세요</span>
            </div>

            <div onclick="location.href='/setChangeLocation'" style="margin-bottom: 100px">
                <span class="locSpan">환승위치</span>
                <span id="changeLoc" class="whereSpan">환승 필요 시 설정해 주세요.</span>
            </div>

            <div onclick="location.href='/setEndLocation'">
                <span class="locSpan">도착위치</span>
                <span id="endLoc" class="whereSpan">역을 설정해 주세요</span>
            </div>
        </div>
        <br>
    </div>

    <%@ include file="../layout/menu.jsp"%>
</body>

<script>
    let data = {
        studentId: localStorage.getItem("sm_sid")
    }
    $.ajax({
        type: "POST",
        url: "/findLocation",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8"
    }).done(function (resp) {
        if (resp.startName === null || resp.startName === "") {
            document.getElementById('startLoc').innerText = "역을 설정해 주세요";
        } else {
            document.getElementById('startLoc').innerText = resp.startName + " " + resp.s_subwayName;
        }
        if (resp.changeName === null || resp.changeName === "") {
            document.getElementById('changeLoc').innerText = "환승 필요 시 설정해 주세요";
        } else {
            document.getElementById('changeLoc').innerText = resp.changeName + " " + resp.c_subwayName;
        }
        if (resp.endName === null || resp.endName === "") {
            document.getElementById('endLoc').innerText = "역을 설정해 주세요";
        } else {
            if (resp.c_subwayName == null) {
                document.getElementById('endLoc').innerText = resp.endName + " " + resp.s_subwayName;
            } else {
                document.getElementById('endLoc').innerText = resp.endName + " " + resp.c_subwayName;
            }
        }
    }).fail(function (error) {
        alert("위치 목록 조회에 실패하였습니다.");
    })
</script>
</html>
