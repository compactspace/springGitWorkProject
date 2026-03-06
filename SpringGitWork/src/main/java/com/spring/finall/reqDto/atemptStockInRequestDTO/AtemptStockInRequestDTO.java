package com.spring.finall.reqDto.atemptStockInRequestDTO;

import java.util.Date;

public class AtemptStockInRequestDTO {

    private Long inventoryId;
    private Long productId;
    private Long warehouseId;
    private Integer quantity;

    private  String type;
    
    
    
    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	// 배치 insert용 추가 필드
    private String lotNo;
    private Integer reservedQuantity = 0; // 기본값 0
    private Date expireDate;              // null 허용
    private Integer hasInitialStock = 1;  // 초기 재고 표시

    // Getter & Setter
    public Long getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(Long inventoryId) {
        this.inventoryId = inventoryId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Long warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getLotNo() {
        return lotNo;
    }

    public void setLotNo(String lotNo) {
        this.lotNo = lotNo;
    }

    public Integer getReservedQuantity() {
        return reservedQuantity;
    }

    public void setReservedQuantity(Integer reservedQuantity) {
        this.reservedQuantity = reservedQuantity;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public Integer getHasInitialStock() {
        return hasInitialStock;
    }

    public void setHasInitialStock(Integer hasInitialStock) {
        this.hasInitialStock = hasInitialStock;
    }
}