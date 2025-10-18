<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>




<script>
// delegated event: 동적 생성 버튼에 클릭 이벤트 연결
$('#order-list-container').on('click', '#load-more-btn', function() {
    loadOrders();
});

</script>
<h1>결제 정보 (최근 6개월 주문 내역)</h1>

<div id="order-list-container">
    <!-- 여기다가 주문 목록과 '더보기' 버튼이 조각으로 붙음 -->
</div>

