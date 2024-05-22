package com.hufs.SchoolMate.controller.api;

import com.hufs.SchoolMate.DTO.*;
import com.hufs.SchoolMate.model.Location;
import com.hufs.SchoolMate.model.Schedule;
import com.hufs.SchoolMate.model.Station;
import com.hufs.SchoolMate.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.ArrayList;

@RestController
public class MainApiController {

    @Autowired
    MainService mainService;

    @PostMapping("/searchStation")
    public ArrayList<Station> findStation(@RequestBody SearchStationDTO searchStationDto) {
        String stationName = searchStationDto.getStationName();
        ArrayList<Station> result = mainService.findStation(stationName);

        return result;
    }

    @PostMapping("/setStartLoc")
    public int setStartLoc(@RequestBody SetLocDTO setLocdto) {
        String userId = setLocdto.getUserId();
        String stationNo = setLocdto.getStationNo();
        String stationName = setLocdto.getStationName();
        int subwayNo = setLocdto.getSubwayNo();
        String subwayName = setLocdto.getSubwayName();

        mainService.setStartLoc(userId, stationNo, stationName, subwayNo, subwayName);
        return 1;
    }

    @PostMapping("/setEndLoc")
    public int setEndLoc(@RequestBody SetLocDTO setLocdto) {
        String userId = setLocdto.getUserId();
        String stationNo = setLocdto.getStationNo();
        String stationName = setLocdto.getStationName();
        int subwayNo = setLocdto.getSubwayNo();
        String subwayName = setLocdto.getSubwayName();

        mainService.setEndLoc(userId, stationNo, stationName, subwayNo, subwayName);
        return 1;
    }

    @PostMapping("/setChangeLoc")
    public int setChangeLoc(@RequestBody SetLocDTO setLocdto) {
        String userId = setLocdto.getUserId();
        String stationNo = setLocdto.getStationNo();
        String stationName = setLocdto.getStationName();
        int subwayNo = setLocdto.getSubwayNo();
        String subwayName = setLocdto.getSubwayName();

        mainService.setChangeLoc(userId, stationNo, stationName, subwayNo, subwayName);
        return 1;
    }

    @PostMapping("/findLocation")
    public Location findLocation(@RequestBody StudentidDTO studentiddto) {
        String studentId = studentiddto.getStudentId();

        Location result = mainService.findLocation(studentId);
        return result;
    }

    @PostMapping("/resetChangeLoc")
    public int resetChangeLoc(@RequestBody StudentidDTO studentiddto) {
        String studentId = studentiddto.getStudentId();

        mainService.resetChangeLoc(studentId);
        return 1;
    }

    @PostMapping("/getSchedule")
    public Schedule getSchedule(@RequestBody StudentidDTO studentidDTO) {
        String studentId = studentidDTO.getStudentId();

        Schedule result = mainService.getSchedule(studentId);
        return result;
    }

    @PostMapping("/setScheduleTime")
    public int setScheduleTime(@RequestBody SetScheduleTimeDTO setScheduleTimedto) {
        mainService.setScheduleTime(setScheduleTimedto);
        return 1;
    }

    @PostMapping("/getHomeWeather")
    public String getHomeWeather(@RequestBody StudentidDTO studentiddto) throws IOException {
        String result = mainService.getHomeWeather(studentiddto);
        return result;
    }

    @PostMapping("/getSchoolWeather")
    public String getSchoolWeather(@RequestBody StudentidDTO studentiddto) throws IOException {
        String result = mainService.getSchoolWeather(studentiddto);
        return result;
    }

    @PostMapping("/changeStartLec")
    public int changeStartLec(@RequestBody ChangeLecDTO changeLecdto) {
        mainService.changeStartLec(changeLecdto);
        return 1;
    }

    @PostMapping("/changeEndLec")
    public int changeEndLec(@RequestBody ChangeLecDTO changeLecdto) {
        mainService.changeEndLec(changeLecdto);
        return 1;
    }

    @PostMapping("/getSubway")
    public String getSubway(@RequestBody GetSubwayDTO getSubwaydto) {
        String result = mainService.getSubway(getSubwaydto);
        return result;
    }

    @PostMapping("/saveAlarmToDB")
    public int saveAlarmToDB(@RequestBody SaveAlarmDTO saveAlarmdto) {
        mainService.saveAlarmToDB(saveAlarmdto);
        return 0;
    }

    @PostMapping("/getDust")
    public String getDust() throws IOException {
        String result = mainService.getDust();
        return result;
    }
}
