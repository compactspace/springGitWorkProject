package com.spring.finall.RabitEvent;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ReserveEvent implements Serializable {

    private static final long serialVersionUID = 1L;

    @JsonProperty("user_code")
    private int userCode;

    @JsonProperty("payment_method")
    private String paymentMethod;

    @JsonProperty("merchant_uid")
    private String merchantUid;

    // Getters and Setters
    public Integer getUserCode() {
        return userCode;
    }

    public void setUserCode(Integer userCode) {
        this.userCode = userCode;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getMerchantUid() {
        return merchantUid;
    }

    public void setMerchantUid(String merchantUid) {
        this.merchantUid = merchantUid;
    }
}
