package com.spring.finall.admin.admindomain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Table(name="school")
@Entity
@Getter
@Setter
@NoArgsConstructor
@ToString
public class School {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    //스쿨이 주인이고 주인 스쿨에 의하여 자식 테이블 student가 덮어 진다.
    @OneToMany(mappedBy = "school", cascade = CascadeType.ALL)
    //주인 밑에 자식을 작성해준다.
    private List<Student> students = new ArrayList<>();

    public School(String name) {
        this.name = name;
    }

    public void addStudent(Student student){
        this.students.add(student);
        student.updateSchool(this);
    }
}