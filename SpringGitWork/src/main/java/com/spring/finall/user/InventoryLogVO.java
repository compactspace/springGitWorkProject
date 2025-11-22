package com.spring.finall.user;

import java.util.Date;

public class InventoryLogVO {
    private Long inventoryLogId;
    private Long inventoryId;
    private Integer changeQty;
    private String type;
    private Long relatedOrderItemId;
    private String note;
    private Date createdAt;

    // Getters & Setters
    public Long getInventoryLogId() { return inventoryLogId; }
    public void setInventoryLogId(Long inventoryLogId) { this.inventoryLogId = inventoryLogId; }

    public Long getInventoryId() { return inventoryId; }
    public void setInventoryId(Long inventoryId) { this.inventoryId = inventoryId; }

    public Integer getChangeQty() { return changeQty; }
    public void setChangeQty(Integer changeQty) { this.changeQty = changeQty; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Long getRelatedOrderItemId() { return relatedOrderItemId; }
    public void setRelatedOrderItemId(Long relatedOrderItemId) { this.relatedOrderItemId = relatedOrderItemId; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}