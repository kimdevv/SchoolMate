package com.hufs.SchoolMate.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class Station {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int subwayId;

    private String 호선이름;

    private String stationId;

    private String stationName;

    private double nx; // 위도
    private double ny; // 경도

    // 몇 개의 알람이 설정되어 있는지
    private int settedAlarm;
}
