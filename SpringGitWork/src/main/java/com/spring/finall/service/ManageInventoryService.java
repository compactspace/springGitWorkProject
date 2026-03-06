package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import com.spring.finall.reqDto.atemptStockInRequestDTO.AtemptStockInRequestDTO;
import com.spring.finall.user.GetIncomingStockListVO;
import com.spring.finall.user.InventoryVO;
import com.spring.finall.user.WarehouseVO;

public interface ManageInventoryService {

	List<GetIncomingStockListVO> getIncomingStockList();

	Map<Long, List<InventoryVO>> getFullInventoryList();

	List<WarehouseVO> getWarehouseList();

	void atemptStockIn(List<AtemptStockInRequestDTO> purchaseList, List<AtemptStockInRequestDTO> initialList

	);
}
