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
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name="userid")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;

    @Column(nullable = true)
    private String startNo;
    @Column(nullable = true)
    private String startName;

    @Column(nullable = true)
    private String endNo;
    @Column(nullable = true)
    private String endName;

    @Column(nullable = true)
    private String changeNo;
    @Column(nullable = true)
    private String changeName;

    @Column(nullable = true)
    private int s_subwayNo;
    @Column(nullable = true)
    private String s_subwayName;

    @Column(nullable = true)
    private int c_subwayNo;
    @Column(nullable = true)
    private String c_subwayName;
}
