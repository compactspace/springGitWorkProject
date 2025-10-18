<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.order {
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 16px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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


</style>

<c:forEach var="orderWrapper" items="${orderList}">
    <div class="order">
        <h3>주문번호: ${orderWrapper.order.orderInfoId}</h3>
        <p>주문자명: ${orderWrapper.order.person.name}</p>
        <p>이메일: ${orderWrapper.order.person.email}</p>
        <p>전화: ${orderWrapper.order.person.phone}</p>

        <ul>
            <c:forEach var="item" items="${orderWrapper.order.items}">
                <li>${item.productName} (수량: ${item.quantity}, 단가: ${item.pricePerUnit}원)</li>
            </c:forEach>
        </ul>
    </div>
    <hr/>
</c:forEach>


<c:if test="${hasNext}">
    <button id="load-more-btn">더보기</button>
</c:if>
