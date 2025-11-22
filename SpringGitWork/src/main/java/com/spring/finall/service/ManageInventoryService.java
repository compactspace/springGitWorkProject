package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.finall.user.InventoryVO;

public interface ManageInventoryService {
	

	Map<Long, List<InventoryVO>> getFullInventoryList();
	

}
