package com.spring.finall.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface ApplicantDocumentService {

	Map<String, Object> getAppicantDocumentCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek);

	List<Map<String, Object>> getUnreadDocumentList(String stDate, String edDate);
	
	
	List<Map<String, Object>> getReadedDocumentList();
	
	String getFilePathByTeacherId(Long teacherId);
	
	
	boolean updateDocumentStatus(Long teacherId,String  status);

}
