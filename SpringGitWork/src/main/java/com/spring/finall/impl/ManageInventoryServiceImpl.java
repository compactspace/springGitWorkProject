package com.spring.finall.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.reqDto.atemptStockInRequestDTO.AtemptStockInRequestDTO;
import com.spring.finall.service.ManageInventoryService;
import com.spring.finall.user.GetIncomingStockListVO;
import com.spring.finall.user.InventoryVO;
import com.spring.finall.user.WarehouseVO;

@Service
public class ManageInventoryServiceImpl implements ManageInventoryService {

	@Autowired
	private ManageInventoryServiceDAO manageInventoryServiceDAO;

	@Override
	public Map<Long, List<InventoryVO>> getFullInventoryList() {
		// TODO Auto-generated method stub
		return manageInventoryServiceDAO.getFullInventoryList();
	}

	@Override
	public List<WarehouseVO> getWarehouseList() {
		// TODO Auto-generated method stub
		return manageInventoryServiceDAO.getWarehouseList();
	}

	@Override
	public List<GetIncomingStockListVO> getIncomingStockList() {
		// TODO Auto-generated method stub
		return manageInventoryServiceDAO.getIncomingStockList();
	}

	@Transactional
	@Override
	public void atemptStockIn(List<AtemptStockInRequestDTO> purchaseList,
	                           List<AtemptStockInRequestDTO> initialList) {

	    if (initialList != null && !initialList.isEmpty()) {
	        manageInventoryServiceDAO.atemptIntitailStockIn(initialList);
	    }

	    if (purchaseList != null && !purchaseList.isEmpty()) {
	        manageInventoryServiceDAO.atemptStockInByPurchace(purchaseList);
	    }

	}

}
