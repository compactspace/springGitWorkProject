package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.user.ReceiptService;
import com.spring.finall.user.ReceiptVO;
@Service("ReceiptServiceImpl")
public class ReceiptServiceImpl implements ReceiptService {
	@Autowired
	private ReceiptDAOMybatis receiptdao;

	@Override
	public void insertReceipt(ReceiptVO vo) {
		receiptdao.insertReceipt(vo);
		
		
	}
	
	@Override
	public void deleteReceipt(ReceiptVO vo) {
		receiptdao.deleteReceipt(vo);
		
		
	}
	@Override
public List<HashMap<String,Object>> testcanclequantity() {
		
		return receiptdao.testcanclequantity();
		
	}
	
	
	
	
	
	

}
