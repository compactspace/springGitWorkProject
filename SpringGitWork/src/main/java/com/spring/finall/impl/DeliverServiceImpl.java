package com.spring.finall.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.reqDto.deliverRequest.RequestDeliverDTO;
import com.spring.finall.service.DeliverService;
import com.spring.finall.service.OrderService;

@Service
public class DeliverServiceImpl implements DeliverService {

	
	@Autowired
	private DeliverServiceDAO deliverServiceDAO;
	
	@Autowired
	private OrderServiceDAO   orderServiceDAO;
	
	@Override
	@Transactional
	public boolean ShipmentItem(List<RequestDeliverDTO> requestList) {		
		deliverServiceDAO.updateInventoryQuantiryByInventoryId(requestList);
		deliverServiceDAO.recodeInventoryLogByShipmentItem(requestList);
		deliverServiceDAO.insertShipmentByShipmentItem(requestList);
		orderServiceDAO.updateStatusToShippingByShipping(requestList);
		return true;
	}

}
