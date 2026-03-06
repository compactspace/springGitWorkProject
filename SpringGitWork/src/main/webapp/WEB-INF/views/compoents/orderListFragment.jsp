<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
li {
	list-style: none;
}

.order {
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 16px;
	margin-bottom: 16px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.order h3 {
	margin: 0 0 8px 0;
	color: #333;
	font-weight: 600;
}

.order p {
	margin: 4px 0;
	color: #555;
	font-size: 14px;
}

.order ul {
	list-style-type: disc;
	padding-left: 20px;
	margin-top: 10px;
}

.order ul li {
	color: #444;
	font-size: 13px;
	margin-bottom: 4px;
}

.refund-controller {
	display: flex;
	justify-content: space-between;
	flex-direction: row;
}

/* 교환/환불 버튼 */
.refund-btn {
	display: inline-block;
	padding: 6px 12px;
	background-color: #ff5757;
	color: white;
	font-size: 13px;
	font-weight: 500;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

.refund-btn:hover {
	background-color: #e64545;
}

/* 환불 불가 표시 */
.refundunable {
	display: inline-block;
	padding: 6px 12px;
	background-color: #ccc;
	color: #555;
	font-size: 13px;
	border-radius: 4px;
}

#load-more-btn {
	display: block;
	margin: 20px auto;
	padding: 10px 24px;
	font-size: 14px;
	cursor: pointer;
	border-radius: 5px;
	border: none;
	background-color: #007bff;
	color: white;
	transition: background-color 0.3s ease;
}

#load-more-btn:hover {
	background-color: #0056b3;
}

@media screen and (max-width: 600px) {
	.refund-controller {
		display: flex;
		/* justify-content: space-between; */
		flex-direction: column;
	}
}
</style>

<c:forEach var="orderWrapper" items="${orderList}">
	<div class="order">
		<h3>주문번호: ${orderWrapper.orderInfoId}</h3>
		<p>주문자명: ${orderWrapper.person.name}</p>
		<p>이메일: ${orderWrapper.person.email}</p>
		<p>전화: ${orderWrapper.person.phone}</p>

		<h4>상품 목록:</h4>
		<ul>
			<c:forEach var="item" items="${orderWrapper.items}">
				<li>${item.productName}(수량:${item.quantity},단가:
					${item.pricePerUnit}원)</li>
			</c:forEach>
		</ul>
		<c:if test="${not empty orderWrapper.pay}">
			<h4>결제 정보:</h4>

			<ul>
				<li class="refund-controller">
					<div>결제수단: ${orderWrapper.pay.paymentMethod}, 결제번호:
						${orderWrapper.pay.paymentNumber}, 결제일:
						${orderWrapper.pay.paymentDate}, 금액: ${orderWrapper.pay.amount}원</div>
					<div>
						<c:if test="${not empty orderWrapper.refund}">
							<h4>
								환불 상태:
								<c:choose>
									<c:when test="${orderWrapper.refund.status == 'REQUESTED'}">환불 요청이 접수되었어요</c:when>
									<c:when test="${orderWrapper.refund.status == 'APPROVED'}">환불이 승인되었습니다</c:when>
									<c:when test="${orderWrapper.refund.status == 'REJECTED'}">죄송합니다. 환불이 거부되었습니다</c:when>
									<c:when test="${orderWrapper.refund.status == 'COMPLETED'}">환불이 완료되었습니다</c:when>
									<c:when test="${orderWrapper.refund.status == 'CANCELLED'}">환불 요청이 취소되었습니다</c:when>
									<c:otherwise>환불 상태를 확인해주세요</c:otherwise>
								</c:choose>
							</h4>
							<ul>
	 							<li>환불 요청일: ${orderWrapper.refund.requestedAt}</li>
								<li>환불 금액: ${orderWrapper.refund.refundedAmount}원</li>
								<li>환불 사유: ${orderWrapper.refund.reason}</li>
							</ul>
						</c:if>




						<c:if test="${empty orderWrapper.refund and orderWrapper.order_status_id ne 6}">

							<c:if test="${orderWrapper.pay.refundable}">
								<span class='refund-btn' data-paymentid="${orderWrapper.pay.paymentId}"
      data-amount="${orderWrapper.pay.amount}"
      data-orderid="${orderWrapper.orderInfoId}">교환/환불</span>
							</c:if>
							<c:if test="${not orderWrapper.pay.refundable}">
								<span class='refundunable'>교환/환불 불가</span>
							</c:if>
						</c:if>
						
						
						<c:if test="${orderWrapper.order_status_id eq 6}">							
							
								<span class='refundunable'>재고부족 으로 인한 자동 환불처리가 되었습니다.</span>
						
						</c:if>

					</div>

				</li>



			</ul>
		</c:if>
	</div>
	<hr />
</c:forEach>


<c:if test="${hasNext}">
	<button id="load-more-btn">더보기</button>
</c:if>

