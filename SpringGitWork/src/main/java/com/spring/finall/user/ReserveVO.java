package com.spring.finall.user;

import java.util.ArrayList;

public class ReserveVO {

	private String id;
	private String onedayclass_name;
	private int onedayclass_price;
	private String reserve_day;
	private String reserve_info;			

	
	
	//리퀘스트파람용으로 
	// 예약일자 똑같을시 방지용으로 처리해보자.
	private String check;

	//같은날 다른 클래스 예약 금지
	
	private ArrayList<String> checklistarray;	
	
	private int checklist;
	
	
	


	
	


	public String getReserve_info() {
		return reserve_info;
	}

	public void setReserve_info(String reserve_info) {
		this.reserve_info = reserve_info;
	}

	public ArrayList<String> getChecklistarray() {
		return checklistarray;
	}

	public void setChecklistarray(ArrayList<String> checklistarray) {
		this.checklistarray = checklistarray;
	}

	public int getChecklist() {
		return checklist;
	}

	public void setChecklist(int checklist) {
		this.checklist = checklist;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOnedayclass_name() {
		return onedayclass_name;
	}

	public void setOnedayclass_name(String onedayclass_name) {
		this.onedayclass_name = onedayclass_name;
	}

	public int getOnedayclass_price() {
		return onedayclass_price;
	}

	public void setOnedayclass_price(int onedayclass_price) {
		this.onedayclass_price = onedayclass_price;
	}

	public String getReserve_day() {
		return reserve_day;
	}

	public void setReserve_day(String reserve_day) {
		this.reserve_day = reserve_day;
	}

	public String getCheck() {
		return check;
	}

	public void setCheck(String check) {
		this.check = check;
	}
	
	
	
	
}
