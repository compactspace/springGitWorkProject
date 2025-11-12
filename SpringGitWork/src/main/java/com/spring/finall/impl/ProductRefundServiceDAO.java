package com.spring.finall.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.refundRequest.ProductRefundDTO;

@Repository
public class ProductRefundServiceDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	
	boolean existsByPaymentId(ProductRefundDTO refundDTO) {
	    ProductRefundDTO result = mybatis.selectOne("productRefundMapper.existsByPaymentId", refundDTO);
	    return result != null;
	}
	
	
	
	
	 boolean reqeustRefund(ProductRefundDTO refundDTO) {		 
		 
		 
		int affectedRow= mybatis.insert("productRefundMapper.productReqeustRefund",refundDTO);
		 
		 return affectedRow>=1? true : false;
	 }

}
