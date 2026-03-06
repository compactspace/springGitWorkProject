package com.spring.finall.reqDto;

import java.util.List;

public class InsertCategoryRequestDTO {

    // 상위 카테고리 ID (없으면 최상위)
    private Integer parentId;

    // 카테고리명 (필수)
    private String name;

    // 정렬 순서
    private Integer sortOrder = 0;

    // 사용 여부
    private Boolean isActive = true;

    // 하위 카테고리명 리스트 (선택)
    private List<String> children;
    
    
    private Integer categoryId;  // 마이바티스 sql mapper에서  DB에서 생성된 PK 저장용

 // getter / setter
 public Integer getCategoryId() {
     return categoryId;
 }

 public void setCategoryId(Integer categoryId) {
     this.categoryId = categoryId;
 }
    
    

    // =======================
    // 기본 생성자 / 게터 / 세터
    // =======================

    
    public InsertCategoryRequestDTO() {}

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

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public List<String> getChildren() {
        return children;
    }

    public void setChildren(List<String> children) {
        this.children = children;
    }
    
    @Override
    public String toString() {
        return "InsertCategoryRequestDTO{" +
                "parentId=" + parentId +
                ", name='" + name + '\'' +
                ", sortOrder=" + sortOrder +
                ", isActive=" + isActive +
                ", children=" + children +
               
                '}';
    }

}
