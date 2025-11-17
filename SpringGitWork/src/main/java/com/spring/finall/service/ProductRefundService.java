package com.spring.finall.service;

import java.time.LocalDate;
import java.util.Map;

import com.spring.finall.reqDto.refundRequest.ProductRefundDTO;

public interface ProductRefundService {
	
	boolean reqeustRefund(ProductRefundDTO refundDTO);
	
	
	
    Map<String,Object>	getProductRefundCountByTodayAndWeek(LocalDate startOfWeek ,LocalDate endOfWeek );

}
