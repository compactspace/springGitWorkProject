package com.spring.finall.reqDto.workRequest;

public class WorkDTO {
    private int workId;
    private int userCode;
    private int onedayclassNum;
    private String title;
    private String content;
    private java.util.Date createdAt;

    // 기본 생성자
    public WorkDTO() {}

    // 전체 필드 생성자
    public WorkDTO(int workId, int userCode, int onedayclassNum, String title, String content, java.util.Date createdAt) {
        this.workId = workId;
        this.userCode = userCode;
        this.onedayclassNum = onedayclassNum;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
    }

    // Getter / Setter
    public int getWorkId() {
        return workId;
    }
    public void setWorkId(int workId) {
        this.workId = workId;
    }

    public int getUserCode() {
        return userCode;
    }
    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public int getOnedayclassNum() {
        return onedayclassNum;
    }
    public void setOnedayclassNum(int onedayclassNum) {
        this.onedayclassNum = onedayclassNum;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public java.util.Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }
}
