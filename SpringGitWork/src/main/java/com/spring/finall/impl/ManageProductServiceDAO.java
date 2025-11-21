package com.spring.finall.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductPriceHistoryVO;
import com.spring.finall.user.ProductVO;

@Repository
public class ManageProductServiceDAO {

	@Autowired
	private SqlSessionTemplate mybaits;

	public List<Map<String, Object>> getProductCode() {

		List<Map<String, Object>> productCodeList = mybaits.selectList("ManageProductMapper.getProductCode");

		return productCodeList;
	}

	public List<Map<String, Object>> getActiveProductList(int groupId) {
		List<Map<String, Object>> productCodeList = mybaits.selectList("ManageProductMapper.getActiveProductList",
				groupId);

		return productCodeList;
	}

	public void updateProductStatus(int productId, String status) {
		// productId와 status를 Map으로 전달
		Map<String, Object> param = Map.of("productId", productId, "status", status);
		mybaits.update("ManageProductMapper.updateProductStatus", param);
	}

	public void saveProduct(ProductVO productVO) {

		int affectedRow = mybaits.insert("ManageProductMapper.saveProduct", productVO);

	}

	public void insertProductPriceHistory(ProductPriceHistoryVO productPriceHistoryVO) {

		int affectedRow = mybaits.insert("ManageProductMapper.insertProductPriceHistory", productPriceHistoryVO);

	}

	// 내업보다.. 씨불
	public String alreadyExsistProduct(String product_name) {
		// 1. MyBatis에서 최대값 조회
		String alreadyExsistProduct = mybaits.selectOne("ManageProductMapper.alreadyExsistProduct", product_name);

		// 5. 다시 문자열로 변환하여 반환
		return alreadyExsistProduct;
	}

	// 내업보다.. 씨불
	public int getproductCod() {
		// 1. MyBatis에서 최대값 조회
		Integer maxProductCod = mybaits.selectOne("ManageProductMapper.getCurrentMaxproductCod");

		// 2. null 처리 (제품이 하나도 없을 경우)
		if (maxProductCod == null) {
			return 1; // 첫 번째 코드로 1 반환
		}

		int nextProductCod = maxProductCod + 1;

		// 5. 다시 문자열로 변환하여 반환
		return nextProductCod;
	}

	public boolean alreadyProductGroupName(ProductGroupVO productGroupVO) {

		ProductGroupVO groupName = mybaits.selectOne("ManageProductMapper.alreadyProductGroupName", productGroupVO);

		return groupName != null ? true : false;
	}

	public boolean addProductGroup(ProductGroupVO productGroupVO) {

		int affectedRow = mybaits.insert("ManageProductMapper.addProductGroup", productGroupVO);

		return affectedRow >= 1 ? true : false;
	}

	public List<Map<String, Object>> stockCheck(List<Map<String, Object>> orderItems) {

		List<Map<String, Object>> nowStock = mybaits.selectList("ManageProductMapper.stockCheck", orderItems);

		return possibleStock(nowStock, orderItems);
	}

	public List<Map<String, Object>> possibleStock(List<Map<String, Object>> nowStock,
			List<Map<String, Object>> orderItems) {

		List<Map<String, Object>> result = new ArrayList<>();

		// orderItems 기준으로 반복
		for (Map<String, Object> orderItem : orderItems) {
			Long productId = Long.valueOf(orderItem.get("productId").toString());
			Integer orderQty = Integer.valueOf(orderItem.get("quantity").toString());

			// DB 재고 찾기
			Map<String, Object> stockItem = nowStock.stream()
					.filter(s -> Long.valueOf(s.get("product_id").toString()).equals(productId)).findFirst()
					.orElse(null);

			Map<String, Object> itemResult = new HashMap<>(orderItem);

			if (stockItem != null) {
				Integer stockQty = Integer.valueOf(stockItem.get("product_quantity").toString());

				 if (stockQty >= orderQty) {
				        itemResult.put("status", "AVAILABLE");
				    } else if (stockQty > 0 && stockQty < orderQty) {
				        itemResult.put("status", "UNAVAILABLE");
				        itemResult.put("availableQuantity", stockQty);
				    } else { // stockQty == 0
				        itemResult.put("status", "SOLDOUT");
				        itemResult.put("unAvailableQuantity", 0);
				    }
			} else {
				// DB에 상품이 없는 경우
				itemResult.put("status", "SOLDOUT");
				itemResult.put("unAvailableQuantity", 0);
			}

			result.add(itemResult);
		}

		return result;
	}

}
