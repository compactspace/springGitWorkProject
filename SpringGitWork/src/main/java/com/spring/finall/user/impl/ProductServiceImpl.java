package com.spring.finall.user.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductService;
import com.spring.finall.user.ProductVO;

@Service("productservice")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAOMybatis productdao;

	@Override
	public List<ProductVO> productlist(ProductVO vo) {

		return productdao.productlist(vo);
	}


	@Override
	public List<ProductGroupVO> getProductGroupList() {
	
		return productdao.getProductGroupList();
	}

	
	
	
	
	
	
	public List<Map<String, Object>> productGroupLlist(ProductVO vo) {

		return productdao.productGroupLlist(vo);
	}

	@Override
	public int updateOrderQuantity(int cart_quantity, int product_cod) throws PayRunTimeTranException {

		return productdao.updateOrderQuantity(cart_quantity, product_cod);

	}

	@Override
	public int completequantity(HashMap<String, ArrayList<Object>> map) {

		return productdao.completequantity(map);
	}


	@Override
	public List<Map<String, Object>> productCategoryList(ProductVO vo) {
		// TODO Auto-generated method stub
		return productdao.productCategoryLlist(vo);
	}








}
