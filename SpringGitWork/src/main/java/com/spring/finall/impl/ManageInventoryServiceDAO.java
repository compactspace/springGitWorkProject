package com.spring.finall.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.InventoryVO;

@Repository
public class ManageInventoryServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public Map<Long, List<InventoryVO>> getFullInventoryList() {

		List<InventoryVO> fullInventoryList = mybatis.selectList("ManageinventoryMapper.getFullinventory");

		
		
		
		// Map<창고ID, List<InventoryVO>>
		Map<Long, List<InventoryVO>> warehouseInventoryMap = new HashMap<>();

		for (InventoryVO iv : fullInventoryList) {
		    Long warehouseId = iv.getWarehouseId();

		    // 기존 리스트가 없으면 새로 생성
		    warehouseInventoryMap
		        .computeIfAbsent(warehouseId, k -> new ArrayList<>())
		        .add(iv);
		}

		
		// 예: Map 출력
		for (Map.Entry<Long, List<InventoryVO>> entry : warehouseInventoryMap.entrySet()) {
		    System.out.println("Warehouse " + entry.getKey() + " -> " + entry.getValue().size() + " items");
		}
	

		return warehouseInventoryMap;
	}

}
