package com.spring.finall.reqDto.InsertDraftReserveinfoRequestDTO;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class InsertDraftReserveinfoDTO {

    private Long draftReserveinfoNum;
    private String merchantUid;
    private int userCode;
    private Long onedayclassNum;
    private LocalDate selectedDate;
    private Integer onedayclassPrice;
    private String status;
    private LocalDateTime createdAt;

    public InsertDraftReserveinfoDTO() {
    }

    public Long getDraftReserveinfoNum() {
        return draftReserveinfoNum;
    }

    public void setDraftReserveinfoNum(Long draftReserveinfoNum) {
        this.draftReserveinfoNum = draftReserveinfoNum;
    }

    public String getMerchantUid() {
        return merchantUid;
    }

    public void setMerchantUid(String merchantUid) {
        this.merchantUid = merchantUid;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public Long getOnedayclassNum() {
        return onedayclassNum;
    }

    public void setOnedayclassNum(Long onedayclassNum) {
        this.onedayclassNum = onedayclassNum;
    }

    public LocalDate getSelectedDate() {
        return selectedDate;
    }

    public void setSelectedDate(LocalDate selectedDate) {
        this.selectedDate = selectedDate;
    }

    public Integer getOnedayclassPrice() {
        return onedayclassPrice;
    }

    public void setOnedayclassPrice(Integer onedayclassPrice) {
        this.onedayclassPrice = onedayclassPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}