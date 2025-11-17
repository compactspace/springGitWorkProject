package com.spring.finall.user;

import java.sql.Timestamp;

public class TeacherDocumentVO {
	
	
	  private Long documentId;
	    private Long teacherId;
	    private String documentType;
	    private String filePath;
	    private String status;
	    private Timestamp uploadedAt;
	    private Timestamp reviewedAt;
	    private Long reviewerId;

	    // 기본 생성자
	    public TeacherDocumentVO() {
	    }

	    // 모든 필드를 포함한 생성자
	    public TeacherDocumentVO(Long documentId, Long teacherId, String documentType, String filePath,
	                           String status, Timestamp uploadedAt, Timestamp reviewedAt, Long reviewerId) {
	        this.documentId = documentId;
	        this.teacherId = teacherId;
	        this.documentType = documentType;
	        this.filePath = filePath;
	        this.status = status;
	        this.uploadedAt = uploadedAt;
	        this.reviewedAt = reviewedAt;
	        this.reviewerId = reviewerId;
	    }

	    // Getter / Setter
	    public Long getDocumentId() {
	        return documentId;
	    }

	    public void setDocumentId(Long documentId) {
	        this.documentId = documentId;
	    }

	    public Long getTeacherId() {
	        return teacherId;
	    }

	    public void setTeacherId(Long teacherId) {
	        this.teacherId = teacherId;
	    }

	    public String getDocumentType() {
	        return documentType;
	    }

	    public void setDocumentType(String documentType) {
	        this.documentType = documentType;
	    }

	    public String getFilePath() {
	        return filePath;
	    }

	    public void setFilePath(String filePath) {
	        this.filePath = filePath;
	    }

	    public String getStatus() {
	        return status;
	    }

	    public void setStatus(String status) {
	        this.status = status;
	    }

	    public Timestamp getUploadedAt() {
	        return uploadedAt;
	    }

	    public void setUploadedAt(Timestamp uploadedAt) {
	        this.uploadedAt = uploadedAt;
	    }

	    public Timestamp getReviewedAt() {
	        return reviewedAt;
	    }

	    public void setReviewedAt(Timestamp reviewedAt) {
	        this.reviewedAt = reviewedAt;
	    }

	    public Long getReviewerId() {
	        return reviewerId;
	    }

	    public void setReviewerId(Long reviewerId) {
	        this.reviewerId = reviewerId;
	    }

	    @Override
	    public String toString() {
	        return "TeacherDocument{" +
	                "documentId=" + documentId +
	                ", teacherId=" + teacherId +
	                ", documentType='" + documentType + '\'' +
	                ", filePath='" + filePath + '\'' +
	                ", status='" + status + '\'' +
	                ", uploadedAt=" + uploadedAt +
	                ", reviewedAt=" + reviewedAt +
	                ", reviewerId=" + reviewerId +
	                '}';
	    }

}
