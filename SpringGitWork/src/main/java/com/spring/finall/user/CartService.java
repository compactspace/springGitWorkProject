package com.spring.finall.user;

import java.util.List;

public interface CartService {
	
	//일반상품전용
	public abstract int generalproductlist(CartVO vo);
	
	// 일반상품전용	
	public abstract List<CartVO> generalcartlist(CartVO vo);
	
	//일반 상품 전용 결제가 된뒤 결제 여부를 업데이트 하는 컬럼 이유가 다있음
	
	public abstract int afgerpaycartupdate(int cart_id);
	
	
	//일반 상품 전용 카트에서 + - 버튼 클릭시 수량 1 -1 씩 증감
	public abstract Integer plusminus(CartVO vo);
	
	//일반 상품 카트 버리기
		public abstract Integer dropgeneralcart(CartVO vo);

	
	
	
	
	//레디스 특가 전용
	public abstract Object addcart(CartVO vo);
	
	public abstract List<CartVO> cartlist(String userId);
	//카트수량이 0인지 체크 
	//마이너스 수량이 생기면 안되니깐
    public abstract List<CartVO> isZeorcheck(CartVO vo);
    
    
    public abstract List<CartVO> getupdateOne(CartVO vo);
    
    
    
    public abstract void afterpaydeletecart(Integer cart_id);
    

public void testaddcart(String id); 
		
	
		
	
	
    
    
    
}
