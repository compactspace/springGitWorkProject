package com.spring.finall.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.service.PaymentServcie;

@Service
public class PaymentServiceImple implements PaymentServcie {

	@Autowired
	private PaymentServiceDAO paymentServiceDAO;
	
	@Override
	public PaymentDTO processPayment(PaymentDTO paymentRequest) {
		// TODO Auto-generated method stub
		return null;
	}

}
