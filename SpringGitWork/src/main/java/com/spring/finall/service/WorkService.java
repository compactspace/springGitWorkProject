package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.finall.WorkImgVO;
import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;

public interface WorkService {

	public List<Map<String, Object>> getWorkReviews(int onedayclass_num);

	public Map<String, Object> getWorkDetail(int wrok_id);

	public List<Map<String, Object>> getMoreWorkComments(int work_id, int limit,int offset);

	public Long writeWorkComment( WorkCommentDTO workCommentDTO,int userCode);

//원데이 클래스 학생들 그린 작품 삽입	
	public abstract void insertworkimg(WorkImgVO vo);

//원데이 클래스 학생들 그린 모든작품들 불러오기	
	public abstract List<WorkImgVO> gettworkimg(WorkImgVO vo);

//아작스와 페이징 기능으로 학생들 그린 작 품 풀러오기

	public abstract List<WorkImgVO> graterthanonepage(WorkImgVO vo);

//페이징 판단 정수 함수

	public abstract int numfornextorback(WorkImgVO vo);

//드디어 학생들이 사진은 등록하는 함수
	public abstract void insertImg(WorkImgVO vo);

}
