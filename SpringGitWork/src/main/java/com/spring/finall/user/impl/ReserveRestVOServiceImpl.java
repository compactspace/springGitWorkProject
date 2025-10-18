package com.spring.finall.user.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.user.ReserveRestVOService;

@Service(" ReserveRestVOService")
public class ReserveRestVOServiceImpl implements  ReserveRestVOService {

	@Autowired
public ReserveRestDAOMybatis mybatis;
	
	@Override
	public List<Map<String, Object>> restOneDayClass(Integer onedayClassNum, String searchMonth,int userId) {
	    List<Map<String, Object>> possibleDate = mybatis.getAvailableDaysInMonth(onedayClassNum, searchMonth);

	    List<Map<String, Object>> alreadyReserveList=null; 
	    if(userId!=0) {
	    	alreadyReserveList=	mybatis.checkreserinfo(userId,searchMonth);	    	
	    }
	    
	    Set<LocalDate> reservedDates = new HashSet<>();
	    if (alreadyReserveList != null) {
	        for (Map<String, Object> reserve : alreadyReserveList) {
	            Object dateObj = reserve.get("selectedDate");

	            if (dateObj instanceof java.sql.Date) {
	                reservedDates.add(((java.sql.Date) dateObj).toLocalDate());
	            } else if (dateObj instanceof java.util.Date) {
	                reservedDates.add(((java.util.Date) dateObj).toInstant()
	                    .atZone(ZoneId.systemDefault())
	                    .toLocalDate());
	            }
	        }
	    }

	    LocalDate today = LocalDate.now();

	    List<Map<String, Object>> filteredList = possibleDate.stream()
	        .map(map -> {
	            Object opendayObj = map.get("openday");
	            Object restObj = map.get("rest");

	            if (opendayObj == null || restObj == null) return null;

	            LocalDate openDate;
	            int restCount;

	            if (opendayObj instanceof java.sql.Date) {
	                openDate = ((java.sql.Date) opendayObj).toLocalDate();
	            } else if (opendayObj instanceof java.util.Date) {
	                openDate = ((java.util.Date) opendayObj).toInstant()
	                    .atZone(ZoneId.systemDefault())
	                    .toLocalDate();
	            } else {
	                return null;
	            }

	            if (restObj instanceof Integer) {
	                restCount = (Integer) restObj;
	            } else if (restObj instanceof String) {
	                try {
	                    restCount = Integer.parseInt((String) restObj);
	                } catch (NumberFormatException e) {
	                    return null;
	                }
	            } else {
	                return null;
	            }

	            // 오늘 이후 && 수량 1 이상인 경우만 통과
	            if (openDate.isBefore(today) || restCount < 1) {
	                return null;
	            }

	            // 여기에 reserved 여부 추가
	            boolean isReserved = reservedDates.contains(openDate);
	            map.put("reserved", isReserved);  // ← 추가되는 컬럼

	            return map;
	        })
	        .filter(Objects::nonNull)  // null 제거
	        .collect(Collectors.toList());


	    return filteredList;
	}


	@Override
	public void reserverestupdate(HttpServletRequest req) {
		mybatis.reserverestupdate(req);
		
	}

	@Override
	public void reserverestpaycancelupdate(HttpServletRequest req) {
		
		mybatis.reserverestpaycancelupdate(req);
		
	}


	
	
}
