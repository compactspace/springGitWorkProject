package com.spring.finall.user;

public class TermsVersionVO {

    private Integer versionId;
    private Integer termsCode;
    private Integer versionNo;
    private String content;
    private Boolean isActive;
    private java.sql.Timestamp createdAt;

    // getter/setter
    public Integer getVersionId() {
        return versionId;
    }

    public void setVersionId(Integer versionId) {
        this.versionId = versionId;
    }

    public Integer getTermsCode() {
        return termsCode;
    }

    public void setTermsCode(Integer termsCode) {
        this.termsCode = termsCode;
    }

    public Integer getVersionNo() {
        return versionNo;
    }

    public void setVersionNo(Integer versionNo) {
        this.versionNo = versionNo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
