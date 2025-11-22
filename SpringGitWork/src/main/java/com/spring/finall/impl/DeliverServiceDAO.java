package com.spring.finall.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.deliverRequest.RequestDeliverDTO;

@Repository
public class DeliverServiceDAO {

	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void updateInventoryQuantiryByInventoryId(List<RequestDeliverDTO> requestList) {

		
		for(RequestDeliverDTO item : requestList) {
		    mybatis.update("ManageinventoryMapper.updateInventoryQuantiryByInventoryId", item);
		}
		
	}
	
	public void recodeInventoryLogByShipmentItem(List<RequestDeliverDTO> requestList) {

		mybatis.insert("ManageinventoryMapper.recodeInventoryLogByShipmentItem",requestList);
		
	}
	public void insertShipmentByShipmentItem(List<RequestDeliverDTO> requestList) {

		mybatis.insert("ManageinventoryMapper.insertShipmentByShipmentItem",requestList);
		
	}
	

}
