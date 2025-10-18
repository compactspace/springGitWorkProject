<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약내역</title>

    <!-- jQuery & jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

    <!-- 구글 폰트 (선택사항) -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
    #reserveDetail {
        font-family: 'Noto Sans KR', sans-serif;
        max-width: 450px;       
    }
    #reserveDetail h3 {
        margin-bottom: 15px;
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 8px;
    }
    #reserveDetail img {
        width: 100%;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    #reserveDetail .info-item {
        display: flex;
        margin-bottom: 12px;
    }
    #reserveDetail .info-item strong {
        width: 90px;
        color: #3498db;
    }
    #reserveDetail .info-item span {
        flex: 1;
        color: #555;
    }
    
    
    /* 예약자 정보 구분 헤더 */
.section-header {
    margin-top: 25px;
    margin-bottom: 12px;
    font-weight: 700;
    font-size: 18px;
    color: #2980b9;
    border-bottom: 1.5px solid #2980b9;
    padding-bottom: 6px;
}
    
    .refund-policy {
    margin-top: 30px;
    padding: 15px 20px;
    background-color: #f8f9fa;
    border-left: 4px solid #e74c3c;
    font-size: 14px;
    color: #555;
    line-height: 1.5;
    border-radius: 4px;
}
.refund-policy strong {
    color: #e74c3c;
}
    
    
    
</style>
    <script>
        $(document).ready(function() {
        	
        	

        	fetchMyReserve();
            // 모달 초기화
            $("#reserveModal").dialog({
                autoOpen: false,
                modal: true,
                width: 450,
                buttons: {
                    "닫기": function () {
                        $(this).dialog("close");
                    }
                }
            });          
       
        });
        
        
        
        function fetchMyReserve(offset=0){
            $.ajax({
                url:"${pageContext.request.contextPath}/users/get-my-reserve-fragment?offset="+offset,
                type:"GET",
              
                success:(res)=>{
                    $(".myreserve-morefrgment").html(res);

                    fragmentLevelEventResister();

                    // reserve-item 이벤트 등록
                    $(".reserve-item").off("click").on("click", function () {
                        const name = $(this).data("name");
                        const phone = $(this).data("phone");
                        const email = $(this).data("email");
                        const info = $(this).data("info");
                        const playtime = $(this).data("playtime");
                        const maxGuests = $(this).data("maximum-guests");
                        const address = $(this).data("address");
                        const date = $(this).data("selected-date");
                        const paymentMethod = $(this).data("payment-method");
                        const price = $(this).data("price");
                        const img = $(this).data("reserve-img");
                        const title = $(this).find('.title').text();   
                        
                        var refundPolicy = 
                            "<div class='refund-policy'>" +
                                "<strong>환불규정 안내</strong><br>" +
                                "• 예약 취소는 수업 시작 3일 전까지 가능하며, 전액 환불됩니다.<br>" +
                                "• 수업 시작 2일 전부터는 50% 환불됩니다.<br>" +
                                "• 당일 취소 및 노쇼는 환불이 불가합니다.<br>" +
                                "• 환불 관련 문의는 고객센터로 연락해 주세요." +
                            "</div>";

                        var content = 
                            "<div id='reserveDetail'>" +
                                "<h3>" + title + " 예약 상세정보</h3>" +
                                "<img src='" + "${pageContext.request.contextPath}/resources/" + img + "' alt='수업 이미지' />" +

                                "<div class='info-item'><strong>설명:</strong><span>" + info + "</span></div>" +
                                "<div class='info-item'><strong>수업시간:</strong><span>" + playtime + "</span></div>" +
                                "<div class='info-item'><strong>최대 인원:</strong><span>" + maxGuests + "</span></div>" +
                                "<div class='info-item'><strong>주소:</strong><span>" + address + "</span></div>" +

                                "<div class='section-header'>예약자 정보</div>" +
                                "<div class='info-item'><strong>이름:</strong><span>" + name + "</span></div>" +
                                "<div class='info-item'><strong>전화번호:</strong><span>" + phone + "</span></div>" +
                                "<div class='info-item'><strong>이메일:</strong><span>" + email + "</span></div>" +

                                "<div class='info-item'><strong>예약일:</strong><span>" + date + "</span></div>" +
                                "<div class='info-item'><strong>결제금액:</strong><span>" + price + "원</span></div>" +
                                "<div class='info-item'><strong>결제수단:</strong><span>" + paymentMethod + "</span></div>" +

                                refundPolicy +  // 환불규정 추가

                            "</div>";




                        $("#reserveModal").html(content).dialog("open");
                    });

                },
                err:()=>{
                    alert("예약내역을 불러오는 데 실패했습니다.");
                }
            });
        }

  

        
        function topLevelPageEventResister(){          	
        	
        	
        }
        
        function fragmentLevelEventResister() {
            $(".next-page").on("click", function() {
                let offset = $(this).closest(".next-page-btn").data("offset");
                alert("다음 페이지 클릭됨! offset=" + offset);  
                
                fragmentLevelEventRemove();
                fetchMyReserve(offset);  // 여기서 다시 데이터 불러오기
            });
        }

        

        function fragmentLevelEventRemove() {
            $(".next-page").off("click");
            $(".next-page").empty();  // 해당 div 내부 HTML 제거 (비우기)
        }
        
    </script>
</head>

<body>



    <div class="myreserve-morefrgment"></div>

    <!-- 모달 -->
    <div id="reserveModal" title="예약 상세 정보" style="display: none;"></div>

</body>
</html>