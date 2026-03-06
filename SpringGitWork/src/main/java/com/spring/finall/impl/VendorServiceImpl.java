package com.spring.finall.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.spring.finall.reqDto.getVendorListDTO.GetVendorListDTO;
import com.spring.finall.reqDto.newInsertVendorRequest.newInsertVendorRequest;
import com.spring.finall.service.VendorService;

@Service
public class VendorServiceImpl implements VendorService {

	@Autowired
	private VendorServiceDAO vendorServiceDAO;
	
	
	 public int newVendorInsert(newInsertVendorRequest vo) {

	        try {
	            return vendorServiceDAO.newVendorInsert(vo);

	        } catch (DuplicateKeyException e) {
	            // 예: 중복 사업자 번호
	            System.err.println("중복 키 에러: " + e.getMessage());
	            return -1;

	        } catch (DataIntegrityViolationException e) {
	            // Not null 컬럼 null 등의 무결성 오류
	            System.err.println("무결성 위반: " + e.getMessage());
	            return -2;

	        } catch (DataAccessException e) {
	            // 기타 데이터 접근 예외들
	            System.err.println("DB 접근 예외: " + e.getMessage());
	            return -3;
	        }
	    }


	@Override
	public List<GetVendorListDTO> getVendorList() {
		// TODO Auto-generated method stub
		return vendorServiceDAO.getVendorList();
	}

}
