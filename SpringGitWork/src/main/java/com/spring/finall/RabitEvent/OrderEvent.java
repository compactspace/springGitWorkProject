package com.spring.finall.RabitEvent;

import java.io.Serializable;
import java.util.List;

public class OrderEvent implements Serializable {
	private String orderId;
	private String userId;
	private List<String> items;
	private double totalAmount;

	// Getter/Setter
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public List<String> getItems() {
		return items;
	}

	public void setItems(List<String> items) {
		this.items = items;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
}