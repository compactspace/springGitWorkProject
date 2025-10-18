package com.spring.finall.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.AftterPayService;
import com.spring.finall.user.PayVO;



@Service("aftterPayService")
public class AftterPayServiceImpl implements AftterPayService {

	@Autowired
	AftterPayDAOMyBatis aftterPayDAOMyBatis;
	
	@Override
	public void AftterPayUpdateService(String[] cart_id,String user_code,String[] cart_quantity_array,String[] product_cod_array,PayVO pvo)  throws PayRunTimeTranException {
		
		aftterPayDAOMyBatis.AftterPayUpdateQuery(cart_id,user_code,cart_quantity_array, product_cod_array, pvo);
	}

	
	
	
}
