package com.spring.finall.service;

import java.util.List;

import com.spring.finall.resDto.SearchProductResDTO.SearchProductResDTO;

public interface SearchService {
	
	List<SearchProductResDTO>  SearchFindProductList(String searchKeyword);

}
