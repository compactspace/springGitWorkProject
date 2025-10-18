package com.spring.finall.user;

import java.util.List;

public interface OrderInfoService {
	
	public abstract void insertorderinfo(OrderInfoVO vo);
//	public abstract List<OrderInfoVO> selectordercode(OrderInfoVO vo);
	public abstract void payupdate(int cart_id);
	
	//일반 상품 을 주문정보에 담음	
	public  abstract int insertgeneralorderinfo(int cart_id, int user_code);
	
	//일반 상품을 결제 현황을 위해 받아옴	
	public abstract List<OrderInfoVO> mypayinfo(OrderInfoVO ovo);
	
	

}
