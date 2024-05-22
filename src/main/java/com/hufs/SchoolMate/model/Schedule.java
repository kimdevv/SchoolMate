package com.hufs.SchoolMate.model;

import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
public class Schedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name="userid")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;

    @Column(nullable = true)
    private int MonStartTime;
    @Column(nullable = true)
    private String MonStartLec;
    @Column(nullable = true)
    private int MonEndTime;
    @Column(nullable = true)
    private String MonEndLec;

    @Column(nullable = true)
    private int TueStartTime;
    @Column(nullable = true)
    private String TueStartLec;
    @Column(nullable = true)
    private int TueEndTime;
    @Column(nullable = true)
    private String TueEndLec;

    @Column(nullable = true)
    private int WedStartTime;
    @Column(nullable = true)
    private String WedStartLec;
    @Column(nullable = true)
    private int WedEndTime;
    @Column(nullable = true)
    private String WedEndLec;

    @Column(nullable = true)
    private int ThurStartTime;
    @Column(nullable = true)
    private String ThurStartLec;
    @Column(nullable = true)
    private int ThurEndTime;
    @Column(nullable = true)
    private String ThurEndLec;

    @Column(nullable = true)
    private int FriStartTime;
    @Column(nullable = true)
    private String FriStartLec;
    @Column(nullable = true)
    private int FriEndTime;
    @Column(nullable = true)
    private String FriEndLec;

    @Column(nullable = true)
    private int SatStartTime;
    @Column(nullable = true)
    private String SatStartLec;
    @Column(nullable = true)
    private int SatEndTime;
    @Column(nullable = true)
    private String SatEndLec;

    @Column(nullable = true)
    private int SunStartTime;
    @Column(nullable = true)
    private String SunStartLec;
    @Column(nullable = true)
    private int SunEndTime;
    @Column(nullable = true)
    private String SunEndLec;
}
