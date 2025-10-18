package com.spring.finall.user;

import java.util.ArrayList;
import java.util.List;

public class OneDayClassVO {

	private String onedayclass_name;
	private int onedayclass_price;
	private String onedayclass_info;
	private String reserve_img;
	private Integer onedayclass_num;
	
	
	//편의상 뷰 프로젝트의 폴더경로의 사진저장소
	//편의상 반정규화로 간다.
	private String imagelocallpath1;
	private String imagelocallpath2;
	private String imagelocallpath3;
	private String imagelocallpath4;
	private String imagelocallpath5;
	//각종 간단 정보
	private String address;
	private String park;
	private String playtime;
	private String maximum_guests;
	
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPark() {
		return park;
	}

	public void setPark(String park) {
		this.park = park;
	}

	public String getPlaytime() {
		return playtime;
	}

	public void setPlaytime(String playtime) {
		this.playtime = playtime;
	}

	public String getMaximum_guests() {
		return maximum_guests;
	}

	public void setMaximum_guests(String maximum_guests) {
		this.maximum_guests = maximum_guests;
	}

	
	
	
	
	
	public String getImagelocallpath1() {
		return imagelocallpath1;
	}

	public void setImagelocallpath1(String imagelocallpath1) {
		this.imagelocallpath1 = imagelocallpath1;
	}

	public String getImagelocallpath2() {
		return imagelocallpath2;
	}

	public void setImagelocallpath2(String imagelocallpath2) {
		this.imagelocallpath2 = imagelocallpath2;
	}

	public String getImagelocallpath3() {
		return imagelocallpath3;
	}

	public void setImagelocallpath3(String imagelocallpath3) {
		this.imagelocallpath3 = imagelocallpath3;
	}

	public String getImagelocallpath4() {
		return imagelocallpath4;
	}

	public void setImagelocallpath4(String imagelocallpath4) {
		this.imagelocallpath4 = imagelocallpath4;
	}

	public String getImagelocallpath5() {
		return imagelocallpath5;
	}

	public void setImagelocallpath5(String imagelocallpath5) {
		this.imagelocallpath5 = imagelocallpath5;
	}

	//그냥 리미트절을 위한 단순 필드이다. 컬럼 아님!
	private Integer nextpage;
	
	//오류예방 마지막  리미트절을 위한 단순 필드이다. 컬럼 아님!
	private Integer preventNextPage;
	
	
	//그냥 마지막 페이지인지 확인하는 단순 필드이다 컬럼 아님!.
	private boolean endPageFlag;
	
	
	
	
	
	public Integer getPreventNextPage() {
		return preventNextPage;
	}

	public void setPreventNextPage(Integer preventNextPage) {
		this.preventNextPage = preventNextPage;
	}

	public boolean isEndPageFlag() {
		return endPageFlag;
	}

	public void setEndPageFlag(boolean endPageFlag) {
		this.endPageFlag = endPageFlag;
	}

	//조인용 ReivewVO 클래스이다.
	private List<ReviewVO> reivewvo;
	
	
	
	
	
	public Integer getNextpage() {
		return nextpage;
	}

	public void setNextpage(Integer nextpage) {
		this.nextpage = nextpage;
	}




	public List<Object> toList(OneDayClassVO ovo,int size) {
		
		List<Object> list = new ArrayList();
		for(int k=0; k<size; k++ ) {
			list.add(ovo.getReivewvo().get(k));
		}
		return list;
	}

	
	
	
	




	public Integer getOnedayclass_num() {
		return onedayclass_num;
	}

	public List<ReviewVO> getReivewvo() {
		return reivewvo;
	}

	public void setReivewvo(List<ReviewVO> reivewvo) {
		this.reivewvo = reivewvo;
	}

	public void setOnedayclass_num(Integer onedayclass_num) {
		this.onedayclass_num = onedayclass_num;
	}

	public String getReserve_img() {
		return reserve_img;
	}

	public void setReserve_img(String reserve_img) {
		this.reserve_img = reserve_img;
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

	public String getOnedayclass_info() {
		return onedayclass_info;
	}

	public void setOnedayclass_info(String onedayclass_info) {
		this.onedayclass_info = onedayclass_info;
	}
	
	
	
	public List<String> getCandiImageList(){		
		List<String> candiImageList= new ArrayList<String>();
		candiImageList.add(this.getImagelocallpath1());
		candiImageList.add(this.getImagelocallpath2());
		candiImageList.add(this.getImagelocallpath3());
		candiImageList.add(this.getImagelocallpath4());
		candiImageList.add(this.getImagelocallpath5());
		return candiImageList;
	}
	
	
	
	
	@Override
	public String toString() {
	    return "OneDayClassVO {" +
	            "onedayclass_name='" + onedayclass_name + '\'' +
	            ", onedayclass_price=" + onedayclass_price +
	            ", onedayclass_info='" + onedayclass_info + '\'' +
	            ", reserve_img='" + reserve_img + '\'' +
	            ", onedayclass_num=" + onedayclass_num +
	            ", imagelocallpath1='" + imagelocallpath1 + '\'' +
	            ", imagelocallpath2='" + imagelocallpath2 + '\'' +
	            ", imagelocallpath3='" + imagelocallpath3 + '\'' +
	            ", imagelocallpath4='" + imagelocallpath4 + '\'' +
	            ", imagelocallpath5='" + imagelocallpath5 + '\'' +
	            ", address='" + address + '\'' +
	            ", park='" + park + '\'' +
	            ", playtime='" + playtime + '\'' +
	            ", maximum_guests='" + maximum_guests + '\'' +
	            ", nextpage=" + nextpage +
	            ", preventNextPage=" + preventNextPage +
	            ", endPageFlag=" + endPageFlag +
	            ", reivewvo=" + (reivewvo != null ? reivewvo.toString() : "null") +
	            '}';
	}

}
