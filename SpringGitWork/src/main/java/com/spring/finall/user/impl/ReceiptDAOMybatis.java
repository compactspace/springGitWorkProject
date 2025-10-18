package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.ReceiptVO;
@Repository
public class ReceiptDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertReceipt(ReceiptVO vo) {
		System.out.println("insertReceipt 가 호출이되나요옹");
		mybatis.insert("ReceiptVO.insertReceipt",vo);
		
	}
	
	public void deleteReceipt(ReceiptVO vo) {
		mybatis.delete("ReceiptVO.deleteReceipt",vo);
		
	}
	
	
	public List<HashMap<String,Object>> testcanclequantity() {
		
		return  mybatis.selectList("ReceiptVO.testcanclequantity");
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
