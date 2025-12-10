package com.spring.finall.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.businessresult.TeacherInsertResult;

public interface TeacherMemberService {

	public abstract TeacherInsertResult insertTeacherMembership(String id, String hashedPassword, MultipartFile file, Map<String, Object> companyInfo, File tempFile);
	
	public Map<String,Object>  currentMyinfo(String username);
	
	
	public List<Map<String,Object>>  currentMyDocuments(Long teacher_id);
	
	
	
	
}
