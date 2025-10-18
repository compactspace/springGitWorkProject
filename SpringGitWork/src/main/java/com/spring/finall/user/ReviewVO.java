package com.spring.finall.user;



public class ReviewVO {
	private int review_num; 
	//NOT NULL DEFAULT '이미지 없음',
	private String review_img;
	//NOT NULL DEFAULT '이용후 후기드립니다.',
	private String review_comment; 
	private int user_code;	
	private int onedayclass_num;
	//NOT NULL DEFAULT CURRENT_TIMESTAMP
	private String review_create_at; 
	//DATETIME NOT NULL DEFAULT '00-00-00'
	private String review_update_at;
	
	//리뷰등록시 사용되는 닉네임이다. 우선 참조나 그런건 생각하지 않는다.
	private String review_name;
	
	
	
	
	
	
	public String getReview_name() {
		return review_name;
	}
	public void setReview_name(String review_name) {
		this.review_name = review_name;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}
	public String getReview_comment() {
		return review_comment;
	}
	public void setReview_comment(String review_comment) {
		this.review_comment = review_comment;
	}
	public int getUser_code() {
		return user_code;
	}
	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	public int getOnedayclass_num() {
		return onedayclass_num;
	}
	public void setOnedayclass_num(int onedayclass_num) {
		this.onedayclass_num = onedayclass_num;
	}
	public String getReview_create_at() {
		return review_create_at;
	}
	public void setReview_create_at(String review_create_at) {
		this.review_create_at = review_create_at;
	}
	public String getReview_update_at() {
		return review_update_at;
	}
	public void setReview_update_at(String review_update_at) {
		this.review_update_at = review_update_at;
	} 	

	
	
	
}
