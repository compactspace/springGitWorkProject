package com.spring.finall.user;

public class GetIncomingStockListVO {

    private Long inventoryId;
    private Long productId;
    private String productName;
    private Boolean hasInitialStock;
    private String lastMovementType;

    
    private Long warehouseId;
    private String warehouse_name;
    private Long quantity;
    
    
    
    
    
    
    public Long getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(Long warehouseId) {
		this.warehouseId = warehouseId;
	}

	public String getWarehouseName() {
		return warehouse_name;
	}

	public void setWarehouseName(String warehouse_name) {
		this.warehouse_name = warehouse_name;
	}

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

	// 🔹 Getters & Setters
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Boolean getHasInitialStock() {
        return hasInitialStock;
    }

    public void setHasInitialStock(Boolean hasInitialStock) {
        this.hasInitialStock = hasInitialStock;
    }

    public String getLastMovementType() {
        return lastMovementType;
    }

    public void setLastMovementType(String lastMovementType) {
        this.lastMovementType = lastMovementType;
    }

    @Override
    public String toString() {
        return "GetIncomingStockListVO [inventoryId=" + inventoryId + ", productId=" + productId 
                + ", productName=" + productName + ", hasInitialStock=" + hasInitialStock 
                + ", lastMovementType=" + lastMovementType + "]";
    }
}