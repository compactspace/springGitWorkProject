package com.spring.finall.service;

import java.util.List;

import com.spring.finall.reqDto.InsertCategoryRequestDTO;
import com.spring.finall.reqDto.getCateGoryListDTO.GetCateGoryListDTO;

public interface CategoryService {
	
	public int insertCategory(InsertCategoryRequestDTO insertCategoryRequestDTO);
	
	
	public List<GetCateGoryListDTO>  getCategoryList();


}
