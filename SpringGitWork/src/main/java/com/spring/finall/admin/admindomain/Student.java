package com.spring.finall.admin.admindomain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Table(name="student")
@Entity
@Getter
@Setter
@NoArgsConstructor

public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
   
    private String name;

    
   
    //자식 이라고 알려주고
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "school_id")
    //주인을 작성해준다.
    private School school;

    public Student(String name) {
        this.name = name;
    }

    public void updateSchool(School school){
        this.school = school;
    }
}