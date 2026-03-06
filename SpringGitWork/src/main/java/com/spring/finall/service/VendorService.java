package com.spring.finall.service;

import java.util.List;

import com.spring.finall.reqDto.getVendorListDTO.GetVendorListDTO;
import com.spring.finall.reqDto.newInsertVendorRequest.newInsertVendorRequest;

public interface VendorService {
	
	public int newVendorInsert(newInsertVendorRequest newInsertVendorRequestVO);
	public List<GetVendorListDTO> getVendorList();
	
	
}
