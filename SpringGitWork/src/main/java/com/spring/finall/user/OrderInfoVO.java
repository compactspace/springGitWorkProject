package com.spring.finall.user;

import lombok.ToString;

@ToString
public class OrderInfoVO {
	
	private int orderinfo_id;
	
	private int user_code;
	private int cart_id;
	
	private String orderinfo_pay;
	
	private String orderinfo_create;
	
	//고객이 취소한날 xml파일에서 now() 데이트 포팟으로 업데이트 칠거니 걱정 ㄴㄴ
		private String orderinfo_cancel_create;
	
	//결제 현황 볼때 조인용 임
	private CartVO cartvo;
	
	
	

	public CartVO getCartvo() {
		return cartvo;
	}

	public void setCartvo(CartVO cartvo) {
		this.cartvo = cartvo;
	}

	public int getOrderinfo_id() {
		return orderinfo_id;
	}

	public void setOrderinfo_id(int orderinfo_id) {
		this.orderinfo_id = orderinfo_id;
	}

	public int getUser_code() {
		return user_code;
	}

	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public String getOrderinfo_pay() {
		return orderinfo_pay;
	}

	public void setOrderinfo_pay(String orderinfo_pay) {
		this.orderinfo_pay = orderinfo_pay;
	}

	public String getOrderinfo_create() {
		return orderinfo_create;
	}

	public void setOrderinfo_create(String orderinfo_create) {
		this.orderinfo_create = orderinfo_create;
	}

	public String getOrderinfo_cancel_create() {
		return orderinfo_cancel_create;
	}

	public void setOrderinfo_cancel_create(String orderinfo_cancel_create) {
		this.orderinfo_cancel_create = orderinfo_cancel_create;
	}
	
	
	
	

	
	
	

}
