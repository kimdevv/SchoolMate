package com.hufs.SchoolMate.controller;

import com.hufs.SchoolMate.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    LoginService loginService;

    @GetMapping({"", "/", "login"})
    public String login() {
        return "login";
    }

    @GetMapping("/index")
    public String index(@RequestParam String sid) {
        return "index";
    }

    @GetMapping("/logindex")
    public String index(@RequestParam String sid, @RequestParam String token) {
        loginService.login(sid, token);
        return "index";
    }
}