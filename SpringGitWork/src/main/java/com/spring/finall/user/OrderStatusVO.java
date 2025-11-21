package com.spring.finall.user;

public class OrderStatusVO {

    private int statusId;           // 상태 고유 ID
    private String statusCode;      // 상태 코드 (Pending, Paid 등)
    private String statusName;      // 화면에 표시할 상태 이름
    private String description;     // 상태 설명
    private boolean isFinal;        // 최종 상태 여부

    // 기본 생성자
    public OrderStatusVO() {
    }

    // getter & setter
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isFinal() {
        return isFinal;
    }

    public void setFinal(boolean isFinal) {
        this.isFinal = isFinal;
    }

}
