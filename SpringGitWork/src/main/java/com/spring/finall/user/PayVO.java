package com.spring.finall.user;

import java.util.List;

import lombok.ToString;

@ToString
public class PayVO {

	// 소비자가 결제한날
	private String receipt_merchant_uid;
	// 소비자의 총 결제 금액
	private String receipt_paid_amount;
	// 소비자의 id
	private String id;	
	//
	private int pay_num;
	
	
	//조인전용
	private List<CartVO> cartvo;
	
	//조인전용
	private List<OrderInfoVO> orderinfovo;
	
	//조인전용
	private List<UserVO> uservo;
	
	
//	private int orderinfo_id;
//	
//	private String[] cart_id;	
//	
//	
//	public String[] getCart_id() {
//		return cart_id;
//	}
//
//	public void setCart_id(String[] cart_id) {
//		this.cart_id = cart_id;
//	}
//
//	public int getOrderinfo_id() {
//		return orderinfo_id;
//	}
//
//	public void setOrderinfo_id(int orderinfo_id) {
//		this.orderinfo_id = orderinfo_id;
//	}

	


	public String getReceipt_merchant_uid() {
		return receipt_merchant_uid;
	}

	public void setReceipt_merchant_uid(String receipt_merchant_uid) {
		this.receipt_merchant_uid = receipt_merchant_uid;
	}

	public String getReceipt_paid_amount() {
		return receipt_paid_amount;
	}

	public void setReceipt_paid_amount(String receipt_paid_amount) {
		this.receipt_paid_amount = receipt_paid_amount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<CartVO> getCartvo() {
		return cartvo;
	}

	public void setCartvo(List<CartVO> cartvo) {
		this.cartvo = cartvo;
	}

	public List<OrderInfoVO> getOrderinfovo() {
		return orderinfovo;
	}

	public void setOrderinfovo(List<OrderInfoVO> orderinfovo) {
		this.orderinfovo = orderinfovo;
	}

	public int getPay_num() {
		return pay_num;
	}

	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}



	

}
