package com.spring.finall.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.TeacherDocumentVO;

@Repository
public class ApplicantDocumentServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public Map<String, Object> getAppicantDocumentCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {

		Map<String, Object> params = new HashMap<>();
		params.put("startOfWeek", startOfWeek);
		params.put("endOfWeek", endOfWeek);

		List<TeacherDocumentVO> list = mybatis
				.selectList("ApplicantDocumentsMapper.getAppicantDocumentCountByTodayAndWeek", null);

		int todayCount = 0;
		int weekCount = 0;

		LocalDate today = LocalDate.now();

		for (TeacherDocumentVO vo : list) {
			Object obj = vo.getUploadedAt();
			LocalDate orderDate;

			if (obj instanceof java.sql.Timestamp) {
				orderDate = ((java.sql.Timestamp) obj).toLocalDateTime().toLocalDate();
			} else if (obj instanceof java.sql.Date) {
				orderDate = ((java.sql.Date) obj).toLocalDate();
			} else if (obj instanceof java.util.Date) { // 혹시 java.util.Date
				orderDate = ((java.util.Date) obj).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			} else {
				throw new IllegalArgumentException("Unsupported date type: " + obj.getClass());
			}

			if (orderDate.isEqual(today)) {
				todayCount++;
			}

			if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(endOfWeek)) {
				weekCount++;
			}
		}

		Map<String, Object> result = new HashMap<>();
		result.put("todayApplicantDocuments", todayCount);
		result.put("weekApplicantDocuments", weekCount);

		return result;
	}

	public List<Map<String, Object>> getUnreadDocumentList(String stDate, String edDat) {
	
		Map<String,String> params= new HashMap<>();
		
		params.put("stDate",stDate);
		params.put("edDat", edDat);

		List<Map<String, Object>> list = mybatis.selectList("ApplicantDocumentsMapper.getUnreadDocumentList",params);
		return list;
	}

	public String getFilePathByTeacherId(Long teacherId) {

		String filePath = mybatis.selectOne("ApplicantDocumentsMapper.getFilePathByTeacherId", teacherId);
		return filePath;
	}

	public boolean updateDocumentStatus(Long teacherId, String status) {
		Map<String, Object> params = new HashMap<>();
		params.put("teacherId", teacherId);
		params.put("status", status);

		int affectedRow = mybatis.update("ApplicantDocumentsMapper.updateDocumentStatus", params);

		return affectedRow > 0 ? true : false;
	}

	
	
	public List<Map<String, Object>> getReadedDocumentList() {
		List<Map<String, Object>> list = mybatis.selectList("ApplicantDocumentsMapper.getReadedDocumentList");
		return list;
	}
	
	
}
