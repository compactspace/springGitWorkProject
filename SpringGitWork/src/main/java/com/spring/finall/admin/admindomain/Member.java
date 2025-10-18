package com.spring.finall.admin.admindomain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;



import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
@Setter
@Getter
@Builder
@Entity
public class Member {
	
	 @Id
	   @Column(name = "MEMBER_ID")
	   private Long id;
	 
	   @Column(name = "USERNAME")
	   private String username;
	 
	   @ManyToOne // @ManyToOne 의 속성 fetch 의 기본값 은 FetchType.EAGER
	   @JoinColumn(name = "TEAM_ID")
	   private Team team;

}
