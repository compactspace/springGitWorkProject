package com.spring.finall.user.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ReserveRestDAOMybatis {
	

	@Autowired
	private SqlSessionTemplate mybatis;
	
	
	public List<Map<String, Object>> getAvailableDaysInMonth(Integer onedayClassNum, String searchMonth) {

	    // searchMonth가 null 또는 빈 문자열일 경우, 현재 년-월로 설정
	    if (searchMonth == null || searchMonth.trim().isEmpty()) {
	        searchMonth = getCurrentYearMonth();  // 아래 정의된 유틸 함수
	    }

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("onedayclass_num", onedayClassNum);
	    paramMap.put("searchMonth", searchMonth);  // 바뀐 변수명에 주의!

	    List<Map<String, Object>> resultList =
	        mybatis.selectList("ReserveMapper.selectAvailableDaysInMonth", paramMap);

	    return resultList != null ? resultList : new ArrayList<>();
	}

	
	public List<Map<String, Object>> checkreserinfo(int userCode, String searchMonth) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_code", userCode);
        params.put("searchMonth", searchMonth);
        return mybatis.selectList("ReserveMapper.checkreserinfo", params);
    }
	
	
	
	
	

	private String getCurrentYearMonth() {
	    LocalDate today = LocalDate.now();  // 오늘 날짜
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
	    return today.format(formatter);
	}
	//이는 결제 성공후 자리수 감소 업데이트임
	public void reserverestupdate(HttpServletRequest req) {		
		String rest=req.getParameter("rest");
		String onedayclass_num=req.getParameter("onedayclass_num");
		String openday=req.getParameter("openday");
		System.out.println("자리수->"+rest+"  클래스번호->>"+onedayclass_num+"  개설강의날짜"+openday);
		Map<String,Object> map = new HashMap<>();
		map.put("rest", rest);
		map.put("onedayclass_num", onedayclass_num);
		map.put("openday",openday);

		
		mybatis.update("ReserveMapper.reserverestupdate", map);
		
	};	//이는 결제 성공후 자리수 감소 업데이트 종료
	
	
	
	
	public void reserverestpaycancelupdate(HttpServletRequest req) {
		String onedayclass_num=req.getParameter("onedayclass_num");
		String openday=req.getParameter("openday");
		System.out.println("클래스번호 "+onedayclass_num+" 개설강의 날짜"+openday);
		Map<String,Object> map = new HashMap<>();	
		
		map.put("onedayclass_num", onedayclass_num);
		map.put("openday",openday);
		
		Integer result=(Integer)mybatis.selectOne("ReserveMapper.reserverest", map);
		
		
		map.put("rest",result);
	
		mybatis.update("ReserveMapper.reserverestpaycancelupdate", map);
		
	};
	
	
	
	
	
	
}
