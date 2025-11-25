<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 월 등록</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet"
    href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
    type="text/css" />

<style>
html, body {
    height: 100%;
    margin: 0;
    font-family: 'Roboto', sans-serif;
}

#pageWrapper {
    display: flex;
    height: 100vh;
}

#sidebar {
    width: 240px;
    border-right: 1px solid #e0e0e0;
    overflow-y: auto;
}

#mainContent {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
}

#contentHeader {
    padding: 20px 24px;
    background-color: #f5f7fa;
    border-left: 6px solid #4a90e2;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.08);
    margin-bottom: 20px;
}

#contentHeader h1 {
    margin: 0;
    font-size: 1.8em;
    font-weight: 700;
    color: #333;
}

#contentHeader .header-subtitle {
    margin: 6px 0 0 0;
    font-size: 0.95em;
    color: #666;
}


#contentBody {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    min-height: 400px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

/* 월별 카드 UI */
#monthContainer {
    display: flex;
    gap: 16px;
    flex-wrap: wrap;
    margin-top: 20px;
}

.monthCard {
    width: 120px;
    height: 100px;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
    text-align: center;
}

.monthCard:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.monthCard.alreadyOpen {
    background-color: #f0f7ff;
    border: 1px solid #2196f3;
    color: #2196f3;
}

.monthCard.possibleOpen {
    background-color: #f9f9f9;
    border: 1px dashed #ccc;
    color: #555;
}

.monthTitle {
    font-size: 1.2em;
    font-weight: bold;
    margin-bottom: 8px;
}

.monthStatus {
    font-size: 0.9em;
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";

window.onload = function() {    
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        }
    });  
    
   
    $(".monthCard.alreadyOpen").on("click", function() {
      
    	let selectedDate = $(this).data("alreadyopen");
    	console.log("selectedDate: " + selectedDate);
    	
       	// 동적으로 폼 생성
        let form = $('<form action="' + contextPath + '/teacher/teacher-manage-onedayclass-schedule" method="get">' +
                   
                     '<input type="hidden" name="date" value="' + selectedDate + '">' +
                     '</form>');

        // 폼 body에 추가 후 제출
        $('body').append(form);
        form.submit(); 
    });

    
    
    
    
    
}
</script>

</head>
<body>
<div id="pageWrapper">
    <!-- 좌측 수직 메뉴 -->
    <div id="sidebar">
        <%@ include file="../compoents/teacherVerticalBar/teacherVerticalBar.jsp"%>
    </div>

    <!-- 우측 메인 콘텐츠 -->
    <div id="mainContent">
    <div id="contentHeader">
    <h1>수업 월 등록</h1>
    <p class="header-subtitle">현재 년 월 기준으로 당해년도 12월까지 등록 가능합니다.</p>
</div>

 
        <div id="contentBody">
            <div id="monthContainer">
                <c:forEach var="month" items="${monthList}">
                    <div class="monthCard ${month.status}" data-alreadyopen="${month.yyyyMM}">
                    
                        <div class="monthTitle">
                            <c:out value="${fn:substring(month.displayText,0,2)}"/>월
                        </div>
                        <div class="monthStatus">
                            <c:out value="${month.status == 'alreadyOpen' ? '수업 관리' : '수업 추가'}"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>



<!-- 모달 구조 -->
<div id="addClassModal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>

        <div class="modal-header">
            <h2 id="modalTitle">수업 추가</h2>
            <p class="modal-subtitle">적어도 하나의 개강일을 선택해주세요.</p>
        </div>

        <!-- 안내 문구 -->
        <div class="info-box">
            <p>
                수업 정원은 처음 수업 정보를 등록할 때 입력한 내용이 기본으로 적용됩니다.<br>
                이후 필요하실 경우, <strong>상세관리 페이지</strong>에서 언제든 수정하실 수 있습니다.
            </p>
        </div>

        <form id="addClassForm" method="post" action="${pageContext.request.contextPath}/api/teacher/addClass">
            <label for="dateSelect">개강일 선택:</label>
            <div class="date-select-group">
                <select id="dateSelect"></select>
                <button type="button" id="addDateBtn" class="btn-secondary">추가</button>
            </div>

            <div id="selectedDatesContainer"></div>

            <input type="hidden" id="openday" name="openday" required>

            <button type="button" id="submitClassBtn" class="btn-primary">등록</button>
        </form>
    </div>
</div>

<style>
/* 기본 모달 스타일 */
.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0; top: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.5);
}

/* 모달 콘텐츠 */
.modal-content {
  position: relative;
  background: #fff;
  margin: 8% auto;
  padding: 25px 30px 30px;
  border-radius: 10px;
  width: 420px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.25);
  text-align: center;
  animation: fadeIn 0.3s ease;
}

/* 헤더 */
.modal-header h2 {
  margin: 0;
  font-size: 1.6em;
  color: #333;
}

.modal-header .modal-subtitle {
  margin: 6px 0 18px 0;
  font-size: 0.95em;
  color: #666;
}

/* 닫기 버튼 */
.close-btn {
  position: absolute;
  top: 12px; right: 16px;
  font-size: 22px;
  font-weight: bold;
  color: #999;
  cursor: pointer;
  transition: color 0.2s;
}
.close-btn:hover { color: #333; }

/* 안내 문구 박스 */
.info-box {
  background: #f9fafb;
  border-left: 4px solid #2196f3;
  border-radius: 6px;
  padding: 10px 14px;
  text-align: left;
  margin-bottom: 15px;
}
.info-box p {
  font-size: 0.9em;
  color: #555;
  line-height: 1.5;
  margin: 0;
}

/* 날짜 선택 영역 */
.date-select-group {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
}

/* 선택된 날짜 표시 */
#selectedDatesContainer {
  margin-top: 10px;
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  justify-content: center;
}
.selected-date {
  background: #f0f7ff;
  color: #2196f3;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 0.9em;
}

/* 버튼 스타일 */
.btn-primary {
  background: #2196f3;
  color: #fff;
  border: none;
  padding: 8px 14px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 0.95em;
  margin-top: 14px;
  transition: background 0.2s;
}
.btn-primary:hover { background: #1976d2; }

.btn-secondary {
  background: #e0e7ff;
  color: #334;
  border: none;
  padding: 6px 10px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9em;
  transition: background 0.2s;
}
.btn-secondary:hover { background: #c7d2fe; }

/* 모션 */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>


<sec:authentication property="principal" var="user" />
<script>
var onedayclass_num = "${user.myOneDayClassInfo.onedayclass_num}";

console.log(onedayclass_num);



let monthDates = {}; // 각 월별 전체 날짜 배열 캐시
let selectedDates = []; // 현재 모달에서 선택된 날짜
let originalSelectedDates = []; // 모달 열기 전 복사본

$(document).ready(function() {
    const modal = $("#addClassModal");
    const span = $(".close-btn");

    // 모달 닫기
    span.on("click", function() { modal.hide(); });
    $(window).on("click", function(event){ if($(event.target).is(modal)) modal.hide(); });

    // 각 월 카드 클릭 시
    $(".monthCard.possibleOpen").on("click", function() {
        const yyyyMM = $(this).data("alreadyopen"); // "2025-12"
        const [yearStr, monthStr] = yyyyMM.split("-");
        const year = parseInt(yearStr);
        const month = parseInt(monthStr) - 1;

        // 월별 날짜 배열 캐싱
        if(!monthDates[yyyyMM]) {
            const lastDay = new Date(year, month + 1, 0).getDate();
            let arr = [];
            for(let d=1; d<=lastDay; d++){
                const dayStr = d < 10 ? "0"+d : ""+d;
                arr.push(yearStr + "-" + monthStr + "-" + dayStr);
            }
            monthDates[yyyyMM] = arr;
        }

        // 모달 제목 업데이트
        $("#modalTitle").text(parseInt(monthStr) + "월 수업 추가");

        // 선택 초기화
        originalSelectedDates = [...selectedDates]; // 모달 열기 전 복사
        renderSelectOptions(yyyyMM);
        renderSelectedDates();

        modal.show();
    });

    // 선택 날짜 추가 버튼
    $("#addDateBtn").on("click", function(){
        const date = $("#dateSelect").val();
        if(date && !selectedDates.includes(date)){
            selectedDates.push(date);
            renderSelectedDates();
        }
    });

    // 렌더링 함수: 드롭다운
    function renderSelectOptions(yyyyMM){
        const select = $("#dateSelect");
        select.empty();
        monthDates[yyyyMM].forEach(date => {
            if(!selectedDates.includes(date)){
                select.append('<option value="'+date+'">'+date+'</option>');
            }
        });
    }

    // 렌더링 함수: 선택된 날짜 표시
    function renderSelectedDates(){
        const container = $("#selectedDatesContainer");
        container.empty();
        selectedDates.forEach(date => {
            container.append('<span class="selected-date">'+date+' <button type="button" class="remove-date" data-date="'+date+'">x</button></span>');
        });
        $("#openday").val(selectedDates.join(","));
    }

    // 선택된 날짜 삭제
    $("#selectedDatesContainer").on("click", ".remove-date", function(){
        const date = $(this).data("date");
        selectedDates = selectedDates.filter(d => d !== date);
        renderSelectedDates();
    });
    
    
    
    
    
    // 모달 내 등록 버튼 클릭 시 Ajax 요청
    $("#submitClassBtn").on("click", function() {
        const selectedDays = $("#openday").val();
        if(!selectedDays){
            alert("하나 이상의 개강일을 선택해주세요.");
            return;
        }

     
        
        
        $.ajax({
            url: contextPath + "/api/teacher/open-month-onedyaclass",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                onedayclass_num: onedayclass_num,
                openday: selectedDates  // 배열 그대로
            }),
            success: function(response) {
                alert("수업이 성공적으로 등록되었습니다!");
                location.reload();
                
            },
            error: function(xhr, status, error) {
                alert("등록 중 오류가 발생했습니다: " + xhr.responseText);
            }
        });

 
        
 
 
        
    });
    

});
</script>




</body>
</html>

