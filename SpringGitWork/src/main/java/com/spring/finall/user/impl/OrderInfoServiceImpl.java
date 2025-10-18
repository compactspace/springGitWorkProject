package com.spring.finall.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.CustomException.PayRunTimeTranException;

import com.spring.finall.user.OrderInfoService;
import com.spring.finall.user.OrderInfoVO;

@Service("OrderInfoService")
public class OrderInfoServiceImpl implements OrderInfoService {

	@Autowired
	private OrderInfoServiceDAOMybatis orderInfodao;

	@Override
	public void insertorderinfo(OrderInfoVO vo) {
		orderInfodao.insertorderinfo(vo);

	}

	// 일반 상품 주문 정보에 추가
	@Override
	public int insertgeneralorderinfo(int cart_id, int user_code) throws  PayRunTimeTranException {
		int order_status_code = orderInfodao.insertgeneralorderinfo(cart_id, user_code);		
		return order_status_code;
	}

	// 일반 상품 결제 현황을 보기위해 출력
	public List<OrderInfoVO> mypayinfo(OrderInfoVO ovo) {

		return orderInfodao.mypayinfo(ovo);

	}

//	@Override
//	public List<OrderInfoVO> selectordercode(OrderInfoVO vo){
//		
//		orderInfodao.selectordercode
//		
//	}
//	

	@Override
	public void payupdate(int cart_id) {

		orderInfodao.payupdate(cart_id);
	};

}
