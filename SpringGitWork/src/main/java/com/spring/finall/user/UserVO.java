package com.spring.finall.user;

import java.util.ArrayList;
import java.util.List;

import lombok.ToString;


@ToString
public class UserVO {

	private String id;

	private String password;

	
	//테이블에 있는 컬럼 아니고
	//아작스 통신으로 비번 변경시 받는 필드일뿐이다.
	//myinfo.jsp 로 가면 안다. afterpassword 네임값으로 데이터 보내고있음
	private String afterpassword;

	// 여기서부터는 새롭게 추가된 컬럼들

	private int user_code;

	private String user_where;

//	private String naver_id;
	
	private String user_name;
	
	private String user_tell;

	
	private String create_signup;
	
	private String email;
	
	
	//프론트에서 jstl로 쉽게 출력하기위해 만든다..
	//단주의:
	//이메서드는 마이베티스에서 프라이머리키로 받아오는 한줄로 get(0) 이 가능하고
	//프론트엔드 myinfo.jsp 에서 필요한 것만 추출 하려고 아래 정보들만 담은것이다.
	public List<Object> toList(List<UserVO> userlist){
		 List<Object> list = new ArrayList();
		 list.add(0, userlist.get(0).getCreate_signup());
		 list.add(0, userlist.get(0).getId());
		 list.add(1, userlist.get(0).getEmail());	
		 list.add(1, userlist.get(0).getUser_tell());
		
		return list;
	}
	
	
	
	
	
	public String getCreate_signup() {
		return create_signup;
	}

	public void setCreate_signup(String create_signup) {
		this.create_signup = create_signup;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	private String user_address;
	
	

	
	
	public String getUser_address() {
		return user_address;
	}
	
	public void setuUser_address() {
		this.user_address=user_address;
	}
	
	public String getUser_tell() {
		return user_tell;
	}

	public void setUser_tell(String user_tell) {
		this.user_tell = user_tell;
	}
	
	
	
	
	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUser_code() {
		return user_code;
	}

	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}

	public String getUser_where() {
		return user_where;
	}

	public void setUser_where(String user_where) {
		this.user_where = user_where;
	}

//	public String getNaver_id() {
//		return naver_id;
//	}
//
//	public void setNaver_id(String naver_id) {
//		this.naver_id = naver_id;
//	}


	public String getAfterpassword() {
		return afterpassword ;
	}

	public void setAfterpassword(String afterpassword) {
		this.afterpassword = afterpassword;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
	
}
