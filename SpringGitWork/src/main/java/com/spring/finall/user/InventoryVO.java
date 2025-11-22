package com.spring.finall.user;

import java.util.Date;

public class InventoryVO {

    private Long inventoryId;
    private Long productId;
    private Long warehouseId;
    private String lotNo;
    private Integer quantity;
    private Integer reservedQuantity;
    private Date expireDate;
    private Date createdAt;
    private Date updatedAt;

    // 🔥 추가: 조인된 Warehouse 객체
    private WarehouseVO warehouse;


    // Getters & Setters
    public Long getInventoryId() { return inventoryId; }
    public void setInventoryId(Long inventoryId) { this.inventoryId = inventoryId; }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }

    public Long getWarehouseId() { return warehouseId; }
    public void setWarehouseId(Long warehouseId) { this.warehouseId = warehouseId; }

    public String getLotNo() { return lotNo; }
    public void setLotNo(String lotNo) { this.lotNo = lotNo; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Integer getReservedQuantity() { return reservedQuantity; }
    public void setReservedQuantity(Integer reservedQuantity) { this.reservedQuantity = reservedQuantity; }

    public Date getExpireDate() { return expireDate; }
    public void setExpireDate(Date expireDate) { this.expireDate = expireDate; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    // 🔥 Getter/Setter for WarehouseVO
    public WarehouseVO getWarehouse() { return warehouse; }
    public void setWarehouse(WarehouseVO warehouse) { this.warehouse = warehouse; }
}
