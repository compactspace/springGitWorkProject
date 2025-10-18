package com.spring.finall.reqDto.wrapperRequest;

import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;

public class OrderPaymentRequestDTO {
    private OrderRequestDTO order;
    private PaymentDTO payment;
    
    
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
  
    
    
   
}