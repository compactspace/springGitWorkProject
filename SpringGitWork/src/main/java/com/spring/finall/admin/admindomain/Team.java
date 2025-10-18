package com.spring.finall.admin.admindomain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
@Setter
@Getter
@Entity
@Builder
public class Team {
	@Id
    @Column(name = "TEAM_ID")
    private Long id;
    
    @Column(name = "NAME")
    private String name;
    
    // Getter, Setter, Constructor
}