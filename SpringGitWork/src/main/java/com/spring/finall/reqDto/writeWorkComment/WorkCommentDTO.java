package com.spring.finall.reqDto.writeWorkComment;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Date;  // 추가

public class WorkCommentDTO {

    private int userCode;

    // 부모 댓글 ID (답글인 경우에만 사용, 없으면 null 가능)
    private Long parentId;

    // 댓글 자체 ID (수정 등에서 필요하면, 아니면 null 가능)
    private Long commentId;

    // 작품 ID (필수)
    private Long workId;

    // 댓글 내용 (필수, 공백X, 최대 2200자)
    @NotBlank(message = "댓글 내용을 입력해주세요.")
    @Size(max = 2200, message = "댓글은 최대 2200자까지 입력할 수 있습니다.")
    private String comment;

    // 생성일
    private Date createdAt;

    // 수정일
    private Date updatedAt;

    // -- getter/setter --

    public Long getParentId() {
        return parentId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Long getWorkId() {
        return workId;
    }

    public void setWorkId(Long workId) {
        this.workId = workId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
