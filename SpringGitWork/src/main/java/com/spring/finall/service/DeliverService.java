package com.spring.finall.service;

import java.util.List;

import com.spring.finall.reqDto.deliverRequest.RequestDeliverDTO;

public interface DeliverService {
	
	boolean	ShipmentItem(List<RequestDeliverDTO> requestList);

}
