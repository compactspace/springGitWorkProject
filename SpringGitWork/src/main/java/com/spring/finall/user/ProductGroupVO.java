package com.spring.finall.user;

public class ProductGroupVO {
    private int groupId;
    private String groupName;
    private String groupDescription;

    // 기본 생성자
    public ProductGroupVO() {}

    // Getter & Setter
    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupDescription() {
        return groupDescription;
    }

    public void setGroupDescription(String groupDescription) {
        this.groupDescription = groupDescription;
    }
}
