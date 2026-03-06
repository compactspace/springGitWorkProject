package com.spring.finall.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.atemptStockInRequestDTO.AtemptStockInRequestDTO;
import com.spring.finall.user.GetIncomingStockListVO;
import com.spring.finall.user.InventoryVO;
import com.spring.finall.user.WarehouseVO;

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
			warehouseInventoryMap.computeIfAbsent(warehouseId, k -> new ArrayList<>()).add(iv);
		}

		// 예: Map 출력
		for (Map.Entry<Long, List<InventoryVO>> entry : warehouseInventoryMap.entrySet()) {
			System.out.println("Warehouse " + entry.getKey() + " -> " + entry.getValue().size() + " items");
		}

		return warehouseInventoryMap;
	}

	public List<WarehouseVO> getWarehouseList() {
		List<WarehouseVO> warehouseList = mybatis.selectList("ManageinventoryMapper.getWarehouseList");
		return warehouseList;
	}

	public List<Long> createInventory(int productId, List<Long> warehouseIds, Map<String, Integer> quantityMap) {

		List<Long> generatedInventoryIdList = new ArrayList<>();

		for (Long warehouseId : warehouseIds) {

// 창고별 수량 꺼내기 (product_quantity[창고ID])
			Integer qty = quantityMap.get(String.valueOf(warehouseId));
			if (qty == null) {
				qty = 0;
			}

			Map<String, Object> params = new HashMap<>();
			params.put("productId", productId);
			params.put("warehouseId", warehouseId);
			params.put("quantity", qty);
			params.put("lotNo", generateLot());

// insert 실행
			mybatis.insert("ManageinventoryMapper.createInventory", params);
			Long generatedInventoryId = (Long) params.get("inventoryId");
			generatedInventoryIdList.add(generatedInventoryId);
		}

		return generatedInventoryIdList;
	}

	public static String generateLot() {
		String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String uuidSegment = UUID.randomUUID().toString().substring(0, 4).toUpperCase();
		return "LOT" + dateStr + uuidSegment;
	}

	public List<Long> recordInventoryLogByCreateInventory(List<Long> generatedInventoryIdList, List<Long> warehouseIds,
			Map<String, Integer> quantityMap) {

		List<Long> generatedInventoryLogIdList = new ArrayList<>();

		for (int i = 0; i < generatedInventoryIdList.size(); i++) {
			Long inventoryId = generatedInventoryIdList.get(i);
			Long warehouseId = warehouseIds.get(i); // 순서가 createInventory와 동일하므로 안전

			Integer quantity = quantityMap.getOrDefault(String.valueOf(warehouseId), 0);

			Map<String, Object> params = new HashMap<>();
			params.put("inventoryId", inventoryId);
			params.put("quantity", quantity);

			mybatis.insert("ManageinventoryMapper.recordInventoryLogByCreateInventory", params);

			Long inventoryLogId = (Long) params.get("inventoryLogId");
			if (inventoryLogId != null) {
				generatedInventoryLogIdList.add(inventoryLogId);
			}
		}

		return generatedInventoryLogIdList;
	}

	public List<GetIncomingStockListVO> getIncomingStockList() {
		List<GetIncomingStockListVO> getIncomingStockList = mybatis
				.selectList("ManageinventoryMapper.getIncomingStockList");
		return getIncomingStockList;
	}

	public void atemptIntitailStockIn(List<AtemptStockInRequestDTO> initialList) {

		if (initialList == null || initialList.isEmpty()) {
			return;
		}

		for (AtemptStockInRequestDTO dto : initialList) {
			dto.setLotNo(generateLot());
			dto.setReservedQuantity(0);
			dto.setHasInitialStock(1);

		}

		mybatis.insert("ManageinventoryMapper.batchInitialStockIn", initialList);

		// 2. batch insert 후 새로 들어간 inventory_id 조회
		List<Long> inventoryIds = mybatis.selectList("ManageinventoryMapper.selectInsertedInventoryIds", initialList // productId
																														// +
																														// lotNo
																														// +
																														// warehouseId
																														// 포함
		);

		// 3. 로그 DTO 생성
		List<InitialStockInLogDTO> logList = new ArrayList<>();
		for (int i = 0; i < initialList.size(); i++) {
			InitialStockInLogDTO log = new InitialStockInLogDTO();
			log.setInventory_id(inventoryIds.get(i));
			log.setChange_qty(initialList.get(i).getQuantity());
			log.setType("INITIAL");
			logList.add(log);
		}

		// 4. batch insert log
		mybatis.insert("ManageinventoryMapper.batchInitialStockInLog", logList);

	}

	public void atemptStockInByPurchace(List<AtemptStockInRequestDTO> purchaseList) {
		
		mybatis.update("ManageinventoryMapper.updateInventoryByPurchase", purchaseList);
		mybatis.insert("ManageinventoryMapper.insertInventoryLog", purchaseList);

	}

	public class InitialStockInLogDTO {
		Long inventory_id;
		int change_qty;
		String type = "INITIAL";

		public Long getInventory_id() {
			return inventory_id;
		}

		public void setInventory_id(Long inventory_id) {
			this.inventory_id = inventory_id;
		}

		public int getChange_qty() {
			return change_qty;
		}

		public void setChange_qty(int change_qty) {
			this.change_qty = change_qty;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

	}
}
