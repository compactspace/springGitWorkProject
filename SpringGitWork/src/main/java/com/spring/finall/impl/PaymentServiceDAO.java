package com.spring.finall.impl;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.payMentRequest.PaymentDTO;

@Repository
public class PaymentServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int insertPayment(PaymentDTO paymentDTO) {
		int affectedRow = mybatis.insert("PaymentDAO.insertPayment", paymentDTO);
		return affectedRow;
	}

	
	
	public boolean updateProductRefund(String orderInfoId , String paymentId) {
		
		
		Map<String,Object> params= new HashMap<>();
		params.put("orderInfoId", orderInfoId);
		params.put("paymentId", paymentId);
		int affectedRow = mybatis.update("PaymentDAO.updateProductRefund", params);
		
		return affectedRow>0? true : false;
		
		
	}
	
	
	
	
	
	
	
	
}
