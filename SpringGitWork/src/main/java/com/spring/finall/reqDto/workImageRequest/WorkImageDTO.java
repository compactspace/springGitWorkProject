package com.spring.finall.reqDto.workImageRequest;

public class WorkImageDTO {
    private int imageId;
    private int workId;
    private String imageUrl;
    private boolean isThumbnail;
    private int sortOrder;

    // 기본 생성자
    public WorkImageDTO() {}

    // 전체 필드 생성자
    public WorkImageDTO(int imageId, int workId, String imageUrl, boolean isThumbnail, int sortOrder) {
        this.imageId = imageId;
        this.workId = workId;
        this.imageUrl = imageUrl;
        this.isThumbnail = isThumbnail;
        this.sortOrder = sortOrder;
    }

    // Getter / Setter
    public int getImageId() {
        return imageId;
    }
    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getWorkId() {
        return workId;
    }
    public void setWorkId(int workId) {
        this.workId = workId;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isThumbnail() {
        return isThumbnail;
    }
    public void setThumbnail(boolean thumbnail) {
        isThumbnail = thumbnail;
    }

    public int getSortOrder() {
        return sortOrder;
    }
    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
}
