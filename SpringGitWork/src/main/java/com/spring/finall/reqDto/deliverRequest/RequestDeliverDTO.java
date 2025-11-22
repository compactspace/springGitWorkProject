package com.spring.finall.reqDto.deliverRequest;

public class RequestDeliverDTO {
    private String inventoryId;
    private String lotNo;
    private String warehouseId;
    private String productId;
    private int orderQuantity;
    private Long orderItemId;
    private Long orderInfoId;
    private int warehouseByQuantity;
    private int warehouseAlltotalQty;

    // 기본 생성자
    public RequestDeliverDTO() {}

    // getter & setter
    public String getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(String inventoryId) {
        this.inventoryId = inventoryId;
    }

    public String getLotNo() {
        return lotNo;
    }

    public void setLotNo(String lotNo) {
        this.lotNo = lotNo;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public int getWarehouseByQuantity() {
        return warehouseByQuantity;
    }

    public void setWarehouseByQuantity(int warehouseByQuantity) {
        this.warehouseByQuantity = warehouseByQuantity;
    }

    public int getWarehouseAlltotalQty() {
        return warehouseAlltotalQty;
    }

    public void setWarehouseAlltotalQty(int warehouseAlltotalQty) {
        this.warehouseAlltotalQty = warehouseAlltotalQty;
    }
    
    
    public Long getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(Long orderItemId) {
		this.orderItemId = orderItemId;
	}

	public Long getOrderInfoId() {
		return orderInfoId;
	}

	public void setOrderInfoId(Long orderInfoId) {
		this.orderInfoId = orderInfoId;
	}

	// === toString() 오버라이드 ===
    @Override
    public String toString() {
        return "창고 번호 " + warehouseId + ", 보관번호 " + inventoryId
                + "에서 주문 항목번호 에 대해 "+orderItemId+"당해 제품 전체 주문 수량 " + orderQuantity
                + "에 대해 " + warehouseByQuantity + " 만큼 꺼냄";
    } 
    
}
