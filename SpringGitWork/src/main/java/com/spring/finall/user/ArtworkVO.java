package com.spring.finall.user;

public class ArtworkVO {
	
	  private int id;
	    private int userCode;
	    private String title;
	    private String content;
	    private boolean isDraft;
	    private String createdAt;  // String 타입으로 처리, 필요에 따라 Date로 바꿔도 됨
	    private String updatedAt;

	    
	    //DB에는 없는 페이징용 필드이다.
	    private int offSet;
	    private int limit;
	     
		public int getOffSet() {
			return offSet;
		}

		public void setOffSet(int offSet) {
			this.offSet = offSet;
		}

		public int getLimit() {
			return limit;
		}

		public void setLimit(int limit) {
			this.limit = limit;
		}
	    
	    
	    
	    
	    public ArtworkVO() {}

	    // getter & setter

	    public int getId() {
	        return id;
	    }

	    public void setId(int id) {
	        this.id = id;
	    }

	    public int getUserCode() {
	        return userCode;
	    }

	    public void setUserCode(int userCode) {
	        this.userCode = userCode;
	    }

	    public String getTitle() {
	        return title;
	    }

	    public void setTitle(String title) {
	        this.title = title;
	    }

	    public String getContent() {
	        return content;
	    }

	    public void setContent(String content) {
	        this.content = content;
	    }

	    public boolean isDraft() {
	        return isDraft;
	    }

	    public void setDraft(boolean draft) {
	        isDraft = draft;
	    }

	    public String getCreatedAt() {
	        return createdAt;
	    }

	    public void setCreatedAt(String createdAt) {
	        this.createdAt = createdAt;
	    }

	    public String getUpdatedAt() {
	        return updatedAt;
	    }

	    public void setUpdatedAt(String updatedAt) {
	        this.updatedAt = updatedAt;
	    }

}
