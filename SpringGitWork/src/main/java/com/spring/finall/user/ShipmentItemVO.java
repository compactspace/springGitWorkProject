package com.spring.finall.user;

import java.util.Date;

public class ShipmentItemVO {
    private Long shipmentItemId;
    private Long orderItemId;
    private Long inventoryId;
    private Long productId;
    private Integer quantity;
    private String lotNo;
    private String status;
    private Date createdAt;
    private Date updatedAt;

    // Getters & Setters
    public Long getShipmentItemId() { return shipmentItemId; }
    public void setShipmentItemId(Long shipmentItemId) { this.shipmentItemId = shipmentItemId; }

    public Long getOrderItemId() { return orderItemId; }
    public void setOrderItemId(Long orderItemId) { this.orderItemId = orderItemId; }

    public Long getInventoryId() { return inventoryId; }
    public void setInventoryId(Long inventoryId) { this.inventoryId = inventoryId; }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getLotNo() { return lotNo; }
    public void setLotNo(String lotNo) { this.lotNo = lotNo; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
