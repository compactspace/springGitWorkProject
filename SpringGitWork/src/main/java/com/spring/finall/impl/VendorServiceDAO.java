package com.spring.finall.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.getVendorListDTO.GetVendorListDTO;
import com.spring.finall.reqDto.newInsertVendorRequest.newInsertVendorRequest;

@Repository
public class VendorServiceDAO {
	
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	
	public int newVendorInsert(newInsertVendorRequest newInsertVendorRequestVO) {
		 // 신규 거래처 등록
		 return mybatis.insert("VendorMapper.newVendorInsert", newInsertVendorRequestVO);
	
	}
	
	public List<GetVendorListDTO> getVendorList() {
		// TODO Auto-generated method stub
		return mybatis.selectList("VendorMapper.getVendorList");
	}

}
