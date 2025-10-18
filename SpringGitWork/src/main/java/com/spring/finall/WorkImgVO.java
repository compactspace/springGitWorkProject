package com.spring.finall;

import org.springframework.web.multipart.MultipartFile;

public class WorkImgVO {

	private String id;
	private String worklist_img;
	private String worklist_comment;
	
	private String worklist_regidate;
	private int worklist_num;
	

	
	private MultipartFile worklist_img_upload;
	
	private int numfornextorback;
	
	
	//아작스를 위한 변수로 따로 paging 테이블 전용임.
	//아작스와 마이베티스에 사용할 값임
	private int graterthanonepage;
	
	
	
	
	
	
	public int getGraterthanonepage() {
		return graterthanonepage;
	}

	public void setGraterthanonepage(int graterthanonepage) {
		this.graterthanonepage = graterthanonepage;
	}

	public int getNumfornextorback() {
		return numfornextorback;
	}

	public void setNumfornextorback(int numfornextorback) {
		this.numfornextorback = numfornextorback;
	}

	public String getWorklist_regidate() {
		return worklist_regidate;
	}

	public void setWorklist_regidate(String worklist_regidate) {
		this.worklist_regidate = worklist_regidate;
	}

	public int getWorklist_num() {
		return worklist_num;
	}

	public void setWorklist_num(int worklist_num) {
		this.worklist_num = worklist_num;
	}

	public MultipartFile getWorklist_img_upload() {
		return worklist_img_upload;
	}

	public void setWorklist_img_upload(MultipartFile worklist_img_upload) {
		this.worklist_img_upload = worklist_img_upload;
	}

	public String getWorklist_comment() {
		return worklist_comment;
	}

	public void setWorklist_comment(String worklist_comment) {
		this.worklist_comment = worklist_comment;

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWorklist_img() {
		return worklist_img;
	}

	public void setWorklist_img(String worklist_img) {
		this.worklist_img = worklist_img;
	}

}
