package com.spring.finall.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.reqDto.InsertCategoryRequestDTO;
import com.spring.finall.reqDto.getCateGoryListDTO.GetCateGoryListDTO;
import com.spring.finall.service.CategoryService;

@Service
public class CategoryServiceImple implements CategoryService {

	@Autowired
	private CategoryServiceDAO categoryServiceDAO;
	@Override
	public int insertCategory(InsertCategoryRequestDTO insertCategoryRequestDTO) {
		// TODO Auto-generated method stub
		return categoryServiceDAO.insertCategoryWithChildrenAndAttributes(insertCategoryRequestDTO);
	}
	@Override
	public List<GetCateGoryListDTO> getCategoryList() {
		// TODO Auto-generated method stub
		return categoryServiceDAO.getCategoryList();
	}
	
	

}
