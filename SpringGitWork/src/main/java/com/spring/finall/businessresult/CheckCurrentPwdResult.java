package com.spring.finall.businessresult;

public class CheckCurrentPwdResult {
	
	private Long attemptCnt;
	private Boolean status;
	
	
	public CheckCurrentPwdResult(Long attemptCnt, Boolean status) {		
		this.attemptCnt=attemptCnt;
		this.status=status;		
	}


	public Long getAttemptCnt() {
		return attemptCnt;
	}


	public void setAttemptCnt(Long attemptCnt) {
		this.attemptCnt = attemptCnt;
	}


	public Boolean getStatus() {
		return status;
	}


	public void setStatus(Boolean status) {
		this.status = status;
	}
	

}
