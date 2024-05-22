package com.hufs.SchoolMate.Repository;


import com.hufs.SchoolMate.model.Station;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;

public interface StationRepository extends JpaRepository<Station, Integer> {
    Station findByStationId(String stationID);
    Station findBySubwayIdAndStationId(int subwayID, String stationID);

    ArrayList<Station> findAllByStationNameLike(String stationName);
    ArrayList<Station> findAllByStationNameLikeAndSubwayId(String stationName, int subwayId);
    ArrayList<Station> findAllBySettedAlarmGreaterThanEqual(int settedAlarm);
}
