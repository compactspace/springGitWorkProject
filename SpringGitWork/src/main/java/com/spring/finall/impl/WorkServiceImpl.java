package com.spring.finall.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.WorkImgVO;
import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;
import com.spring.finall.service.WorkService;
@Service("workservice")
public class WorkServiceImpl implements WorkService {

	@Autowired
	private WorkDAOMybatis workDAO;
	
	@Autowired
	private WorkServcieRedisDao wrokCommentRedisDao;

	@Override
	public void insertworkimg(WorkImgVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<WorkImgVO> gettworkimg(WorkImgVO vo) {
		
		return workDAO.getworkList(vo);

	}
	
	
	@Override
	public List<WorkImgVO> graterthanonepage(WorkImgVO vo) {
		
		return workDAO.graterthanonepage(vo);

	}
	
	
	@Override	
    public int  numfornextorback(WorkImgVO vo) {
		
		return workDAO.numfornextorback(vo);
	}
	
	
	public void insertImg(WorkImgVO vo) {
		workDAO.insertImg(vo);
		
	}

	@Override
	public List<Map<String, Object>> getWorkReviews(int onedayclass_num) {
		// TODO Auto-generated method stub
		return workDAO.getWorkReviews(onedayclass_num);
	}

	@Override
	public Map<String, Object> getWorkDetail(int wrok_id) {
		// TODO Auto-generated method stub
		return workDAO.getWorkDetail(wrok_id);
	}

	@Override
	public List<Map<String, Object>> getMoreWorkComments(int work_id, int limit,int offset) {
		// TODO Auto-generated method stub
		return workDAO.getMoreWorkComments(work_id, limit,offset);
	}

	@Override
	public Long writeWorkComment( WorkCommentDTO workCommentDTO,int userCode) {		
	
		wrokCommentRedisDao.incrementCommentWriteAttempt(workCommentDTO,userCode);		
		
		Long   commentId=	workDAO.writeWorkComment(workCommentDTO, userCode);
		return commentId;
	}


}
