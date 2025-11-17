package com.spring.finall.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	 
	 
	 public Map<String, Object> getProductRefundCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {

	        Map<String,Object> params = new HashMap<>();
	        params.put("startOfWeek", startOfWeek);
	        params.put("endOfWeek", endOfWeek);

	        // DB 조회
	        List<Map<String,Object>> list = mybatis.selectList("productRefundMapper.getProductRefundCountByTodayAndWeek", params);

	        int todayCount = 0;
	        int weekCount = 0;

	        LocalDate today = LocalDate.now();

	        for (Map<String,Object> m : list) {
	            Object obj = m.get("requested_at");
	            LocalDate orderDate;

	            if (obj instanceof java.sql.Timestamp) {
	                orderDate = ((java.sql.Timestamp) obj).toLocalDateTime().toLocalDate();
	            } else if (obj instanceof java.sql.Date) {
	                orderDate = ((java.sql.Date) obj).toLocalDate();
	            } else if (obj instanceof java.util.Date) { // 혹시 java.util.Date
	                orderDate = ((java.util.Date) obj).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	            } else {
	                throw new IllegalArgumentException("Unsupported date type: " + obj.getClass());
	            }

	            if (orderDate.isEqual(today)) {
	                todayCount++;
	            }

	            if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(endOfWeek)) {
	                weekCount++;
	            }
	        }

	        Map<String,Object> result = new HashMap<>();
	        result.put("todayProductRefund", todayCount);
	        result.put("weekProductRefund", weekCount);

	        return result;
	    }


}
