package com.spring.finall.reqDto.refundRequest;

import java.util.List;

import com.spring.finall.reqDto.orderRequest.OrderItemDTO;

public class AfterSuccesPgRefundDTO {
	
	private String impUid;
    private String merchantUid;
    private String orderInfoId;
    private String paymentId;
    private int amount;
    private List<OrderItemDTO> orderItemList;
    
    
  	
    
    
    
    
    
    // Getter & Setter
    public String getImpUid() {
        return impUid;
    }

    public void setImpUid(String impUid) {
        this.impUid = impUid;
    }

    public String getMerchantUid() {
        return merchantUid;
    }

    public void setMerchantUid(String merchantUid) {
        this.merchantUid = merchantUid;
    }

    public String getOrderInfoId() {
        return orderInfoId;
    }

    public void setOrderInfoId(String orderInfoId) {
        this.orderInfoId = orderInfoId;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public List<OrderItemDTO> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OrderItemDTO> orderItemList) {
        this.orderItemList = orderItemList;
    }
    
    
    

}
