package com.spring.finall.resDto.mannageUserListResPonse;

import java.io.Serializable;
import java.sql.Timestamp;

public class ManageUserListResponseDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    // 유저 기본 정보
    private int userCode;
    private String id;
    private Timestamp createSignup;
    private String userTell;

    // 약관 동의 여부
    private Boolean agreed;

    // 약관 내용
    private String termsContent;

    // 결제 요약
    private Integer payCnt;

    // 게시글 작성 요약
    private Integer writingCnt;

    // =======================
    // Getter / Setter
    // =======================

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Timestamp getCreateSignup() {
        return createSignup;
    }

    public void setCreateSignup(Timestamp createSignup) {
        this.createSignup = createSignup;
    }

    public String getUserTell() {
        return userTell;
    }

    public void setUserTell(String userTell) {
        this.userTell = userTell;
    }

    public Boolean getAgreed() {
        return agreed;
    }

    public void setAgreed(Boolean agreed) {
        this.agreed = agreed;
    }

    public String getTermsContent() {
        return termsContent;
    }

    public void setTermsContent(String termsContent) {
        this.termsContent = termsContent;
    }

    public Integer getPayCnt() {
        return payCnt;
    }

    public void setPayCnt(Integer payCnt) {
        this.payCnt = payCnt;
    }

    public Integer getWritingCnt() {
        return writingCnt;
    }

    public void setWritingCnt(Integer writingCnt) {
        this.writingCnt = writingCnt;
    }

    @Override
    public String toString() {
        return "ManageUserListResponseDTO{" +
                "userCode=" + userCode +
                ", id='" + id + '\'' +
                ", createSignup=" + createSignup +
                ", userTell='" + userTell + '\'' +
                ", agreed=" + agreed +
                ", termsContent='" + termsContent + '\'' +
                ", payCnt=" + payCnt +
                ", writingCnt=" + writingCnt +
                '}';
    }
}