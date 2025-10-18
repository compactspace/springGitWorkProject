package com.spring.finall.user;

import java.util.List;


public interface PayService {
	
	public abstract void insertPay(PayVO pvo, Integer cart_id);
	

	public abstract List<PayVO>	showpaylist(PayVO pvo);
	
	public abstract List<PayVO>	mypaydetailinfo(UserVO uvo,PayVO pvo);
	
	public abstract  Integer cancellistcartid(PayVO pvo);

}
