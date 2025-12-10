package com.spring.finall.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.businessresult.TeacherInsertResult;
import com.spring.finall.exception.teacherMemberShip.TeacherDocumentException;
import com.spring.finall.service.TeacherMemberService;

@Service
public class TeacherMemberServiceImpl implements TeacherMemberService {

	@Autowired
	private TeacherMemberServiceDAO teacherMemberServiceDAO;

	@Override
	@Transactional
	public TeacherInsertResult insertTeacherMembership(String id, String hashedPassword, MultipartFile file,Map<String, Object> companyInfo,File tempFile) {

		TeacherInsertResult teacherInsertResult = null;

		try {

			// DB에 저장할 경우 파일명, 절대 경로(C:\ 포함)를 리턴
			String savedFilePath = insertTeacherDocuments(id, file,tempFile);

			Long teacherId = teacherMemberServiceDAO.insertTeacherMembership(id, hashedPassword);
			if (teacherId <= 0) {

				throw new TeacherDocumentException("선생님의 아이디 비밀번호 DB삽입시 에러");

			}

			int affectedRow = teacherMemberServiceDAO.insertTeacherDocument(teacherId, hashedPassword, savedFilePath);

			if (affectedRow <= 0) {
				throw new TeacherDocumentException("선생님의 제출서류정보  DB삽입시 에러");

			}
			
			companyInfo.put("teacher_id", teacherId);
			affectedRow =	teacherMemberServiceDAO.insertCompanyInfo(companyInfo);
			if (affectedRow <= 0) {
				throw new TeacherDocumentException("기업정보  DB삽입시 에러");

			}
			
			

		} catch (TeacherDocumentException de) {

			throw new TeacherDocumentException(de.getMessage());
		}

		teacherInsertResult = new TeacherInsertResult(201, true, "음 하자는 업는 성공");
		return teacherInsertResult;

	}

	public String insertTeacherDocuments(String id, MultipartFile file,File tempFile) {
		if (file == null || file.isEmpty()) {
			throw new TeacherDocumentException("파일이 비어있습니다.");
		}

		// 현재시간 + id 기반으로 유니크한 파일명 생성
		String currentTime = String.valueOf(System.currentTimeMillis());
		String documentPrefix = "business-document-";
		String originalFileName = file.getOriginalFilename();
		String ext = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();

		// 확장자 체크
		if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png")) {
			throw new TeacherDocumentException("지원되지 않는 파일 형식입니다. jpg, jpeg, png만 가능합니다.");
		}

		String fileName = documentPrefix + id + "-" + currentTime + ext;
		String baseFolder = "c:/teacher-document";

		File dir = new File(baseFolder);
		if (!dir.exists()) {
			dir.mkdirs(); // 폴더 없으면 생성
		}

		File dest = new File(dir, fileName);

		try {
			
			  FileUtils.copyFile(tempFile, dest);
			  tempFile.delete();
			System.out.println("파일 저장 완료: " + dest.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
			throw new TeacherDocumentException("파일 저장 실패");
		}

		// DB에 저장할 경우 파일명, 경로를 리턴
		return dest.getAbsolutePath();
	}

	@Override
	public Map<String,Object> currentMyinfo(String username) {
		
		return teacherMemberServiceDAO.currentMyinfo(username);
	}
	@Override
	public List<Map<String,Object>>  currentMyDocuments(Long teacher_id){
		
		return teacherMemberServiceDAO.currentMyDocuments(teacher_id);
	}
}
