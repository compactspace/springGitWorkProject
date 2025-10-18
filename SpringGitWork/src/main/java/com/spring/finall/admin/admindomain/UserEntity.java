package com.spring.finall.admin.admindomain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;



import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Table(name = "user")
@Entity
@Setter
@Getter
@Builder
@AllArgsConstructor
@ToString
@RequiredArgsConstructor
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "user_code")
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

public class UserEntity {
	
	@Id
	public Long user_code;

	public String user_where;
	public String id;
	public String password;
	public String user_tell;
	public String user_name;

// 게씨발 mappedBy = 값 과 @ManyToOne 이 붙은 컬럼의 변수명이 일치해햐한다고함
//https://velog.io/@yeoonnii/Caused-by-org.hibernate.AnnotationException-mappedBy-reference-an-unknown-target-entity-property

	 //WARN : org.springframework.web.servlet.mvc.support.DefaultHandlerExceptionResolver - Failure while trying to resolve exception [org.springframework.http.converter.HttpMessageNotWritableException]
	//java.lang.IllegalStateException: 응답이 이미 커밋된 후에는 sendError()를 호출할 수 없습니다.
	@OneToMany(mappedBy = "userEntity")	
	 
	public List<ReserveinfoEntity> reserveinfoEntity = new ArrayList<>();

}
