package com.spring.finall.impl;
import java.time.ZoneId; 
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.OneDayClassVO;

@Repository
public class ManageOnedayClassServiceDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<Map<String, Object>> getMyActiveOnedayclassList(Long teacherId,String yearMonth) {
		
	  

	    // MyBatis에 전달할 파라미터 맵
	    Map<String, Object> params = new HashMap<>();
	    params.put("teacherId", teacherId);
	    params.put("yearMonth", yearMonth);
		
	    List<Map<String, Object>>   currentDayList =	mybatis.selectList("ManageOneDayClassMapper.getMyActiveOnedayclass", params);		
		
		return markFutureClasses(currentDayList);
	}
	

	public List<Map<String, Object>> markFutureClasses(List<Map<String, Object>> currentDayList) {

	    LocalDateTime now = LocalDateTime.now();

	    for (Map<String, Object> item : currentDayList) {
	        Object openDayObj = item.get("openday");
	        LocalDateTime openDay = null;

	        if (openDayObj != null) {
	            try {
	                if (openDayObj instanceof java.sql.Timestamp) {
	                    openDay = ((java.sql.Timestamp) openDayObj).toLocalDateTime();
	                } else if (openDayObj instanceof java.util.Date) {
	                    openDay = ((java.util.Date) openDayObj)
	                                .toInstant()
	                                .atZone(ZoneId.systemDefault())
	                                .toLocalDateTime();
	                } else if (openDayObj instanceof String) {
	                    String dateStr = openDayObj.toString();
	                    if (dateStr.endsWith(".0")) {
	                        dateStr = dateStr.substring(0, dateStr.length() - 2);
	                    }

	                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	                    openDay = LocalDateTime.parse(dateStr, formatter);
	                }
	            } catch (Exception e) {
	                openDay = null; // 파싱 실패 시 null 처리
	            }
	        }

	        // 오늘 이후면 true, 이전 또는 null이면 false
	        boolean manageStatus = (openDay != null) && !openDay.isBefore(now);
	        item.put("manageStatus", manageStatus);
	    }

	    return currentDayList;
	}


	
	
	public List<Map<String, Object>> getMyActiveMonthList(Long teacher_id) {
		 Map<String, Object> params = new HashMap<>();
		    params.put("teacherId", teacher_id);
		   List<Map<String, Object>>   currentMonthList =	mybatis.selectList("ManageOneDayClassMapper.getMyActiveMonthList", params);	
		return currentMonthList;
	}
	
	
	public OneDayClassVO getMyOneDayClassInfo(Long teacher_id) {
		// TODO Auto-generated method stub
		OneDayClassVO oneDayClassVO=mybatis.selectOne("ManageOneDayClassMapper.getMyOneDayClassInfo", teacher_id);	
		return oneDayClassVO;
	}

	public int updateOneDayClassInfo(Long teacherId, OneDayClassVO oneDayClass, String updateColumns) {
	    // Map에 파라미터 담기
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("teacherId", teacherId);
	    paramMap.put("updateColumns", updateColumns);

	    // VO 필드도 Map에 추가 (updateColumns 안에서 #{col}로 바인딩될 값)
	    paramMap.putAll(oneDayClass.toFieldMap());

	    // MyBatis update 호출
	    return mybatis.update("ManageOneDayClassMapper.updateOneDayClassInfo", paramMap);
	}

}
