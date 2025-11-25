package com.spring.finall.user;

public class UserTermsAgreeRecordVO {

	private Long agreeId;
	private Integer userCode;
	private Integer termsCode;
	private Integer versionId;
	private Boolean agreed;
	private java.sql.Timestamp agreedAt;

	// getter/setter
	public Long getAgreeId() {
		return agreeId;
	}

	public void setAgreeId(Long agreeId) {
		this.agreeId = agreeId;
	}

	public Integer getUserCode() {
		return userCode;
	}

	public void setUserCode(Integer userCode) {
		this.userCode = userCode;
	}

	public Integer getTermsCode() {
		return termsCode;
	}

	public void setTermsCode(Integer termsCode) {
		this.termsCode = termsCode;
	}

	public Integer getVersionId() {
		return versionId;
	}

	public void setVersionId(Integer versionId) {
		this.versionId = versionId;
	}

	public Boolean getAgreed() {
		return agreed;
	}

	public void setAgreed(Boolean agreed) {
		this.agreed = agreed;
	}

	public java.sql.Timestamp getAgreedAt() {
		return agreedAt;
	}

	public void setAgreedAt(java.sql.Timestamp agreedAt) {
	        this.agreedAt = agreedAt;
	    }
	
}
