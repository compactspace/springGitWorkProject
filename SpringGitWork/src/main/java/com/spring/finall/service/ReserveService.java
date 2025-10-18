package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.spring.finall.user.ReserveInfoVO;

public interface ReserveService {

	
	
	public abstract boolean checkreserveinfo(ReserveInfoVO vo);
	
	public abstract List<Object>  myreserveinfo(HttpServletRequest req);	
	
	public abstract void paystatusupdate(HttpServletRequest req);
	
	
	public abstract boolean makeReservation(Map<String,Object> map);
	
	public abstract Map<String,Object> getReserveStatus(int user_code,int offset);
	
	
}
