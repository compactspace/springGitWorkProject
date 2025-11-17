package com.spring.finall.user.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductVO;

@Repository
public class ProductDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<ProductVO> productlist(ProductVO vo) {

		return mybatis.selectList("ProductVO.productlist", vo);

		// return mybatis.selectList("ProductVO.productlist", vo);
	}

	// 일반 상품 최초 링크를 타거나 제품군 선택시 호출되는 메서드
	public List<Map<String, Object>> productGroupLlist(ProductVO vo) {
	    List<Map<String, Object>> list = mybatis.selectList("ProductVO.producGroupLlist", vo);
	
	    return list;
	}


	public List<ProductGroupVO> getProductGroupList() {
		List<ProductGroupVO> list = mybatis.selectList("ProductVO.getProductGroupList");
		return list;
	}

	
	
	
	

	
	public int updateOrderQuantity(int cart_quantity, int product_cod) throws PayRunTimeTranException {

		HashMap<String, Object> map = new HashMap();
		ProductVO executequery = mybatis.selectOne("ProductVO.checkOrderQuantity", product_cod);
		int product_order_quantity = executequery.getProduct_order_quantity();
		int overquantity = executequery.getProduct_quantity();

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

	public int completequantity(HashMap<String, ArrayList<Object>> map) {

		HashMap<String, Object> hmap;

		System.out.println("map->>" + map.get("code"));
		try {
			for (int k = 0; k < map.get("code").size(); k++) {
				System.out.println(map.get("code").get(k));
				System.out.println(map.get("quantity").get(k));
				hmap = new HashMap<String, Object>();
				hmap.put("quantity", map.get("quantity").get(k));
				hmap.put("code", map.get("code").get(k));
				mybatis.update("ProductVO.completequantity", hmap);
				hmap = null;
			}
			return 1;
		} catch (Exception e) {

			return -1;
		}

	}

}
