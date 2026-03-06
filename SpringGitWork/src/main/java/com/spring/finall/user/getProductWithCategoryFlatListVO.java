package com.spring.finall.user;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class getProductWithCategoryFlatListVO {

    // =======================
    // Product Fields
    // =======================

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
    private String file_name;
    private int category_id;
    private int vendor_id;

    // =======================
    // Category Fields
    // =======================

    private Integer category_parent_id;   // NULL 허용
    private String category_name;
    private Integer category_sort_order;
    private Boolean category_is_active;
    private Timestamp category_created_at;
    private Timestamp category_updated_at;
    
    
    private List<getProductWithCategoryFlatListVO> children = new ArrayList<>();

    public List<getProductWithCategoryFlatListVO> getChildren() {
        return children;
    }

    public void setChildren(List<getProductWithCategoryFlatListVO> children) {
        this.children = children;
    }

    
    
    

    // =======================
    // Getter & Setter
    // =======================

    
    
    
    
    public int getProduct_id() {
        return product_id;
    }

  
	public void setProduct_id(int product_id) {
        this.product_id = product_id;
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

    public String getProduct_info() {
        return product_info;
    }

    public void setProduct_info(String product_info) {
        this.product_info = product_info;
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

    public String getProduct_group() {
        return product_group;
    }

    public void setProduct_group(String product_group) {
        this.product_group = product_group;
    }

    public int getGroup_id() {
        return group_id;
    }

    public void setGroup_id(int group_id) {
        this.group_id = group_id;
    }

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

    public String getProduct_file_path() {
        return product_file_path;
    }

    public void setProduct_file_path(String product_file_path) {
        this.product_file_path = product_file_path;
    }

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

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getVendor_id() {
        return vendor_id;
    }

    public void setVendor_id(int vendor_id) {
        this.vendor_id = vendor_id;
    }

    public Integer getCategory_parent_id() {
        return category_parent_id;
    }

    public void setCategory_parent_id(Integer category_parent_id) {
        this.category_parent_id = category_parent_id;
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

    public Timestamp getCategory_created_at() {
        return category_created_at;
    }

    public void setCategory_created_at(Timestamp category_created_at) {
        this.category_created_at = category_created_at;
    }

    public Timestamp getCategory_updated_at() {
        return category_updated_at;
    }

    public void setCategory_updated_at(Timestamp category_updated_at) {
        this.category_updated_at = category_updated_at;
    }

    @Override
    public String toString() {
        return "getProductWithCategoryFlatListVO{" +
                "product_id=" + product_id +
                ", product_name='" + product_name + '\'' +
                ", product_price=" + product_price +
                ", category_name='" + category_name + '\'' +
                '}';
    }
}
