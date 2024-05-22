package com.hufs.SchoolMate.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChangeLecDTO {
    private String studentId;
    private String lecName;
    private int day;
}
