package com.spring.finall.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.resDto.SearchProductResDTO.SearchProductResDTO;
import com.spring.finall.service.SearchService;

@Service
public class SearchServiceImpl implements SearchService{

	@Autowired
	private SearchServiceDAO searchServiceDAO;
	
	
	@Override
	public List<SearchProductResDTO> SearchFindProductList(String searchKeyword) {
		
		return searchServiceDAO.SearchFindProductList(searchKeyword);
	}

}
