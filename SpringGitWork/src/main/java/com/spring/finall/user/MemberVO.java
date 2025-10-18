package com.spring.finall.user;

public class MemberVO {
	
	private String id;
	private String password;
	
	
	//UserVO 랑 비슷한 역활함 일딴 살려두자 
	private String afterpassword;

	// 여기서부터는 새롭게 추가된 컬럼들

	private int user_code;

	public String getAfterpassword() {
		return afterpassword;
	}
	public void setAfterpassword(String afterpassword) {
		this.afterpassword = afterpassword;
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
	public String getNaver_id() {
		return naver_id;
	}
	public void setNaver_id(String naver_id) {
		this.naver_id = naver_id;
	}
	private String user_where;

	private String naver_id;
	
	
	
	
	
	
	
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
