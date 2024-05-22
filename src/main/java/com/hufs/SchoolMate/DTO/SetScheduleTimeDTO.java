package com.hufs.SchoolMate.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SetScheduleTimeDTO {
    private String studentId;
    private String day;
    private String startend;
    private int time;
}
