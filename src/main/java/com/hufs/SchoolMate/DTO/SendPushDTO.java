package com.hufs.SchoolMate.DTO;

import com.hufs.SchoolMate.model.User;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class SendPushDTO {
    private String title;
    private String content;
    private User user;
}
