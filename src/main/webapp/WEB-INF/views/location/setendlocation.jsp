<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../../layout/header.jsp"%>
    <link rel="stylesheet" href="/css/setEndLocation.css" type="text/css"/>
</head>
<body>

<div id="Container">
    <span id="titleSpan">도착 역 설정</span>
    <br>

    <input oninput="search(this.value)" placeholder="역 이름을 입력해주세요">

    <div id="stationContainer">
    </div>
</div>

    <%@ include file="../../layout/menu.jsp"%>
</body>

<script>
    function search(stnName) {
        const stationContainer = document.getElementById('stationContainer');
        stationContainer.innerHTML = "";

        let data = {
            stationName: stnName
        }
        $.ajax({
            type: "POST",
            url: "/searchStation",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8"
        }).done(function (resp) {
            resp.forEach(function (station) {
                if (station.subwayId == '1065' || station.subwayId == '1077' || station.subwayId == '1092' || station.subwayId == '1093') {
                    // 공항철도, 신분당선, 경강선, 우이신설선, 서해선 제외
                } else {
                    const stationDiv = document.createElement('div');
                    stationDiv.className = 'station';

                    const stationSpan = document.createElement('span');
                    stationSpan.innerText = station.stationName;

                    const stationImg = document.createElement('img');
                    stationImg.className = "subwaylogo";
                    switch (station.subwayId) {
                        case 1001:
                            stationImg.src = "image/subway_logos/no1.png";
                            break;
                        case 1002:
                            stationImg.src = "image/subway_logos/no2.png";
                            break;
                        case 1003:
                            stationImg.src = "image/subway_logos/no3.png";
                            break;
                        case 1004:
                            stationImg.src = "image/subway_logos/no4.png";
                            break;
                        case 1005:
                            stationImg.src = "image/subway_logos/no5.png";
                            break;
                        case 1006:
                            stationImg.src = "image/subway_logos/no6.png";
                            break;
                        case 1007:
                            stationImg.src = "image/subway_logos/no7.png";
                            break;
                        case 1008:
                            stationImg.src = "image/subway_logos/no8.png";
                            break;
                        case 1009:
                            stationImg.src = "image/subway_logos/no9.png";
                            break;
                        case 1063:
                            stationImg.src = "image/subway_logos/gj.png";
                            break;
                        case 1067:
                            stationImg.src = "image/subway_logos/gc.png";
                            break;
                        case 1075:
                            stationImg.src = "image/subway_logos/sb.png";
                            break;
                    }


                    stationDiv.appendChild(stationSpan);
                    stationDiv.appendChild(stationImg);

                    stationDiv.onclick = function () {
                        onClickStation(station);
                    };

                    stationContainer.appendChild(stationDiv);
                }
            });
        }).fail(function (error) {
            alert("역 정보를 조회하는 데 실패하였습니다.");
            console.log(error);
        });
    }

    function onClickStation(station) {
        let data = {
            userId: localStorage.getItem("sm_sid"),
            stationNo: station.stationId,
            stationName: station.stationName,
            subwayNo: station.subwayId,
            subwayName: station.호선이름
        }
        $.ajax({
            type: "POST",
            url: "/setEndLoc",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8"
        }).done(function (resp) {
            alert("도착 역이 " + station.stationName + " 역으로 등록되었습니다.");
            location.href = "/location";
        }).fail(function (error) {
            alert("역 등록에 실패하였습니다.");
            console.log(error);
        })
    }
</script>
</html>
