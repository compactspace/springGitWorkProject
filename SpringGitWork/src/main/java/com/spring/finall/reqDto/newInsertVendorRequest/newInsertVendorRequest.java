package com.spring.finall.reqDto.newInsertVendorRequest;

public class newInsertVendorRequest {

    private String name;
    private String businessNumber;
    private String settlementType;
    private String deliveryType;
    private String status;

    // 기본 생성자
    public newInsertVendorRequest() {}

    // Getter & Setter
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
    @Override
    public String toString() {
        return "newInsertVendorRequest{" +
                "name='" + name + '\'' +
                ", businessNumber='" + businessNumber + '\'' +
                ", settlementType='" + settlementType + '\'' +
                ", deliveryType='" + deliveryType + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
