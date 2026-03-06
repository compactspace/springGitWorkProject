package com.spring.finall.user;

import java.util.ArrayList;
import java.util.List;

public class CategoryWithProductsVO {
    private int category_id;
    private Integer parent_id;
    private String category_name;
    private Integer category_sort_order;
    private Boolean category_is_active;

    private List<CategoryWithProductsVO> children = new ArrayList<>();
    private List<ProductVO> products = new ArrayList<>();
	public int getCategory_id() {
		return category_id;
	}
	
	
	
	
	public Integer getParent_id() {
		return parent_id;
	}




	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}




	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public Integer getCategory_sort_order() {
		return category_sort_order;
	}
	public void setCategory_sort_order(Integer category_sort_order) {
		this.category_sort_order = category_sort_order;
	}
	public Boolean getCategory_is_active() {
		return category_is_active;
	}
	public void setCategory_is_active(Boolean category_is_active) {
		this.category_is_active = category_is_active;
	}
	public List<CategoryWithProductsVO> getChildren() {
		return children;
	}
	public void setChildren(List<CategoryWithProductsVO> children) {
		this.children = children;
	}
	public List<ProductVO> getProducts() {
		return products;
	}
	public void setProducts(List<ProductVO> products) {
		this.products = products;
	}

    // getters & setters...
    
    
}