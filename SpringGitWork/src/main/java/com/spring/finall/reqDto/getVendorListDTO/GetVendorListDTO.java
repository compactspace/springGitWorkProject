package com.spring.finall.reqDto.getVendorListDTO; 

import java.sql.Timestamp;

public class GetVendorListDTO {

    private int vendorId;
    private String name;
    private String businessNumber;
    private String settlementType;  // 'MONTHLY' / 'IMMEDIATE'
    private String deliveryType;    // 'SAIPH' / 'DROPSHIP'
    private String status;          // 'ACTIVE' / 'INACTIVE'
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 기본 생성자
    public GetVendorListDTO() {}

    // 전체 생성자
    public GetVendorListDTO(int vendorId, String name, String businessNumber,
                            String settlementType, String deliveryType, String status,
                            Timestamp createdAt, Timestamp updatedAt) {
        this.vendorId = vendorId;
        this.name = name;
        this.businessNumber = businessNumber;
        this.settlementType = settlementType;
        this.deliveryType = deliveryType;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter & Setter
    public int getVendorId() {
        return vendorId;
    }

    public void setVendorId(int vendorId) {
        this.vendorId = vendorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBusinessNumber() {
        return businessNumber;
    }

    public void setBusinessNumber(String businessNumber) {
        this.businessNumber = businessNumber;
    }

    public String getSettlementType() {
        return settlementType;
    }

    public void setSettlementType(String settlementType) {
        this.settlementType = settlementType;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
