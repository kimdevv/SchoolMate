package com.hufs.SchoolMate.Repository;


import com.hufs.SchoolMate.model.Alarm;
import com.hufs.SchoolMate.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;

public interface AlarmRepository extends JpaRepository<Alarm, Integer> {
    ArrayList<Alarm> findAllBySubwayLineAndSubwayNoAndStationIDAndGoingRoute(int subwayLine, int subwayNo, String stationID, String goingRoute);
    ArrayList<Alarm> findAllByUser(User user);
}
