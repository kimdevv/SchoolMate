package com.hufs.SchoolMate.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SaveAlarmDTO {
    private String studentId;
    private int subwayLine;
    private int subwayNo;
    private String goingRoute;
    private String stationID;
    private String stationName;
    private String subwayName;
}
