package com.spring.finall.service;

import com.spring.finall.reqDto.payMentRequest.PaymentDTO;

public interface PaymentServcie {
   
	PaymentDTO processPayment(PaymentDTO paymentRequest) ;
}
