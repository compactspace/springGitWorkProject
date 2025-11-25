package com.spring.finall.user;

public class TermsMasterVO {

    private Integer termsCode;
    private String termsKey;
    private String termsTitle;
    private String termsType;     // MANDATORY / OPTIONAL
    private String description;
    private java.sql.Timestamp createdAt;

    // getter/setter
    public Integer getTermsCode() {
        return termsCode;
    }

    public void setTermsCode(Integer termsCode) {
        this.termsCode = termsCode;
    }

    public String getTermsKey() {
        return termsKey;
    }

    public void setTermsKey(String termsKey) {
        this.termsKey = termsKey;
    }

    public String getTermsTitle() {
        return termsTitle;
    }

    public void setTermsTitle(String termsTitle) {
        this.termsTitle = termsTitle;
    }

    public String getTermsType() {
        return termsType;
    }

    public void setTermsType(String termsType) {
        this.termsType = termsType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
