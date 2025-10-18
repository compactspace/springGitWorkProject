package com.spring.finall.reqDto.payMentRequest;


import java.time.LocalDateTime;

public class PaymentDTO {
	
	//참조키용
	private Long productId;
	
	
	
    private Long paymentId;          // 결제 ID (자동 증가)
    private Long orderInfoId;       // 주문 정보 ID (외래 키)
    private String paymentNumber;   // 결제 번호 (고유)
    private Integer amount;         // 결제 금액
    private String paymentMethod;   // 결제 방법
    private LocalDateTime createdAt; // 생성 일시

    
    
    
    
    
    
    public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	// Getter 및 Setter 메서드
    public Long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public Long getOrderInfoId() {
        return orderInfoId;
    }

    public void setOrderInfoId(Long orderInfoId) {
        this.orderInfoId = orderInfoId;
    }

    public String getPaymentNumber() {
        return paymentNumber;
    }

    public void setPaymentNumber(String paymentNumber) {
        this.paymentNumber = paymentNumber;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // toString 메서드 (디버깅 및 로깅 용도)
    @Override
    public String toString() {
        return "PaymentDTO{" +
                "paymentId=" + paymentId +
                ", orderInfoId=" + orderInfoId +
                ", paymentNumber='" + paymentNumber + '\'' +
                ", amount=" + amount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
    
    // toStringLog 메서드 추가 (OrderRequestDTO 스타일 참고)
    public void toStringLog() {
        System.out.println("PaymentDTO {");
        System.out.println("  paymentId: " + paymentId);
        System.out.println("  orderInfoId: " + orderInfoId);
        System.out.println("  paymentNumber: " + paymentNumber);
        System.out.println("  amount: " + amount);
        System.out.println("  paymentMethod: " + paymentMethod);
        System.out.println("  createdAt: " + createdAt);
        System.out.println("}");
    }
}