package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.finall.reqDto.createOpendayOneDayCLassRequestDTO.OpenDayAndRestDTO;
import com.spring.finall.reqDto.manageonedayclass.AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO;
import com.spring.finall.user.OneDayClassVO;

public interface ManageOnedayClassService {

	public List<Map<String, Object>> getMyActiveOnedayclassList(Long teacher_id, String yearMonth);


	public List<Map<String, Object>> getMyActiveMonthList(Long teacher_id);
	
	public List<Map<String,Object>> getAsyncCurrentMonthOpenningOnedyaClassBySelectOpenList(AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO asyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO);

	public OneDayClassVO getMyOneDayClassInfo(Long teacher_id);

	public List<Map<String, Object>> openMonthOnedayClass(Map<String, Object> bodyParam);
	
	
	
	
	public void openSelectdayOnedyaclass(List<OpenDayAndRestDTO> openDayAndRestDTO);

	public int updateOneDayClassInfo(Long teacher_id, OneDayClassVO oneDayClassVO, String 업데이트절컬럼);
	
	public int updateManageOnedayclassStatus( Long teacher_id,String openday, String manageStatus,String nowStatus);

}
