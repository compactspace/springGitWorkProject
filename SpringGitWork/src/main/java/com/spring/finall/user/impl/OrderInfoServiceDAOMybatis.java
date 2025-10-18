package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.OrderInfoVO;

@Repository
public class OrderInfoServiceDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 일반 상품 카트에 담은후 주문테이블에 삽입
	public int insertgeneralorderinfo(int cart_id, int user_code) throws PayRunTimeTranException {

		HashMap<String, Object> map = new HashMap();

		map.put("cart_id", cart_id);
		map.put("user_code", user_code);

		try {
			int executerow = mybatis.insert("OrderInfoVO.insertgeneralorderinfo", map);
			System.out.println("인설트 연산값 ->> 1 이면 재대로 반영됨" + executerow);

		} catch (Exception e) {

			throw new PayRunTimeTranException("결제는 되었으나 주문정보 테이블 삽입시 익셉션");
		} finally {
			
			int order_status_code = 1;
			return order_status_code;

		}

	}

	// 일반 상품 결제 현황 보기위해 출력
	public List<OrderInfoVO> mypayinfo(OrderInfoVO ovo) {

//		List<OrderInfoVO> lists = new List<OrderInfoVO>();

		List<OrderInfoVO> lists = mybatis.selectList("OrderInfoVO.mypayinfo", ovo);
//	System.out.println("받은 유저 코드->>"+ovo.getUser_code());	
//	System.out.println(lists.size());

//	System.out.println("조인당항 카트테이블의 상품명 "+lists.get(0).getCartvo().getProduct_name());		
//	System.out.println("조인당항 카트테이블의 수량 "+lists.get(0).getCartvo().getCart_quantity());
//	
//	System.out.println("조인당항 카트테이블의 상품명 "+lists.get(1).getCartvo().getProduct_name());		
//	System.out.println("조인당항 카트테이블의 수량 "+lists.get(1).getCartvo().getCart_quantity());
//	
//	
//	System.out.println("조인당항 카트테이블의 상품명 "+lists.get(3).getCartvo().getProduct_name());		
//	System.out.println("조인당항 카트테이블의 수량 "+lists.get(3).getCartvo().getCart_quantity());

//	System.out.println("------------------구분선-----------------------");
//	
//	for(OrderInfoVO vo: lists) {
//		
//		System.out.println("조인당항 카트테이블 "+vo.getCartvo());		
//		
//		
//	}
//		

		return lists;

	}

	public void insertorderinfo(OrderInfoVO vo) {
		System.out.println("베티스 매핑 확인");
		System.out.println("유저코드" + vo.getUser_code());
		System.out.println("카트아이디" + vo.getCart_id());
		mybatis.insert("OrderInfoVO.insertorderinfo", vo);

	}

	public void payupdate(int cart_id) {
		mybatis.update("OrderInfoVO.payupdate", cart_id);
	};

}
