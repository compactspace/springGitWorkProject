package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.ProductVO;
import com.spring.finall.user.UserVO;

@Repository
public class PayDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void insertPay(PayVO pvo, Integer cart_id) throws PayRunTimeTranException {
		System.out.println("서비스에서도 머첸츠 유아이디가 " + pvo.getReceipt_merchant_uid());
		System.out.println("카트 아이디가 널?" + cart_id);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receipt_merchant_uid", pvo.getReceipt_merchant_uid());
		map.put("receipt_paid_amount", pvo.getReceipt_paid_amount());
		map.put("id", pvo.getId());
		map.put("cart_id", cart_id);
		
		
		
		try {

			
			System.out.println(1/0);
		} catch (Exception e) {
			throw new PayRunTimeTranException("결제는 되었으나 지불 테이블 데이터 삽입시 에러");
		}

	}

	public List<PayVO> showpaylist(PayVO pvo) {

		System.out.println("게시빨 받앗냐->>" + pvo.getId());

		List<PayVO> executeqeury = mybatis.selectList("payVO.showpaylistjoin", pvo);

//	System.out.println("executeqeury.size()->>"+executeqeury.size());
////		
//		System.out.println("executeqeury->>"+executeqeury);

//		for(PayVO ppvo:executeqeury) {
//			System.out.println("ppvo.getCartvo()"+ppvo.getCartvo());
//			System.out.println("----------------------------------------------------------------------------------------");			
//			System.out.println("ppvo.getCartvo()"+ppvo.getOrderinfovo());
//			
//		}

		return executeqeury;

	}

	// 단건 상세 조회임
	public List<PayVO> mypaydetailinfo(UserVO uvo, PayVO pvo) {

		String receipt_merchant_uid = pvo.getReceipt_merchant_uid();
		String id = uvo.getId();
		HashMap<String, Object> map = new HashMap();
		map.put("id", uvo.getId());
		map.put("receipt_merchant_uid", receipt_merchant_uid);

		List<PayVO> executeqeury = mybatis.selectList("payVO.showpayjoin", map);
		System.out.println(executeqeury);

		return executeqeury;
	}

	// 취소를 위해 우선 카트번호들을 뽑아옴

	public Integer cancellistcartid(PayVO pvo) {		
		
		
		HashMap<String,Object> map = new HashMap();
		
		try {
			System.out.println("트라이문? 속 거래번호"+pvo.getReceipt_merchant_uid());
			List<PayVO> executeqeury = mybatis.selectList("payVO.cancellistcartid", pvo);
			
			System.out.println(executeqeury);
//			System.out.println(executeqeury);
//			System.out.println("----------------------------------------------------");
//			System.out.println(executeqeury.get(0));
//			System.out.println("----------------------------------------------------");
//			System.out.println(executeqeury.get(0).getCartvo());
//			System.out.println("----------------------------------------------------");
//			System.out.println(executeqeury.get(1));
//			System.out.println("----------------------------------------------------");
//			System.out.println(executeqeury.get(1).getCartvo());
			
			
			//결제 취소니 재고는 역산이다.
			// 먼저 카트 아이디에 담긴 주문 수량을 빼온뒤 상품테이블의 주문컬럼에서 빼준다
			// 그다음 상품테이블의 딜리버 주문수량에서도 빼준다.
			
			for(int k=0; k<executeqeury.size(); k++) {
				System.out.println("고유한 거래 번호 한개에 대한 카트아이디가 가지고 있는 상품코드 :" +executeqeury.get(k).getCartvo().get(0).getProduct_cod());
				Integer product_cod=executeqeury.get(k).getCartvo().get(0).getProduct_cod();
				Integer product_order_quantity=executeqeury.get(k).getCartvo().get(0).getCart_quantity();
				System.out.println("마이바티스 삽입직전 제품 주문 수량 "+product_order_quantity+" 그리고 제품 코드"+product_cod);
				map.put("product_order_quantity", product_order_quantity);
				map.put("product_cod", product_cod);		
				
				
				mybatis.update("ProductVO.updateMinusQuantity",map);	
				mybatis.update("ProductVO.updateMinusDeliveryQuantity",map);	
				ProductVO	 pvos	=mybatis.selectOne("ProductVO.showDeliveryQuantity",map);	
			
				System.out.println("----------------------투스트링 pvos는---------------------------");
				System.out.println(pvos);
				System.out.println("창고재고 "+pvos.getproduct_quantity());
				System.out.println("취소하려는 수량 "+pvos.getProduct_delivery_quantity());
			// product_quantity = product_delivery_quantity 일치하면 호출됨  창고재고와 일치하게 되면 0으로 만들어주자.
			if(pvos.getproduct_quantity()==pvos.getProduct_delivery_quantity()) {
				
				mybatis.update("ProductVO.zeroDeliveryQuantity",map);	
				
			}	
				
				//상품코드 6 에대한 주문 수량 0
				
				
				System.out.println("고유한 거래 번호 한개에 대한 카트아이디들 :" +executeqeury.get(k).getCartvo().get(0).getCart_id());
				Integer cart_id=executeqeury.get(k).getCartvo().get(0).getCart_id();
				mybatis.update("OrderInfoVO.paycanclegeneral", cart_id);	
			}			
			
			return 1;
		}catch(Exception e) {
		System.out.println(e);
			return -1;
		}
	
		
	
	}

}
