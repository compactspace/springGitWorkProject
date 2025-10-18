<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f9f9f9;
        margin: 30px;
        color: #333;
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #2c3e50;
        font-weight: 700;
        letter-spacing: 1px;
    }

    .reserve-item {
        cursor: pointer;
        margin: 12px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 12px;
        background-color: #fff;
        max-width: 650px;
        box-shadow: 0 3px 7px rgba(0,0,0,0.1);
        display: flex;
        gap: 20px;
        transition: background-color 0.3s, transform 0.15s;
        align-items: center;
    }

    .reserve-item:hover {
        background-color: #eaf4ff;
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(52,152,219,0.3);
    }

    .reserve-img {
        flex-shrink: 0;
        width: 120px;
        height: 90px;
        border-radius: 8px;
        object-fit: cover;
        border: 1px solid #ccc;
    }

    .reserve-info {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
       
    }

    .reserve-info span {
        font-size: 15px;
        color: #555;
    }

    .reserve-info .title {
        font-weight: 600;
        font-size: 18px;
        color: #2c3e50;
        margin-bottom: 4px;
    }

    .reserve-info .detail {
        font-size: 14px;
        color: #777;
        margin-top: 2px;
    }

    .price {
        font-weight: 700;
        color: #2980b9;
        font-size: 16px;
    }

    .next-page {
        text-align: center;
        margin-top: 30px;
    }

    .next-page button {
        background-color: #3498db;
        color: white;
        border: none;
        padding: 12px 28px;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .next-page button:hover {
        background-color: #2980b9;
    }
</style>

<h2>최근 6개월 이내 예약 내역</h2>


<c:forEach var="reserve" items="${reserveList}">
    <div class="reserve-item" 
        data-applicant-id="${reserve.applicant_id}"
        data-name="${reserve.name}"
        data-phone="${reserve.phone}"
        data-email="${reserve.email}"
        data-price="${reserve.price}"
        data-selected-date="<fmt:formatDate value='${reserve.selectedDate}' pattern='yyyy년 MM월 dd일' />"
        data-payment-method="${reserve.payment_method}"
        data-info="${reserve.onedayclass_info}"
        data-playtime="${reserve.playtime}"
        data-maximum-guests="${reserve.maximum_guests}"
        data-address="${reserve.address}"
        data-reserve-img="${reserve.reserve_img}">
        <img class="reserve-img" src="${pageContext.request.contextPath}/resources/${reserve.reserve_img}" alt="수업 이미지" />
        
        <div class="reserve-info">
            <span class="title">${reserve.onedayclass_name}</span>
            <span><strong>예약번호:</strong> ${reserve.reserve_payment_id}</span>
            <span><strong>예약일:</strong> <fmt:formatDate value="${reserve.selectedDate}" pattern="yyyy년 MM월 dd일" /></span>
            <span><strong>결제금액:</strong> <span class="price">${reserve.price}원</span></span>
            <span class="detail"><strong>수업시간:</strong> ${reserve.playtime} / <strong>최대인원:</strong> ${reserve.maximum_guests}</span>
        </div>
    </div>
</c:forEach>

<c:if test="${hasNext}">
    <div class="next-page">
        <button class="next-page-btn" data-offset="${offset}">다음 페이지</button>
    </div>
</c:if>
