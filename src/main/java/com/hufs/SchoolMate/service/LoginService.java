package com.hufs.SchoolMate.service;

import com.hufs.SchoolMate.Repository.FcmtokenRepository;
import com.hufs.SchoolMate.Repository.UserRepository;
import com.hufs.SchoolMate.model.Fcmtoken;
import com.hufs.SchoolMate.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoginService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FcmtokenRepository fcmtokenRepository;

    @Transactional
    public void login(String sid) {
        User user = userRepository.findByStudentId(sid);
        if (user == null) {
            user = User.builder()
                    .studentId(sid)
                    .build();
            userRepository.save(user);
        }
    }

    @Transactional
    public void login(String sid, String token) {
        User user = userRepository.findByStudentId(sid);
        if (user == null) {
            user = User.builder()
                    .studentId(sid)
                    .build();
            userRepository.save(user);
        }

        Fcmtoken fcm = fcmtokenRepository.findByUser(user);
        if (fcm == null) {
            fcm = Fcmtoken.builder()
                    .user(user)
                    .token(token)
                    .build();
            fcmtokenRepository.save(fcm);
        } else {
            fcm.setToken(token);
        }
    }
}
