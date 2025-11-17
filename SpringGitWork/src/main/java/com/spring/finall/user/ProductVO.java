package com.spring.finall.user;

public class ProductVO {

	
	private int product_id;
	

	private int product_cod;
	private String product_name;
	private int product_price;
	private String product_img;
	private String product_info;
	private String product_Registration_status;
	private String product_status;
	private String product_group;
	private int group_id;
	private int product_quantity;
	private int product_order_quantity;
	private int product_delivery_quantity;
	private String product_file_path;


	
	
	private String file_category;

	private String 	file_name;
	
	
	
	

	
	public String getFile_category() {
		return file_category;
	}

	public void setFile_category(String file_category) {
		this.file_category = file_category;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	
	public String getProduct_file_path() {
		return product_file_path;
	}

	public void setProduct_file_path(String product_file_path) {
		this.product_file_path = product_file_path;
	}

	public int getGroup_id() {
		return group_id;
	}

	public void setGroup_id(int group_id) {
		this.group_id = group_id;
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


	
	
	public int getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(int product_quantity) {
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

		return "[ product_cod = " + product_cod + ", product_name =" + product_name + ", product_price ="
				+ product_price + ", product_img =" + product_img + ", product_info =" + product_info
				+ ", product_quantity =" + product_quantity

				+ "]";

	}

}
