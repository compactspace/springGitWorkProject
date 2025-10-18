package com.spring.finall.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finall.user.OneDayClassVO;

public interface OneDayClassService {
	
	public abstract List<OneDayClassVO> selectOneDayClass(OneDayClassVO vo);
	
	public abstract OneDayClassVO getOneOneDayClass(OneDayClassVO vo);
	
	public abstract List<OneDayClassVO> selectDayClassList(OneDayClassVO vo);

	public abstract HashMap<String,Object> getReview(OneDayClassVO ovo);
	
	public abstract HashMap<String,Object> getReview2(OneDayClassVO ovo);
}
