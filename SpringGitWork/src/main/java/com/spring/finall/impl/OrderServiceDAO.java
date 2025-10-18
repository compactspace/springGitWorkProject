package com.spring.finall.impl;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderPersonDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;

@Repository
public class OrderServiceDAO {

    @Autowired
    private SqlSessionTemplate mybatis;

    // 1. 주문 기본 정보 insert (order_info)
    public Long insertOrderInfo(OrderRequestDTO orderRequest) {
        mybatis.insert("OrderDAO.insertOrderInfo", orderRequest);
        // order_info_id는 MyBatis에서 useGeneratedKeys로 orderRequest에 자동 set된다고 가정
        return orderRequest.getOrderInfoId();
    }

    // 2. 주문 상품들 insert (order_item)
    public int insertOrderItems(Long orderInfoId, List<OrderItemDTO> items) {
        Map<String, Object> param = new HashMap<>();
        param.put("orderInfoId", orderInfoId);
        param.put("list", items);
        int affectedRows =   mybatis.insert("OrderDAO.insertOrderItems", param);
        
        return affectedRows;
    }

    // 3. 주문자 정보 insert (order_person)
    public int insertOrderPerson(Long orderInfoId, OrderPersonDTO person) {
        Map<String, Object> param = new HashMap<>();
        param.put("orderInfoId", orderInfoId);
        param.put("name", person.getName());
        param.put("email", person.getEmail());
        param.put("phone", person.getPhone());
        int affectedRows =  mybatis.insert("OrderDAO.insertOrderPerson", param);
        
        return affectedRows;
    }
    
    
    // 2. 페이징으로 6개월 이내 주문 목록 조회
    public List<OrderPaymentRequestDTO> selectOrdersByDateWithPaging(LocalDate startDate, LocalDate endDate, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("offset", offset);
        params.put("limit", limit);

        return mybatis.selectList("OrderDAO.selectOrdersByDateWithPaging", params);
    }
}
