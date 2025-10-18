package com.spring.finall;

//여기선 단순 회원가입전
public class AuthVO {

	int authnumber;

	String auth_check; 
	
	String phone;
	
	
	int randomNumber = (int) (Math.random() * 899999) + 100000; // 100000 ~ 999999까지의 무작위 수
	
	
	
	
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setAuthNumber(int authNumber) {
		this.authnumber = authNumber;
	}

	public int getAuthNumber() {
		return authnumber;
	}

	public String getAuth_check() {
		return auth_check;
	}

	public void setAuth_check(String auth_check) {
		this.auth_check = auth_check;
	}
	
	
	
	
}
