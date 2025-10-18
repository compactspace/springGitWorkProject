package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.service.OneDayClassService;
import com.spring.finall.user.OneDayClassVO;

@Service("onedayclass")
public class OneDayClassServiceImpl implements OneDayClassService {
	
	@Autowired
	OneDayClassDAObatis odao;

	@Override
	public List<OneDayClassVO> selectOneDayClass(OneDayClassVO vo) {
		
		return odao.selectOneDayClass(vo);
		
	}
	@Override
	public  HashMap<String,Object> getReview(OneDayClassVO ovo){
		
		return odao.getReview(ovo);
	}
	@Override
	public HashMap<String, Object> getReview2(OneDayClassVO ovo) {
		// TODO Auto-generated method stub
		return odao.getReview2(ovo);
	}
	@Override
	public List<OneDayClassVO> selectDayClassList(OneDayClassVO vo) {
		// TODO Auto-generated method stub
		return odao.selectDayClassList(vo);
	}
	@Override
	public OneDayClassVO getOneOneDayClass(OneDayClassVO vo) {
		// TODO Auto-generated method stub
		return odao.getOneOneDayClass(vo);
	}
	

}
