package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.CartVO;

@Repository
public class CartDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int generalproductlist(CartVO vo) {
		// 말그대로 카트에 추가한뒤 바로 카트의 수량을 1 증가시킨다.
		System.out.println("마이베티스속 커맨드 객체 \n" + vo);

		try {
			int alreadycheck = mybatis.selectList("CartVO.generalcartcheck", vo).size();

			System.out.println("카트번호가 있거나 없거하 할시 랭스 값->" + alreadycheck);
			// 장바구니 이력은 컬럼 afterpay 을 조회하하므로 조건을 하다 더 붙인다...
			System.out.println("최초 카트 아이디 발급전 CartVO vo 투스트링값" + vo);

			List<CartVO> lists = mybatis.selectList("CartVO.generalcartcheck", vo);

			System.out.println("lists->>" + lists);

//			//ㄴㄴ 괜찬 유일한 한 행을 가져와서 인덱스 0 만 해도됨
//			int cart_id=lists.get(0).getCart_id();

//			
//		if(alreadycheck==0) {
//			System.out.println("해당 상품을 최초로 담을때만 뜸");
//			mybatis.insert("CartVO.generaladdcart", vo);
//		}

			if (alreadycheck >= 1) {
				int cart_id = lists.get(0).getCart_id();
				System.out.println("하번 담은 이력이 있는후 또 카트에 담기 누를시 뜸");
				System.out.println("변수 잘 오는데?" + vo);
				vo.setCart_id(cart_id);
				mybatis.update("CartVO.generalcartupdate", vo);
			} else {
				System.out.println("해당 상품을 최초로 담을때만 뜸");
				mybatis.insert("CartVO.generaladdcart", vo);
			}

			return 1;
		} catch (Exception e) {

			System.out.println(e);

			return -1;
		}

	}

	// 일반 상품 정보를 끌고오기
	public List<CartVO> generalcartlist(CartVO vo) {

		return mybatis.selectList("CartVO.generalcartlist", vo);
	}

	// 일반 상품 결제이후 카트 테이블에 결제여부 업데이트 다 이유가 있음

	public int afgerpaycartupdate(int cart_id)  throws PayRunTimeTranException{
		HashMap<String, Object> map = new HashMap();
		map.put("cart_id", cart_id);

		
	
		try {
			int executerow = mybatis.insert("CartVO.afgerpaycartupdate", map);
		}catch(Exception e) {
			
			throw new PayRunTimeTranException("결제는 되었으나, 카트테이블 업데이트시 에러");
		}finally {
			int cartUpdate_status_code=1;
			return cartUpdate_status_code;
			
		}

	}

	// 일반 상품 전용 카트에서 + - 버튼 클릭시 수량 1 -1 씩 증감
	public Integer plusminus(CartVO vo) {
		System.out.println("마이바티스 직전 투스트링 vo \n" + vo);
		
		
		try {
			Integer executeUpdateQuery = mybatis.update("CartVO.plusminus", vo);
			CartVO cvo= mybatis.selectOne("CartVO.minusZeorcheck", vo);
			System.out.println("연산후 카트에 남은 수량 "+cvo.getCart_quantity());
			if(cvo.getCart_quantity()==0) {
				Integer executeDeleteQuery = mybatis.delete("CartVO.deleteZeorcart", vo);	
				System.out.println("업데이트 쿼리 "+executeUpdateQuery+" 연산후 카트에 남은 수량 "+cvo.getCart_quantity()+" 딜리트쿼리 "+executeDeleteQuery);			
			}
			System.out.println("업데이트 쿼리 "+executeUpdateQuery+" 연산후 카트에 남은 수량 "+cvo.getCart_quantity());			
			
			return 1;
		}catch(Exception e) {
			System.out.println("에러값");
			System.out.println(e);
			return-1;
		}

	}
	
	//일반 상품 카트 버리기
		public Integer dropgeneralcart(CartVO vo) {
			System.out.println("받은 카트아이디 "+vo.getCart_id());
			Integer executequery= mybatis.delete("CartVO.dropgeneralcart", vo);
			System.out.println("executequery->>"+executequery);
			if(executequery==1) {
				return 1;
			}else {
				return -1;
			}
			
		};

//	레디스 특가 전용
	public Object productlist(CartVO vo) {
		List<CartVO> lcvo = check(vo);
		System.out.println("lcvo->>>>>>>>>>>>>>>>>>>>" + lcvo);
		System.out.println("lcvo.size()->>>>>>>>>>>>>>>>>>>>" + lcvo.size());
		List<CartVO> cartid;

		if (lcvo.size() == 0) {
			mybatis.insert("CartVO.addcart", vo);
			cartid = selectcartid(vo);
			System.out.println("카트번호는->>>>>>>>>>>>>>>>>>>>" + cartid.get(0));
			return cartid.get(0).getCart_id();

		} else {

			for (CartVO x : lcvo) {
				System.out.println("x.getCart_quantity()->>>>>>>" + x.getCart_quantity());
				if (x.getCart_quantity() >= 1) {
					System.out.println("투루");
					// mybatis.insert("CartVO.addcart", vo);
					mybatis.update("CartVO.cartupdate", vo);
				} else {
					// 0 이면 엠프티라 인식해서 메소드 추가...
					cartZeroupdate(vo);
				}

			}

			return null;
		}

	}

	public void cartZeroupdate(CartVO vo) {

		mybatis.update("CartVO.cartZeroupdate", vo);
	}

	public List<CartVO> check(CartVO vo) {
		System.out.println("호출");
		return mybatis.selectList("CartVO.check", vo);
	}

	public List<CartVO> selectcartid(CartVO vo) {
		System.out.println("호출");
		return mybatis.selectList("CartVO.selectcart_id", vo);
	}

	public List<CartVO> cartlist(String userId) {

	
		return mybatis.selectList("CartVO.generalcartlist", userId);

	}

	// 카트수량이 0 인지 확인하는 보조 함수
	public List<CartVO> isZeorcheck(CartVO vo) {
		if (mybatis.selectOne("CartVO.isZeorcheck", vo) != null) {

			int zerocheck = mybatis.selectOne("CartVO.isZeorcheck", vo);
			System.out.println("수량이 0인가->>" + zerocheck);

			if (zerocheck >= 1) {
				yesnoneZerodelete(vo);
				List<CartVO> listone = getupdateOne(vo);
				return listone;
			}
			return null;

		} else {
			return null;
		}

	};

	public void yesnoneZerodelete(CartVO vo) {
		mybatis.update("CartVO.yesnoneZerodelete", vo);
	};

	public List<CartVO> getupdateOne(CartVO vo) {

		return mybatis.selectList("CartVO.getupdateOne", vo);
	}



	public void afterpaydeletecart(Integer cart_id) {

		Map<String, Object> map = new HashMap<>();
		map.put("cart_id", cart_id);

		mybatis.delete("CartVO.afterpaydeletecart", map);

	}

	public void testaddcart(String id) {
		System.out.println("id는->>" + id);
		mybatis.insert("CartVO.testaddcart", id);

	}

}
