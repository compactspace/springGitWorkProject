package com.spring.finall.user;

import lombok.ToString;
@ToString
public class CartVO {

	public int getPlusminus() {
		return plusminus;
	}

	public void setPlusminus(int plusminus) {
		this.plusminus = plusminus;
	}

	private String id;
	private int product_cod;
	private String product_name;
	private int cart_quantity;
	private int product_price;
	private String product_img;

	private String afterpay;
	
	private int cart_id;

	private int user_code;

	//일반상품 장바구니에서 +1 -1 씩 해줄 단순 변수 컬럼아님!!
	//프론트 cart.jsp 에서 + 면 1 - 면 -1로 가공후 아작스통신으로 받을것임 백단처리아님
	private int plusminus;
	
	
	private int product_quantity = 1;

	
	
	
	public int getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
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

	/// 카트담기 할시마다 하나 추가 인트용 마이베티스메퍼 파일에서 #{} 으로 쓰일것임
	// 또한 1개씩 마이너스 처리도 이걸로 할것임 변수선언 너무 하지 말자.
	public int plusone = 1;

	/// 카트 jsp에서 결제하기 a 링크 클릭시
	// a href="pay.jsp?id=${userId} & finallsum="
	// 이런식으로 쿼리스트링으로 넘길것 이기에
	// 리퀘스트파람 어노테이션 기법으로 일회성 처리할 것이다.

	private int finallsum;

	public int getproduct_quantity() {
		return product_quantity;
	}

	public void setproduct_quantity(String id) {
		this.product_quantity = product_quantity;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getProduct_cod() {
		return product_cod;
	}

	public void setProduct_cod(int product_cod) {
		this.product_cod = product_cod;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getCart_quantity() {
		return cart_quantity;
	}

	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public String getProduct_img() {
		return product_img;
	}

	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

	public int getPlusone() {
		return plusone;
	}

	public void setPlusone(int plusone) {
		this.plusone = plusone;
	}

	public int getFinallsum() {
		return finallsum;
	}

	public void setFinallsum(int finallsum) {
		this.finallsum = finallsum;
	}

	public String getAfterpay() {
		return afterpay;
	}

	public void setAfterpay(String afterpay) {
		this.afterpay = afterpay;
	}

}
