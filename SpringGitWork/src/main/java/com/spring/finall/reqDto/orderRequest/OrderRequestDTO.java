package com.spring.finall.reqDto.orderRequest;

import java.util.List;

public class OrderRequestDTO {
	private Long userId;
	private int userCode;

	private Long orderInfoId;
	private List<Long> orderItemId;

	private List<OrderItemDTO> items;
	private OrderPersonDTO person;
	
	private String merchantUid;	

	public String getMerchantUid() {
		return merchantUid;
	}

	public void setMerchantUid(String merchantUid) {
		this.merchantUid = merchantUid;
	}

	public List<Long> getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(List<Long> orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getUserCode() {
		return userCode;
	}

	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}

	public Long getUserId() {
		return userId;
	}

	public Long getOrderInfoId() {
		return orderInfoId;
	}

	public void setOrderInfoId(Long orderInfoId) {
		this.orderInfoId = orderInfoId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public List<OrderItemDTO> getItems() {
		return items;
	}

	public void setItems(List<OrderItemDTO> items) {
		this.items = items;
	}

	public OrderPersonDTO getPerson() {
		return person;
	}

	public void setPerson(OrderPersonDTO person) {
		this.person = person;
	}

	public void toStringLog() {
		System.out.println("OrderRequestDTO {");
		System.out.println("  userId: " + userId);

		System.out.println("  items: [");
		if (items != null) {
			for (OrderItemDTO item : items) {
				System.out.println("    {");
				System.out.println("      productId: " + item.getProductId());
				System.out.println("      productName: " + item.getProductName());
				System.out.println("      quantity: " + item.getQuantity());
				System.out.println("      pricePerUnit: " + item.getPricePerUnit());
				System.out.println("    },");
			}
		}
		System.out.println("  ]");

		if (person != null) {
			System.out.println("  person: {");
			System.out.println("    name: " + person.getName());
			System.out.println("    email: " + person.getEmail());
			System.out.println("    phone: " + person.getPhone());
			System.out.println("  }");
		}

		System.out.println("}");
	}

}
