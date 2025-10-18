package com.spring.finall.user.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.ProductVO;


@Repository
public class AftterPayDAOMyBatis {

	@Autowired
	private SqlSessionTemplate mybatis;
	@Transactional
	public int AftterPayUpdateQuery(String[] cart_id,String user_code,String[] cart_quantity_array,String[] product_cod_array,PayVO pvo) throws PayRunTimeTranException {

		
		// 아작스 파라미터도, 커맨드 객체가 반응하니 pvo.set은 주석처리했다잉		
	
		System.out.println("카트번호 배열:  "+Arrays.toString(cart_id));
		System.out.println("각 번호에대 해한 수량배열:  "+Arrays.toString(cart_quantity_array ));		
		System.out.println("담긴 상품코드 배열 :  "+Arrays.toString(product_cod_array));
		System.out.println("주문의 총 수량:  "+pvo.getReceipt_paid_amount());
		System.out.println("주문자의 로그인 id :  "+pvo.getId());
		System.out.println("주문자의 유저 코드: "+user_code);
		
		
		
		
		
		
		for (int k = 0; k < cart_id.length; k++) {
			// System.out.println(cart_id[k]);

			// 여기서 결제가 완료된 후니 여기서 제품 테이블의 주문 수량을 삽입한다.
			// 여기서도 논리가 꼬일 수 있다. 최초 주문자라면 인설트문이 유리 하다. 혹은 업데이트문이 유리 할수도있다.
			// 그러나? 사용자는 여러명이라. 먼저 해당 product_order_quantity 컬럼을 조회하는 select 문도 필요하다.
			// 따라서 select 문으로 먼저 product_order_quantity 를 조회 한후 값을 빼화
			// 업데이트문으로 + 처리를 하자.

			updateOrderQuantity(Integer.parseInt(cart_quantity_array[k]), Integer.parseInt(product_cod_array[k]));

			// 다시한번 말하지만 하나의 주문번호=merchant_uid 에 여러개의 카트 아이디가 있는데 환불은 모두 되어야함
			// 부분 수량환불 이딴거 없어서 아래처럼 데이터를 넣는다.
			// 런타임 에러 롤백이 않되 맨위에 있던 코드를 if문 아래로 내렸다. ㅂㄷ ㅂㄷ 아래로 옮겨야 주문 수량 오류 종료가 된뒤 오더인포 발급안함
			insertgeneralorderinfo(Integer.parseInt(cart_id[k]), Integer.parseInt(user_code));

			afgerpaycartupdate(Integer.parseInt(cart_id[k]));

			// 다시한번 말하지만 하나의 주문번호=merchant_uid 에 여러개의 카트 아이디가 있는데 환불은 모두 되어야함
			// 부분 수량환불 이딴거 없어서 아래처럼 데이터를 넣는다.
			insertPay(pvo, Integer.parseInt(cart_id[k]));

		}

		return 0;
	}

	// 결제이후 재고량을 반영
	public int updateOrderQuantity(int cart_quantity, int product_cod) throws PayRunTimeTranException {

		HashMap<String, Object> map = new HashMap();
		ProductVO executequery = mybatis.selectOne("ProductVO.checkOrderQuantity", product_cod);
		int product_order_quantity = executequery.getProduct_order_quantity();
		int overquantity = executequery.getproduct_quantity();

		// 상품코드 6 에대한 주문 수량 0
		System.out.println("상품코드 " + product_cod + "카트에 담에담긴 주문수량 " + cart_quantity + "기존 테이블에 있던  주문 수량 "
				+ product_order_quantity);

		// 역시 어느때나..최초 연산이 문제다 0 일때는 따로 대입일 해주자.
		if (product_order_quantity == 0) {
			product_order_quantity = cart_quantity;
		}

		if (cart_quantity >= overquantity) {
			throw new PayRunTimeTranException("그새 누가 결제해서 내 주문이 상품재고보다 많은 경우 에러임");
		}

		map.put("product_order_quantity", product_order_quantity);
		map.put("product_cod", product_cod);
//		System.out.println("마이바티스 삽입직전 제품 주문 수량 " + product_order_quantity + " 그리고 제품 코드" + product_cod);
		mybatis.update("ProductVO.updateQuantity", map);
		mybatis.update("ProductVO.updateDeliveryQuantity", map);
		System.out.println("내가 뜨면 업데이트 베티스 오류 없음");
		return 0;
	}

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

	// 결제이후 장바구니 테이블중 결제된 상품만 결제되었다 업데이트 해줌
	public int afgerpaycartupdate(int cart_id) throws PayRunTimeTranException {
		HashMap<String, Object> map = new HashMap();
		map.put("cart_id", cart_id);

		try {
			int executerow = mybatis.insert("CartVO.afgerpaycartupdate", map);
		} catch (Exception e) {

			throw new PayRunTimeTranException("결제는 되었으나, 카트테이블 업데이트시 에러");
		} finally {
			int cartUpdate_status_code = 1;
			return cartUpdate_status_code;

		}

	}

	// 결제 정보를 삽입
	public void insertPay(PayVO pvo, Integer cart_id) throws PayRunTimeTranException {
		System.out.println("서비스에서도 머첸츠 유아이디가 " + pvo.getReceipt_merchant_uid());
		System.out.println("카트 아이디가 널?" + cart_id);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receipt_merchant_uid", pvo.getReceipt_merchant_uid());
		map.put("receipt_paid_amount", pvo.getReceipt_paid_amount());
		map.put("id", pvo.getId());
		map.put("cart_id", cart_id);

		try {
			 mybatis.insert("payVO.insertPay", map);
			
		} catch (Exception e) {
			throw new PayRunTimeTranException("결제는 되었으나 지불 테이블 데이터 삽입시 에러");
		}
	}

}
