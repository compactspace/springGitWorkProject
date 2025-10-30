package com.spring.finall.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.service.ManageOnedayClassService;
import com.spring.finall.user.OneDayClassVO;

@Service
public class ManageOnedayClassServiceImpl implements ManageOnedayClassService{

	
	@Autowired
	private ManageOnedayClassServiceDAO manageOnedayClassServiceDAO;
	
	
	@Override
	public List<Map<String, Object>> getMyActiveOnedayclassList(Long teacher_id,String yearMonth) {		
		// TODO Auto-generated method stub
		return manageOnedayClassServiceDAO.getMyActiveOnedayclassList(teacher_id,yearMonth);
	}


	@Override
	public List<Map<String, Object>> getMyActiveMonthList(Long teacher_id) {
		
		// TODO Auto-generated method stub
		return manageOnedayClassServiceDAO.getMyActiveMonthList(teacher_id);
	}


	@Override
	public OneDayClassVO getMyOneDayClassInfo(Long teacher_id) {
		// TODO Auto-generated method stub
		return manageOnedayClassServiceDAO.getMyOneDayClassInfo(teacher_id);
	}


	@Override
	public int updateOneDayClassInfo(Long teacher_id,OneDayClassVO oneDayClassVO, String 업데이트절컬럼) {
		// TODO Auto-generated method stub
		return manageOnedayClassServiceDAO.updateOneDayClassInfo(teacher_id,oneDayClassVO,업데이트절컬럼);
	}

	
	
	
	
}
