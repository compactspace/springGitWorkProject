package com.spring.finall.user;

import java.util.Date;

public class ArtWorkCommentVO {

    private int artworkCommentId;      // artwork_comment_id
    private int artworkId;             // artwork_id
    private Integer parentCommentId;   // parent_comment_id (NULL 허용)
    private int userCode;              // user_code
    private String userNickname;       // user_nickname
    private String commentText;        // comment_text
    private int depth;                 // depth
    private Date createdAt;            // created_at

    
    
    // 페이징용 물론 DB엔없는 컬러임
    
  
    
    // Getter / Setter

    public int getArtworkCommentId() {
        return artworkCommentId;
    }

    public void setArtworkCommentId(int artworkCommentId) {
        this.artworkCommentId = artworkCommentId;
    }

    public int getArtworkId() {
        return artworkId;
    }

    public void setArtworkId(int artworkId) {
        this.artworkId = artworkId;
    }

    public Integer getParentCommentId() {
        return parentCommentId;
    }

    public void setParentCommentId(Integer parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    
 
    
    
    
    
}
