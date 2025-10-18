package com.spring.finall.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.CartService;
import com.spring.finall.user.CartVO;

@Service("cartservice")
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAOMybatis cartdao;

	// 일반 상품전용 카트에 추가
	@Override
	public int generalproductlist(CartVO vo) {
		int executerow = cartdao.generalproductlist(vo);

		return executerow;
	}

	// 일반 상품전용 카트정보를 끌고오기.
	@Override
	public List<CartVO> generalcartlist(CartVO vo) {
		return cartdao.generalcartlist(vo);

	}

	// 일반 상품전용
	@Override
	public int afgerpaycartupdate(int cart_id) throws PayRunTimeTranException {
		return cartdao.afgerpaycartupdate(cart_id);

	}

	// 일반 상품 전용 카트에서 + - 버튼 클릭시 수량 1 -1 씩 증감
	public Integer plusminus(CartVO vo) {
		return cartdao.plusminus(vo);
	};
	
	//일반 상품 카트 버리기
	public Integer dropgeneralcart(CartVO vo) {
		return cartdao.dropgeneralcart(vo);
	};

	// 레디스 특가상품 전용 추가
	@Override
	public Object addcart(CartVO vo) {

		return cartdao.productlist(vo);
	}

//레디스 특가상품 전용 데이터를 끌고오기
	public List<CartVO> cartlist(String userId) {
		return cartdao.cartlist(userId);

	}

	@Override
	public List<CartVO> isZeorcheck(CartVO vo) {
		List<CartVO> listone = cartdao.isZeorcheck(vo);

		if (listone == null) {
			return null;
		} else {
			return listone;
		}

	}

	@Override
	public List<CartVO> getupdateOne(CartVO vo) {

		return cartdao.getupdateOne(vo);
	}

	@Override
	public boolean dropcart(CartVO vo) {

		return cartdao.dropcart(vo);

	}

	@Override
	public void afterpaydeletecart(Integer cart_id) {

		cartdao.afterpaydeletecart(cart_id);
	}

	@Override
	public void testaddcart(String id) {

		cartdao.testaddcart(id);

	}

}
