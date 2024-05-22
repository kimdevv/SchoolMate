package com.hufs.SchoolMate.controller;

import com.hufs.SchoolMate.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @GetMapping("/location")
    public String location() {
        return "location";
    }

    @GetMapping("/train")
    public String train() {
        return "train";
    }

    @GetMapping("/schedule")
    public String schedule() {
        return "schedule";
    }

    @GetMapping("/alarm")
    public String alarm() {
        return "alarm";
    }

    @GetMapping("/setStartLocation")
    public String setStartLocation() {
        return "location/setstartlocation";
    }

    @GetMapping("/setChangeLocation")
    public String setChangeLocation() {
        return "location/setchangelocation";
    }

    @GetMapping("/setEndLocation")
    public String setEndLocation() {
        return "location/setendlocation";
    }

    @GetMapping("/weather")
    public String weather() {
        return "weather";
    }
}
