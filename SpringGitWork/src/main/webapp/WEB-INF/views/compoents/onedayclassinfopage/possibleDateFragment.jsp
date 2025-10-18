<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .date-list {
        max-width: 480px;
        margin: 20px auto;
    }

    .date-list h3 {
        font-size: 1.3rem;
        color: #333;
        text-align: center;
        margin-bottom: 12px;
    }

    .date-items-wrapper {
        display: flex;
        overflow-x: auto;
        gap: 12px;
        padding-bottom: 10px;
        height: 113px;
        scrollbar-width: thin;
        scrollbar-color: #999 #eee;
    }

    .date-items-wrapper::-webkit-scrollbar {
        height: 6px;
    }

    .date-items-wrapper::-webkit-scrollbar-thumb {
        background-color: #999;
        border-radius: 3px;
    }

    .date-items-wrapper::-webkit-scrollbar-track {
        background-color: #eee;
    }

    .date-item {
        height: 70px;
        flex: 0 0 auto;
        background: #fff;
        padding: 14px 18px;
        border-radius: 10px;
        box-shadow: 0 1px 5px rgba(0,0,0,0.1);
        font-size: 1rem;
        color: #222;
        cursor: pointer;
        white-space: nowrap;
        transition: background-color 0.3s, box-shadow 0.3s;
        min-width: 140px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        position: relative;
    }

    .date-item:hover {
        background-color: #dbe9ff;
        box-shadow: 0 4px 12px rgba(0, 100, 255, 0.2);
    }

    .date-info {
        display: flex;
        justify-content: space-between;
        width: 100%;
    }

    .reservation-info {
        margin-top: 4px;
    }

    .reserved-text {
        color: red;
        font-size: 0.85rem;
        font-weight: bold;
    }
</style>

<div class="date-list">
    <c:choose>
        <c:when test="${not empty filteredList}">
            <c:set var="firstDate" value="${filteredList[0].openday}" />
            <fmt:parseDate var="parsedDate" value="${firstDate}" pattern="yyyy-MM-dd" />
            <fmt:formatDate var="year" value="${parsedDate}" pattern="yyyy" />
            <fmt:formatDate var="month" value="${parsedDate}" pattern="MM" />

            <h3>${year}년 ${month}월 예약 가능한 날짜</h3>

            <div class="date-items-wrapper">
                <c:forEach var="dateObj" items="${filteredList}">
                    <fmt:parseDate var="parsedDate" value="${dateObj.openday}" pattern="yyyy-MM-dd" />
                    <fmt:formatDate var="formattedDate" value="${parsedDate}" pattern="MM.dd" />
                    <fmt:formatDate var="dayOfWeek" value="${parsedDate}" pattern="E" />

                    <div class="date-item <c:if test='${dateObj.reserved}'>reserved</c:if>'"
                         data-reserved="${dateObj.reserved}">
                        <div class="date-info">
                            <span>${formattedDate} (${dayOfWeek})</span>
                            <span>(<c:out value="${dateObj.rest}" />명)</span>
                        </div>
                        <div class="reservation-info">
                            <c:if test="${dateObj.reserved}">
                                <div class="reserved-text">이미 예약하신 날입니다</div>
                            </c:if>
                        </div>
                        <input type="hidden" name="selectedDate" value="${dateObj.openday}" />
                        <input type="hidden" name="reservationDate" value="${formattedDate} (${dayOfWeek})" />
                        <input type="hidden" name="id" value="${dateObj.id}" />
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <h3 data-soldout="true">이번 달은 수업이 진행되지 않습니다</h3>
            <div style="text-align: center; padding: 30px 20px; color: #666; font-size: 0.95rem; background: #f9f9f9; border-radius: 10px; box-shadow: 0 1px 5px rgba(0,0,0,0.05);">
                선생님의 사정으로 인해 <strong>이번 달 수업은 잠시 쉬어갑니다.</strong><br />
                다음 수업 일정은 추후 공지드릴 예정입니다.<br />
                너른 양해 부탁드립니다.
            </div>
        </c:otherwise>
    </c:choose>
</div>

