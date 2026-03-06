package com.spring.finall.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.resDto.SearchProductResDTO.SearchProductResDTO;

@Repository
public class SearchServiceDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
public List<SearchProductResDTO> SearchFindProductList(String searchKeyword) {
		
	List<SearchProductResDTO> findList=mybatis.selectList("SearchMapper.SearchFindProductList", searchKeyword);
		return findList;
	}
}
