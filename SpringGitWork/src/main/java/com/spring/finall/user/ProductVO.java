package com.spring.finall.user;

public class ProductVO {

	private int product_cod;
	private String product_name;
	private int product_price;
	private String product_img;
	private String product_info;
	private String product_Registration_status;
	private String product_status;
	private String product_group;
	private int product_quantity;
	private int product_order_quantity;
	private int product_delivery_quantity;
	
	
	
	
	
	
	public int getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}

	public int getProduct_order_quantity() {
		return product_order_quantity;
	}

	public void setProduct_order_quantity(int product_order_quantity) {
		this.product_order_quantity = product_order_quantity;
	}

	public int getProduct_delivery_quantity() {
		return product_delivery_quantity;
	}

	public void setProduct_delivery_quantity(int product_delivery_quantity) {
		this.product_delivery_quantity = product_delivery_quantity;
	}

	public final String getProduct_group() {
		return product_group;
	}

	public final void setProduct_group(String product_group) {
		this.product_group = product_group;
	}

	public String getProduct_Registration_status() {
		return product_Registration_status;
	}

	public void setProduct_Registration_status(String product_Registration_status) {
		this.product_Registration_status = product_Registration_status;
	}

	public String getProduct_status() {
		return product_status;
	}

	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}

	public int getproduct_quantity() {
		return product_quantity;
	}

	public void setproduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}
	
	
	
	
	
	public String getProduct_info() {
		return product_info;
	}

	public void setProduct_info(String product_info) {
		this.product_info = product_info;
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

@Override
public String toString() {
	
	return "[ product_cod = "+product_cod+", product_name =" +product_name+", product_price =" +product_price
			+", product_img =" +product_img+", product_info =" +product_info+", product_quantity =" +product_quantity
			
+"]";




}
	
	
}
