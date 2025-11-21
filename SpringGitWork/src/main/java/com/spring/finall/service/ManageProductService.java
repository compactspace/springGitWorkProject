package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductVO;

public interface ManageProductService {
	
	List<Map<String,Object>> getProductCode();
	
	
	   // groupId 기준으로 활성 상품 리스트 반환
    List<Map<String,Object>> getActiveProductList(int groupId);
    
    
    
    void updateProductStatus(int productId, String status);
    
    
    void  saveProduct(ProductVO productVO, MultipartFile img);
	
    void addProductGroup(ProductGroupVO productGroupVO);
    
    List<Map<String, Object>> stockCheck(List<Map<String, Object>> orderItems);

}
