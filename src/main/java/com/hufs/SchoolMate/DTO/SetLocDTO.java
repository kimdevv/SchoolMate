package com.hufs.SchoolMate.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SetLocDTO {
    private String userId;
    private String stationNo;
    private String stationName;
    private int subwayNo;
    private String subwayName;
}
