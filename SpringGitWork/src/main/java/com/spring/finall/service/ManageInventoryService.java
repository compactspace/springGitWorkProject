package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.finall.user.InventoryVO;
import com.spring.finall.user.WarehouseVO;

public interface ManageInventoryService {
	

	Map<Long, List<InventoryVO>> getFullInventoryList();
	
	List<WarehouseVO> getWarehouseList();
	

}
