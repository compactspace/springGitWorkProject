package com.spring.finall.reqDto.orderRequest;



public class OrderItemDTO {
	  	private Long productId;
	    private String productName;
	    private int quantity;
	    private int pricePerUnit;
	    
	    
	    private Long orderItemId;
	    
	    
		public Long getProductId() {
			return productId;
		}
		public void setProductId(Long productId) {
			this.productId = productId;
		}
		public String getProductName() {
			return productName;
		}
		public void setProductName(String productName) {
			this.productName = productName;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		public int getPricePerUnit() {
			return pricePerUnit;
		}
		public void setPricePerUnit(int pricePerUnit) {
			this.pricePerUnit = pricePerUnit;
		}
		public Long getOrderItemId() {
			return orderItemId;
		}
		public void setOrderItemId(Long orderItemId) {
			this.orderItemId = orderItemId;
		}
	    
	    
		
	    

}
