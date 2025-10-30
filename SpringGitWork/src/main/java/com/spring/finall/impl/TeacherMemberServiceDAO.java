package com.spring.finall.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TeacherMemberServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public Long insertTeacherMembership(String username, String hashedPassword) {
		// 생성키 받을 객체
		GeneratedKey generatedKey = new GeneratedKey();

		Map<String, Object> param = new HashMap<>();
		param.put("username", username);
		param.put("password", hashedPassword);
		param.put("teacherId", generatedKey); // MyBatis가 여기서 keyProperty로 채움

		mybatis.insert("UserTeacherDetailMapper.insertTeacherMembership", param);
		Long teacherId = generatedKey.getTeacherId();
		return teacherId;
	}

	// 중첩 클래스: 단발성 생성키용
	public static class GeneratedKey {
		private Long teacherId;

		public Long getTeacherId() {
			return teacherId;
		}

		public void setTeacherId(Long teacherId) {
			this.teacherId = teacherId;
		}
	}

	public int insertTeacherDocument(Long teacherId, String hashedPassword, String savedFilePath) {

		Map<String, Object> param = new HashMap<>();
		param.put("teacherId", teacherId);
		param.put("filePath", savedFilePath);

	  int affectedRow=	mybatis.insert("UserTeacherDetailMapper.insertTeacherDocument",param);
	  
	  return affectedRow;

	}
	
	
	
	public Map<String,Object> currentMyinfo(String username){
		
		Map<String,Object> map	=mybatis.selectOne("UserTeacherDetailMapper.currentMyinfo",username);
		
		return map;
	}
	

	public List<Map<String,Object>>  currentMyDocuments(Long teacher_id){
		
		List<Map<String,Object>> currentMyDocuments	=mybatis.selectList("UserTeacherDetailMapper.currentMyDocuments",teacher_id);
		return  currentMyDocuments ;
	}
	
}
