package com.spring.finall.reqDto.getCateGoryListDTO;

import java.sql.Timestamp;

public class GetCateGoryListDTO {

    private int categoryId;
    private Integer parentId; // NULL 허용
    private String name;
    private int sortOrder;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 기본 생성자
    public GetCateGoryListDTO() {}

    // 전체 생성자
    public GetCateGoryListDTO(int categoryId, Integer parentId, String name, int sortOrder,
                              boolean isActive, Timestamp createdAt, Timestamp updatedAt) {
        this.categoryId = categoryId;
        this.parentId = parentId;
        this.name = name;
        this.sortOrder = sortOrder;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter & Setter
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
