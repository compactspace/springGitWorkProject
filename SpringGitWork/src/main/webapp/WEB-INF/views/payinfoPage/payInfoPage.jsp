<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
   <sec:csrfMetaTags />
<html>
<head>
    <title>결제 정보 페이지</title>

    <!-- ✅ CSRF 메타 태그 추가 -->
    <sec:csrfMetaTags />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            }
        });
    </script>
</head>

<body>

<h1>결제 정보 (최근 6개월 주문 내역)</h1>

<div id="order-list-container">
    <!-- 여기다가 주문 목록과 '더보기' 버튼이 조각으로 붙음 -->
</div>

<script>
    let offset = 0;
    const limit = 10;

    // 버튼 클릭 이벤트는 동적 생성되니 delegated event 사용
    $(document).ready(function() {
    	
        function loadOrders() {
            $.ajax({
            	url: "${pageContext.request.contextPath}/users/listMore",
                data: {offset: offset, limit: limit},
                type: 'GET',
                
                success: function(data) {
                	
                	
                	console.log(data)
                    // 기존 버튼 제거 (중복 방지)
                    $('#load-more-btn').remove();

                    // 받은 조각 HTML 붙임
                    $('#order-list-container').append(data);

                    // offset 업데이트
                    offset += limit;
                },
                error: function(e) {
                	console.log(e)
                    alert('주문 목록을 불러오는 데 실패했습니다.');
                }
            });
        }

        // 초기 로드
        loadOrders();

        // delegated event: 동적 생성 버튼에 클릭 이벤트 연결
        $('#order-list-container').on('click', '#load-more-btn', function() {
            loadOrders();
        });
    });
</script>

</body>
</html>
