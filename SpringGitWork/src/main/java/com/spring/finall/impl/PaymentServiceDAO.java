package com.spring.finall.impl;

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

}
