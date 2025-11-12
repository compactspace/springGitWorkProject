package com.spring.finall.reqDto.wrapperRequest;

import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.refundRequest.ProductRefundDTO;

public class OrderPaymentRequestDTO {
    private OrderRequestDTO order;
    private PaymentDTO payment;
    private ProductRefundDTO refund; // 새로 추가
    
	public OrderRequestDTO getOrder() {
		return order;
	}
	public void setOrder(OrderRequestDTO order) {
		this.order = order;
	}
	public PaymentDTO getPayment() {
		return payment;
	}
	public void setPayment(PaymentDTO payment) {
		this.payment = payment;
	}
  
	 public ProductRefundDTO getRefund() {
	        return refund;
	    }
	    public void setRefund(ProductRefundDTO refund) {
	        this.refund = refund;
	    }
    
   
}