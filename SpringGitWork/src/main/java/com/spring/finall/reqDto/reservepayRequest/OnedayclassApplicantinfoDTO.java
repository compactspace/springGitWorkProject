package com.spring.finall.reqDto.reservepayRequest;

public class OnedayclassApplicantinfoDTO {
    
    private Long applicantId;
    private Integer userCode;
    private String name;
    private String phone;
    private String email;
    private java.sql.Timestamp createdAt;

    // 생성자 없음 – 수동으로 객체 세팅
    // getter / setter도 직접 작성 가능

    // 예시용 기본 getter/setter 아래 포함
    public Long getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public Integer getUserCode() {
        return userCode;
    }

    public void setUserCode(Integer userCode) {
        this.userCode = userCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
