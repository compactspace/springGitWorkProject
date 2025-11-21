package com.spring.finall.reqDto.refundRequest;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ProductRefundDTO {
    private Long productRefundId;     // 환불 고유 ID (PK)
    private Long paymentId;           // 어떤 결제에 대한 환불인지
    private BigDecimal refundedAmount; // 환불 금액
    private String reason;            // 고객 환불 사유
    private String status;            // REQUESTED, APPROVED, REJECTED 등
    private LocalDateTime requestedAt; // 환불 요청 시각
    private LocalDateTime refundedAt;  // 실제 환불 완료 시각
    private String processedBy;       // 처리 관리자 ID
    private Long orderInfoId;
    

    // Getter / Setter   
    
    
    public Long getProductRefundId() {
        return productRefundId;
    }
    public void setProductRefundId(Long productRefundId) {
        this.productRefundId = productRefundId;
    }

    public Long getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public BigDecimal getRefundedAmount() {
        return refundedAmount;
    }
    public void setRefundedAmount(BigDecimal refundedAmount) {
        this.refundedAmount = refundedAmount;
    }

    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getRequestedAt() {
        return requestedAt;
    }
    public void setRequestedAt(LocalDateTime requestedAt) {
        this.requestedAt = requestedAt;
    }

    public LocalDateTime getRefundedAt() {
        return refundedAt;
    }
    public void setRefundedAt(LocalDateTime refundedAt) {
        this.refundedAt = refundedAt;
    }

    public String getProcessedBy() {
        return processedBy;
    }
    public void setProcessedBy(String processedBy) {
        this.processedBy = processedBy;
    }
	public Long getOrderInfoId() {
		return orderInfoId;
	}
	public void setOrderInfoId(Long orderInfoId) {
		this.orderInfoId = orderInfoId;
	}
    
    
}
