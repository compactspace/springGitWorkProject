package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.FormSecurity.teacher.UserTeacherDetail;
import com.spring.finall.user.OneDayClassVO;

public interface ManageOnedayClassService {
	
	public List<Map<String,Object>> getMyActiveOnedayclassList (Long teacher_id,String yearMonth);
	
	public List<Map<String,Object>> getMyActiveMonthList (Long teacher_id);
	
	public OneDayClassVO getMyOneDayClassInfo(Long teacher_id);
	
	
	
	public int openMonthOnedayClass (Map<String,Object> bodyParam);
	
	
	public int updateOneDayClassInfo (Long teacher_id,OneDayClassVO oneDayClassVO ,String 업데이트절컬럼);
	

}
