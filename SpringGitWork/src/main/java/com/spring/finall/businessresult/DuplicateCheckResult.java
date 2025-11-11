package com.spring.finall.businessresult;

public class DuplicateCheckResult {

	// HTTP 응답 코드 숫자
	private int statusCode;

	// 비즈니스 상태가 성공했는지 여부
	private boolean bussinessStatus;

	private String bussinessFaileReason;

	private String bussinessSuccessReason = "별탈없이 이루어짐";

	// 🔹 기본 생성자
	public DuplicateCheckResult() {
	}

	// 🔹 전체 필드를 받는 생성자
	public DuplicateCheckResult(int statusCode, boolean bussinessStatus, String bussinessStatusReason) {
		this.statusCode = statusCode;
		this.bussinessStatus = bussinessStatus;
		
		if(!bussinessStatus) {
			
			this.bussinessFaileReason = bussinessStatusReason;
		}
		else {
			this.bussinessSuccessReason = bussinessStatusReason;
		}
	}
	
	
	
	

	public DuplicateCheckResult(int statusCode, boolean bussinessStatus) {
		this.statusCode = statusCode;
		this.bussinessStatus = bussinessStatus;
		this.bussinessSuccessReason = bussinessSuccessReason;
	}

	// 🔹 Getter & Setter
	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public boolean isBussinessStatus() {
		return bussinessStatus;
	}

	public void setBussinessStatus(boolean bussinessStatus) {
		this.bussinessStatus = bussinessStatus;
	}

	public String getBussinessFaileReason() {
		return bussinessFaileReason;
	}

	public void setBussinessFaileReason(String bussinessFaileReason) {
		this.bussinessFaileReason = bussinessFaileReason;
	}

	public String getBussinessSuccessReason() {
		return bussinessSuccessReason;
	}

	public void setBussinessSuccessReason(String bussinessSuccessReason) {
		this.bussinessSuccessReason = bussinessSuccessReason;
	}
}