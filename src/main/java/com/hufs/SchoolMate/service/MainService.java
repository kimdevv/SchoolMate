package com.hufs.SchoolMate.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hufs.SchoolMate.DTO.*;
import com.hufs.SchoolMate.Repository.*;
import com.hufs.SchoolMate.model.*;
import jdk.nashorn.internal.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Service
public class MainService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    StationRepository stationRepository;

    @Autowired
    LocationRepository locationRepository;

    @Autowired
    ScheduleRepository scheduleRepository;

    @Autowired
    AlarmRepository alarmRepository;

    @Autowired
    FcmtokenRepository fcmtokenRepository;

    @Transactional
    public ArrayList<Station> findStation(String stationName) {
        ArrayList<Station> result = stationRepository.findAllByStationNameLike("%"+stationName+"%");

        if (result.size() == 0) { // 해당 이름을 포함하는 이름의 역이 없을 경우
            return null;
        } else {
            return result;
        }
    }

    @Transactional
    public void setStartLoc(String userId, String stationNo, String stationName, int subwayNo, String subwayName) {
        User user = userRepository.findByStudentId(userId);

        Location location = locationRepository.findByUser(user);
        if (location == null) {
            location = Location.builder()
                    .startNo(stationNo)
                    .startName(stationName)
                    .s_subwayNo(subwayNo)
                    .s_subwayName(subwayName)
                    .user(user)
                    .build();
            locationRepository.save(location);
        } else {
            location.setStartNo(stationNo);
            location.setStartName(stationName);
            location.setS_subwayNo(subwayNo);
            location.setS_subwayName(subwayName);
        }
    }

    @Transactional
    public void setEndLoc(String userId, String stationNo, String stationName, int subwayNo, String subwayName) {
        User user = userRepository.findByStudentId(userId);

        Location location = locationRepository.findByUser(user);
        if (location == null) {
            location = Location.builder()
                    .endNo(stationNo)
                    .endName(stationName)
                    .user(user)
                    .build();
            locationRepository.save(location);
        } else {
            location.setEndNo(stationNo);
            location.setEndName(stationName);
        }
    }

    @Transactional
    public void setChangeLoc(String userId, String stationNo, String stationName, int subwayNo, String subwayName) {
        User user = userRepository.findByStudentId(userId);

        Location location = locationRepository.findByUser(user);
        if (location == null) {
            location = Location.builder()
                    .changeNo(stationNo)
                    .changeName(stationName)
                    .c_subwayNo(subwayNo)
                    .c_subwayName(subwayName)
                    .user(user)
                    .build();
            locationRepository.save(location);
        } else {
            location.setChangeNo(stationNo);
            location.setChangeName(stationName);
            location.setC_subwayNo(subwayNo);
            location.setC_subwayName(subwayName);
        }
    }

    @Transactional
    public Location findLocation(String studentId) {
        User user = userRepository.findByStudentId(studentId);
        Location location = locationRepository.findByUser(user);

        if (location != null) {
            return location;
        } else {
            return new Location();
        }
    }

    @Transactional
    public void resetChangeLoc(String studentId) {
        User user = userRepository.findByStudentId(studentId);
        Location location = locationRepository.findByUser(user);
        location.setChangeNo("");
        location.setChangeName("");
    }

    @Transactional
    public Schedule getSchedule(String studentId) {
        User user = userRepository.findByStudentId(studentId);
        Schedule schedule = scheduleRepository.findByUser(user);
        if (schedule == null) {
            schedule = Schedule.builder()
                    .user(user)
                    .build();
            scheduleRepository.save(schedule);
        }

        return schedule;
    }

    @Transactional
    public void setScheduleTime(SetScheduleTimeDTO setScheduleTimedto) {
        String studentId = setScheduleTimedto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        String day = setScheduleTimedto.getDay();
        String startend = setScheduleTimedto.getStartend();
        int time = setScheduleTimedto.getTime();

        if (time < 9) {
            time = 9;
        }
        if (time > 18) {
            time = 18;
        }

        System.out.println(time);
        Schedule schedule = scheduleRepository.findByUser(user);
        if (day.equals("mon")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setMonStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .MonStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setMonEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .MonEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("tue")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setTueStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .TueStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setTueEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .TueEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("wed")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setWedStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .WedStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setWedEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .WedEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("thur")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setThurStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .ThurStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setThurEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .ThurEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("fri")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setFriStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .FriStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setFriEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .FriEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("sat")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setSatStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .SatStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setSatEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .SatEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        } else if (day.equals("sun")) {
            if (startend.equals("start")) { // start 시간 설정
                if (schedule != null) {
                    schedule.setSunStartTime(time);
                } else {
                    schedule = Schedule.builder()
                            .SunStartTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            } else { // end 시간 설정
                if (schedule != null) {
                    schedule.setSunEndTime(time);
                } else {
                    schedule = Schedule.builder()
                            .SunEndTime(time)
                            .user(user)
                            .build();
                    scheduleRepository.save(schedule);
                }
            }
        }
    }

    @Transactional
    public String getHomeWeather(StudentidDTO studentiddto) throws IOException {
        String studentId = studentiddto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        LocalDate nowRaw = LocalDate.now().minusDays(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(("yyyyMMdd"));
        String now = nowRaw.format(formatter);

        Location location = locationRepository.findByUser(user);
        if (location == null) {
            return null;
        } else {
            String stationNo = location.getStartNo();
            Station station = stationRepository.findByStationId(stationNo);
            String nx = Integer.toString((int)Math.round(station.getNx()));
            String ny = Integer.toString((int)Math.round(station.getNy()));

            // URL 만들기
            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst");
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + "daXBZao%2FMNYLWe%2FKGylCkymLfoosWXDdrSV9OuHyXWWDrBPgvK25YumL%2Figgomy88rACi187ZFVSfG7nSbpQlQ%3D%3D");
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("300", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(now, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("2300", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8"));

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String sb = "";
            String line;
            while ((line = rd.readLine()) != null) {
                sb += line;
            }
            rd.close();
            conn.disconnect();

            return sb;
        }
    }

    @Transactional
    public String getSchoolWeather(StudentidDTO studentiddto) throws IOException {
        String studentId = studentiddto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        LocalDate nowRaw = LocalDate.now().minusDays(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(("yyyyMMdd"));
        String now = nowRaw.format(formatter);

        Location location = locationRepository.findByUser(user);
        if (location == null) {
            return null;
        } else {
            String stationNo = location.getEndNo();
            Station station = stationRepository.findByStationId(stationNo);
            String nx = Integer.toString((int)Math.round(station.getNx()));
            String ny = Integer.toString((int)Math.round(station.getNy()));

            // URL 만들기
            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst");
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + "daXBZao%2FMNYLWe%2FKGylCkymLfoosWXDdrSV9OuHyXWWDrBPgvK25YumL%2Figgomy88rACi187ZFVSfG7nSbpQlQ%3D%3D");
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("300", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(now, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("2300", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8"));

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String sb = "";
            String line;
            while ((line = rd.readLine()) != null) {
                sb += line;
            }
            rd.close();
            conn.disconnect();

            return sb;
        }
    }

    @Transactional
    public String getDust() throws IOException {
        // URL 만들기
        StringBuilder urlBuilder = new StringBuilder("http://openAPI.seoul.go.kr:8088/6e4d5661436b696d3132306a51504478/json/RealtimeCityAir/1/5/동북권/동대문구/");

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        String sb = "";
        String line;
        while ((line = rd.readLine()) != null) {
            sb += line;
        }
        rd.close();
        conn.disconnect();

        return sb;
    }

    @Transactional
    public void changeStartLec(ChangeLecDTO changeLecdto) {
        String lecName = changeLecdto.getLecName();

        String studentId = changeLecdto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        Schedule schedule = scheduleRepository.findByUser(user);

        int day = changeLecdto.getDay();
        switch (day) {
            case 0:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .SunStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setSunStartLec(lecName);
                }
                break;
            case 1:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .MonStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setMonStartLec(lecName);
                }
                break;
            case 2:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .TueStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setTueStartLec(lecName);
                }
                break;
            case 3:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .WedStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setWedStartLec(lecName);
                }
                break;
            case 4:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .ThurStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setThurStartLec(lecName);
                }
                break;
            case 5:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .FriStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setFriStartLec(lecName);
                }
                break;
            case 6:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .SatStartLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setSatStartLec(lecName);
                }
                break;
        }
    }

    @Transactional
    public void changeEndLec(ChangeLecDTO changeLecdto) {
        String lecName = changeLecdto.getLecName();

        String studentId = changeLecdto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        Schedule schedule = scheduleRepository.findByUser(user);

        int day = changeLecdto.getDay();
        switch (day) {
            case 0:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .SunEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setSunEndLec(lecName);
                }
                break;
            case 1:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .MonEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setMonEndLec(lecName);
                }
                break;
            case 2:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .TueEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setTueEndLec(lecName);
                }
                break;
            case 3:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .WedEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setWedEndLec(lecName);
                }
                break;
            case 4:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .ThurEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setThurEndLec(lecName);
                }
                break;
            case 5:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .FriEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setFriEndLec(lecName);
                }
                break;
            case 6:
                if (schedule == null) {
                    schedule = Schedule.builder()
                            .user(user)
                            .SatEndLec(lecName)
                            .build();
                    scheduleRepository.save(schedule);
                } else {
                    schedule.setSatEndLec(lecName);
                }
                break;
        }
    }

    @Transactional
    public String getSubway(GetSubwayDTO getSubwaydto) {
        String stationName = getSubwaydto.getStationName();

        RestTemplate rt = new RestTemplate();

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> Request = new HttpEntity<>(params);

        String url = "http://swopenAPI.seoul.go.kr/api/subway/히든키/json/realtimeStationArrival/0/10/" + stationName;
        ResponseEntity<String> response = rt.exchange(
                url, // https://{요청할 서버 주소}
                HttpMethod.GET, // 요청할 방식
                Request, // 요청할 때 보낼 데이터
                String.class // 요청 시 반환되는 데이터 타입
        );

        return response.getBody();
    }

    @Transactional
    public void saveAlarmToDB(SaveAlarmDTO saveAlarmdto) {
        String studentId = saveAlarmdto.getStudentId();
        User user = userRepository.findByStudentId(studentId);

        Station station = stationRepository.findByStationId(saveAlarmdto.getStationID());
        station.setSettedAlarm(station.getSettedAlarm() + 1);

        Alarm alarm = Alarm.builder()
                .user(user)
                .subwayLine(saveAlarmdto.getSubwayLine())
                .subwayNo(saveAlarmdto.getSubwayNo())
                .goingRoute(saveAlarmdto.getGoingRoute())
                .stationID(saveAlarmdto.getStationID())
                .stationName(saveAlarmdto.getStationName())
                .subwayName(saveAlarmdto.getSubwayName())
                .build();
        alarmRepository.save(alarm);
    }


    @PostConstruct
    public void fcmInitialize() throws IOException {
        ClassPathResource key = new ClassPathResource("static/firebase-key.json");
        try (InputStream serviceAccount = key.getInputStream()) {
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://schoolmate-8966b-default-rtdb.asia-southeast1.firebasedatabase.app")
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }
        }
    }

    @Transactional
    @Scheduled(fixedDelay = 3000)
    public void sendAlarm() {
        // settedAlarm이 1 이상인 역들(알람이 하나 이상 설정된 역들)을 모두 찾는다.
        ArrayList<Station> stations = stationRepository.findAllBySettedAlarmGreaterThanEqual(1);

        stations.forEach(station -> {
            RestTemplate rt = new RestTemplate();

            String uri = "http://swopenAPI.seoul.go.kr/api/subway/히든키/json/realtimeStationArrival/0/10/" + station.getStationName();
            String response = rt.getForEntity(uri, String.class).getBody();
            ObjectMapper objectMapper = new ObjectMapper();
            try {
                JsonNode subways = objectMapper.readTree(response).get("realtimeArrivalList");
                for (JsonNode subway : subways) {
                    // 해당 열차가 전역을 출발했을 경우
                    if (subway.get("arvlCd").asInt() == 0 || subway.get("arvlCd").asInt() == 3) {
                        int subwayLine = subway.get("subwayId").asInt(); // 지하철 노선
                        int subwayNo = subway.get("btrainNo").asInt(); // 해당 열차 번호
                        String stationID = station.getStationId(); // 목적지 역 id
                        String goingRoute = subway.get("updnLine").asText(); // 상행 or 하행

                        // 해당 역, 열차를 가지고 설정된 알림이 있는지 검사해서 알림 전송
                        ArrayList<Alarm> alarms = alarmRepository.findAllBySubwayLineAndSubwayNoAndStationIDAndGoingRoute(subwayLine, subwayNo, stationID, goingRoute);

                        // 삭제할 알람 목록을 담을 리스트
                        List<Alarm> alarmsToRemove = new ArrayList<>();

                        alarms.forEach(alarm -> {
                            SendPushDTO sdto = new SendPushDTO();
                            sdto.setTitle("목적지 도착 알림");
                            sdto.setContent("탑승하신 열차가 목적지의 전역을 출발했습니다. 이번 정차역에서 내리시면 됩니다!");
                            sdto.setUser(alarm.getUser());

                            try {
                                sendPush(sdto);
                            } catch (FirebaseMessagingException e) {
                                e.printStackTrace();
                            }
                            alarmsToRemove.add(alarm);

                            // 해당 역에 설정된 알림 개수를 하나씩 줄인다.
                            Station destination = stationRepository.findByStationId(alarm.getStationID());
                            destination.setSettedAlarm(destination.getSettedAlarm() - 1);

                        });

                        // 푸시 알림 전송을 끝마친 DB 칼럼은 삭제한다
                        alarmRepository.deleteAll(alarmsToRemove);
                    }
                }
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        });
    }



    @Transactional
    public void sendPush(SendPushDTO sendPushDto) throws FirebaseMessagingException {
        User user = sendPushDto.getUser();
        if (user == null) { // 비정상적인 유저
            return;
        }

        String token = fcmtokenRepository.findByUser(user).getToken();
        String title = sendPushDto.getTitle();
        String content = sendPushDto.getContent();

        // 메시지 객체 생성
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(content)
                .setImage("/image/favicon.png")
                .build();
        Message message = Message.builder()
                .setNotification(notification)
                .setToken(token)
                .build();

        FirebaseMessaging.getInstance().sendAsync(message);
    }

}
