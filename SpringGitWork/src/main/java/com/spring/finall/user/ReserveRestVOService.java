package com.spring.finall.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ReserveRestVOService {
	
	
	public abstract List<Map<String, Object>> restOneDayClass(Integer onedayClassNum ,String searchMonth, int userId);
	
	
	//이는 결제 성공후 자리수 감소 업데이트임
	public abstract void reserverestupdate(HttpServletRequest req);
	
	
	//이는 결제 취소 성공후 자리수 하나 올려주는 업데이트임
	public abstract void reserverestpaycancelupdate(HttpServletRequest req);
	

	
	

}
