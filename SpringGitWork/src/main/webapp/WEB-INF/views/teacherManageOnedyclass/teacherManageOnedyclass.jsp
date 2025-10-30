
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
html, body {
	height: 100%;
	margin: 0;
	font-family: 'Roboto', sans-serif;
}

#pageWrapper {
	display: flex;
	height: 100vh; /* 화면 전체 높이 */
}

/* 좌측 메뉴 */
#sidebar {
	width: 240px; /* teacherVerticalBar.jsp와 동일 */
	border-right: 1px solid #e0e0e0;
	overflow-y: auto;
}

/* 우측 콘텐츠 */
#mainContent {
	flex: 1; /* 나머지 영역 차지 */
	padding: 24px;
	overflow-y: auto;
}

#contentHeader {
	margin-bottom: 20px;
	border-bottom: 1px solid #ddd;
	padding-bottom: 12px;
}

#contentHeader h1 {
	margin: 0;
	font-size: 1.6em;
	color: #333;
}

#contentBody {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	min-height: 400px; /* 기본 높이 */
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}


/*현재 개강이 등록된 벌 셀렉트 시작 */
.month-control-bar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 12px;
	padding: 8px 12px;
	background-color: #f8f9fb;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.month-select-wrap {
	display: flex;
	align-items: center;
	gap: 8px;
}

.month-label {
	font-weight: 600;
	color: #333;
	font-size: 0.9em;
}

.active-month-select {
	padding: 6px 10px;
	border-radius: 4px;
	border: 1px solid #ccc;
	font-size: 0.9em;
}

.add-btn {
	background-color: #2a7ae2;
	color: #fff;
	border: none;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.9em;
	transition: background-color 0.2s;
}
.add-btn:hover {
	background-color: #1e5bb8;
}

/*현재 개강이 등록된 벌 셀렉트 종료 */




/* 달력 시작 */
.calendar-wrapper {
    display: grid;
    grid-template-columns: repeat(7, 1fr); /* 7일 기준 */
    gap: 8px;
    padding: 10px;
    background-color: #f5f5f5;
    border-radius: 8px;
}

/* 각 날짜 박스 */
.calendar-day {
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 8px;
    font-family: Arial, sans-serif;
    font-size: 0.85em;
    min-height: 80px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}

/* 첫 번째 행: 관리 상태 */
.calendar-day .manageStatus {
    font-weight: bold;
    color: #2a7ae2;
    margin-bottom: 4px;
}

/* 두 번째 행: 오픈 날짜 */
.calendar-day .openday {
    color: #333;
    margin-bottom: 4px;
}

/* 세 번째 행: 휴무/기타 */
.calendar-day .rest {
    color: #e74c3c;
}

/* 개강 중인 월 버튼 (예: pagination) */
.active-month {
    display: inline-block;
    padding: 4px 8px;
    margin: 2px;
    background-color: #2a7ae2;
    color: #fff;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85em;
    transition: background-color 0.2s;
}

.active-month:hover {
    background-color: #1e5bb8;
}



/* 4행 버튼 영역 */
.calendar-actions {
    display: flex;
    justify-content: space-between; /* 좌/우 분리 */
    margin-top: 6px;
}

/* 버튼 기본 스타일 */
.calendar-actions .btn-close,
.calendar-actions .btn-edit {
    flex: 1; /* 균등 배분 */
    margin: 0 2px; 
    padding: 4px 6px;
    font-size: 0.8em;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    color: #fff;
    transition: background-color 0.2s;
}


/* 마감하기 버튼 */
.btn-close {
    background-color: #e74c3c;
}
.btn-close:hover {
    background-color: #c0392b;
}

/* 인원수정 버튼 */
.btn-edit {
    background-color: #3498db;
}
.btn-edit:hover {
    background-color: #2980b9;
}


/* 달력 종료 */




/* 모달 시작  */
.modal-overlay {
	position: fixed;
	top: 0; left: 0;
	width: 100%; height: 100%;
	background: rgba(0, 0, 0, 0.4);
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 999;
}

/* 모달 박스 */
.modal-box {
	background: #fff;
	padding: 20px;
	border-radius: 10px;
	width: 320px;
	box-shadow: 0 2px 6px rgba(0,0,0,0.2);
	display: flex;
	flex-direction: column;
	gap: 12px;
	font-family: 'Roboto', sans-serif;
}

/* 1행: 헤더 */
.modal-header h3 {
	margin: 0;
	font-size: 1.2em;
	color: #2a7ae2;
	text-align: center;
}

/* 2행: 셀렉트 */
.modal-select label {
	display: block;
	margin-bottom: 4px;
	color: #333;
	font-size: 0.9em;
}
.select-openday {
	width: 100%;
	padding: 6px;
	border-radius: 4px;
	border: 1px solid #ccc;
	font-size: 0.9em;
}

/* 3행: 남은자리 입력 */
.modal-rest label {
	display: block;
	margin-bottom: 4px;
	color: #333;
	font-size: 0.9em;
}
.rest-field {
	width: 100%;
	padding: 6px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 0.9em;
}

/* 4행: 버튼 */
.modal-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	margin-top: 10px;
}
.btn-confirm, .btn-cancel {
	padding: 6px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.9em;
}
.btn-confirm {
	background-color: #2a7ae2;
	color: #fff;
}
.btn-confirm:hover {
	background-color: #1e5bb8;
}
.btn-cancel {
	background-color: #ccc;
	color: #333;
}
.btn-cancel:hover {
	background-color: #aaa;
}
/* 모달 종료 */




.null-error {
	display: inline-block;
	margin-top: 4px;
	color: #e74c3c;
	font-size: 0.8em;
}



</style>
<script>

const contextPath="${pageContext.request.contextPath}";
let activeMonthLists=null;
let activeMonthOnedayClassList=null;
var remainingDates 
let changeMonth=null

window.onload= async function(){	
	
	 const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });  
	  
	  
	  
	await  getActiveOnedayclassList().then(function(){	
		
		// 1️⃣ 첫 번째 자식: 상단 컨트롤바
	$("#contentBody").prepend(createPagiNationButtonHTMLTag(activeMonthLists, activeMonthOnedayClassList));
	   eventResister();
		
		 $(".active-month-select").on("change", function() {
		        var  yearMonth = $(this).val();  // 선택된 값 가져오기
		        changeMonth=yearMonth;
		       
		        
		        getActiveOnedayclassListFNC( yearMonth);
		        
		        
		    });	

	
	});
	
	
	  
}







 async function getActiveOnedayclassListFNC(yearMonth){

	 
	 

	 await getActiveOnedayclassList(yearMonth).then(function(){	
			
			// 1️⃣ 첫 번째 자식: 상단 컨트롤바
		$("#contentBody").prepend(createPagiNationButtonHTMLTag(activeMonthLists, activeMonthOnedayClassList));
		   eventResister();
			
			 $(".active-month-select").on("change", function() {
			        var  yearMonth = $(this).val();  // 선택된 값 가져오기    
			        changeMonth=yearMonth;
			        getActiveOnedayclassListFNC( yearMonth);
			        
			        
			    });
		
		
		});
	
}
 
 
 
 

async function getActiveOnedayclassList(yearMonth) {
    if (!yearMonth) yearMonth = todayYyyyMmFormatted();

    return new Promise((resolve, reject) => {
        $.ajax({
            url: contextPath + "/api/teacher/get-my-activeonedayclass",
            type: "GET",
            data: { yearMonth },
            success: function(res) {
                const { activeMonthList, list } = res;

                activeMonthLists = activeMonthList;
                activeMonthOnedayClassList = list;

                $(".month-control-bar").remove();
                
               
                // 기존 내용 초기화
                $(".calendar-wrapper").remove();

                // 달력 추가
                $("#contentBody").append(createCalendarHTMLTag(list));

                removeEventRegister();
             

                
                resolve(res); // Promise 성공 처리
            },
            error: function(err) {
                reject(err); // Promise 실패 처리
            }
        });
    });
}




function createCalendarHTMLTag(list){
    var html = '<div class="calendar-wrapper">';
    // 오늘 이후 남은 날짜 배열
   /*  var remainingDates = addCrrentPossible(); // ["2025-10-28", "2025-10-29", ...]
 */
 
    // 최상위 컨테이너
    var html = '<div class="calendar-container" style="display:flex; flex-direction:column; gap:10px;">';

    
    // 상단: 개강날짜 추가 버튼 or 종료 메시지
/*     if (remainingDates.length > 0) {
        html += '<div class="add-start-class" style="text-align:right;">';
        html += '<button class="add-btn">개강날짜 추가</button>';
        html += '</div>';
    } else {
        html += '<div class="all-classes-finished" style="text-align:center; color:gray;">';
        html += '해당월의 모든 수업이 종료되었습니다.';
        html += '</div>';
    }  */
    
    

    // 달력-wrapper
    html += '<div class="calendar-wrapper">';    
    let i=0;
    list.forEach(function(item){
    	
        var dateStr = formatted(item.openday); // timestamp에서 YYYY-MM-DD
        let isClose=item.manageStatus?  '진행중' : '수업종료';
        let 진행중이니=item.manageStatus;       
        
        html += '<div class="calendar-day" data-position="'+i+'">';
        html += '<div class="manageStatus">' + isClose + '</div>';
        html += '<div class="openday">개강날짜: ' + dateStr + '</div>';
        html += '<div class="rest">남은자리: ' + item.rest + '</div>';
     // 4행: 2열 버튼
        html += '<div class="calendar-actions">';
        html += '<button class="btn-close" data-isactive="' + 진행중이니 + '">마감하기</button>';
        html += '<button class="btn-edit" data-isactive="' + 진행중이니 + '">인원수정</button>';
        html += '</div>';
        html += '</div>'; // calendar-day
        i++;
    });

    html += '</div>'; // calendar-wrapper
    return html;
}






function createPagiNationButtonHTMLTag(activeMonthList, list) {
    var html = "";
    html += '<div class="month-control-bar">';
    html += '  <div class="month-select-wrap">';
    html += '    <label for="active-month-select" class="month-label">현재 개강 월</label>';
    html += '    <select id="active-month-select" class="active-month-select">';

    console.log(activeMonthList)
    
    activeMonthList.forEach(function(item){
        var regMonth = item.reg_month; // 예: 2025-10
        console.log(regMonth);
        
        var month = regMonth.split("-")[1];

        // changeMonth가 정의되어 있고 현재 옵션과 같으면 selected
        if (typeof changeMonth !== "undefined" && changeMonth === regMonth) {
            html += '      <option value="' + regMonth + '" selected>' + month + '월</option>';
        } else {
            html += '      <option value="' + regMonth + '">' + month + '월</option>';
        }
    });

    html += '    </select>';
    html += '  </div>'; // month-select-wrap 닫기

    let futureYyyyMmFormat = undefined;
    if (list.length > 0) {
        const timeStamp = list[0].openday;
        const dateStr = formatted(timeStamp); // YYYY-MM-DD
        futureYyyyMmFormat = dateStr.slice(0, 7); // YYYY-MM만 추출
    }

    remainingDates = addCrrentPossible(list, futureYyyyMmFormat); // ["2025-10-28", "2025-10-29", ...]
   
    

    if (remainingDates.length > 0) {
        html += '<div class="add-start-class" style="text-align:right;">';
        html += '<button class="add-btn">개강날짜 추가</button>';
        html += '</div>';
    } else {
        html += '<div class="all-classes-finished" style="text-align:center; color:gray;">';
        html += '해당월의 모든 수업이 종료되었습니다.';
        html += '</div>';
    }

    html += '</div>'; // month-control-bar 닫기

    return html;
}




function formatted(timestamp){
    var time = Number(timestamp);
    if (isNaN(time)) return "Invalid Date";

    // 초 단위인지 밀리초 단위인지 판단
    if (time < 1e12){ // 13자리보다 작으면 초 단위
        time = time * 1000;
    }

    var date = new Date(time);

    var year  = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day   = ('0' + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}


function addCrrentPossible(futureList, futureYyyyMmFormat) {
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth() + 1; // 0~11
    var lastDay = new Date(year, month + 1, 0).getDate(); // 해당 달 마지막 날

 
    if (month < 10) {
        month = '0' + month;
    }

    var yyyy_mm = year + '-' + month;

    let isFuture = futureYyyyMmFormat === year + "-" + month;

    if (!isFuture && futureList != undefined && futureYyyyMmFormat != undefined) {
        return addFuturePossibleWithSet(futureList, futureYyyyMmFormat);
    }

    var result = [];
    for (var day = today.getDate(); day <= lastDay; day++) {
        // 오늘인 경우 오후 3시 이후면 제외
        if (day === today.getDate() && today.getHours() >= 15) {
            continue; // 건너뛰기
        }

        var mm = ('0' + month).slice(-2);
        var dd = ('0' + day).slice(-2);
        result.push(year + '-' + mm + '-' + dd);
    }

    return result;
}


function addFuturePossibleWithSet(futureList, futureYyyyMmFormat) {
    const 이미등록된 = new Set();  // 이미 등록된 날짜 저장
    const result = [];

    // YYYY-MM → year, month
    const [yearStr, monthStr] = futureYyyyMmFormat.split("-");
    const year = parseInt(yearStr, 10);
    const month = parseInt(monthStr, 10) - 1; // JS 월은 0부터 시작

    const lastDay = new Date(year, month + 1, 0).getDate();

    // 이미 등록된 날짜 Set에 추가
    futureList.forEach(item => {
        const dateStr = formatted(item.openday); // YYYY-MM-DD
        const dayStr = dateStr.split("-")[2];    // DD
        이미등록된.add(dayStr);
    });

    // 남은 날짜 계산
    for (let day = 1; day <= lastDay; day++) {
        const dd = ('0' + day).slice(-2);
        if (이미등록된.has(dd)) continue;

        const mm = ('0' + (month + 1)).slice(-2);
        result.push(year + '-' + mm + '-' + dd);

    }

    return result;
}







function eventResister(){
	
	// 수업 마감 버튼
	$(".btn-close").on("click",function(){
		var isactive = $(this).data("isactive");
		var active = (isactive === true || isactive === "true");
		if(!active){
			alert("해당수업은 이미 종료된 수업입니다.");
			return;
		}	
		
		console.log("마감!!!");
		
		
		
		
	});

	
	// 개강날짜 추가 버튼 → 모달 띄우기
	$(".add-btn").on("click", function() {
	   
	    var today = new Date();
	    var year = today.getFullYear();
	    var month = ('0' + (today.getMonth() + 1)).slice(-2);
	    var yearMonth = year + '-' + month;

	    var html = '';
	    html += '<div class="modal-overlay">';
	    html += '  <div class="modal-box">';
	    html += '    <div class="modal-row modal-header">';
	    html += '      <h3>' + yearMonth + ' 개강 날짜 추가</h3>';
	    html += '    </div>';
	    html += '    <div class="modal-row modal-select">';
	    html += '      <label>개강일 선택</label>';
	    html += '      <select id="select-openday" class="select-openday">';
	    for (var i = 0; i < remainingDates.length; i++) {
	        html += '        <option value="' + remainingDates[i] + '">' + remainingDates[i] + '</option>';
	    }
	    html += '      </select>';
	    html += '    </div>';
	    html += '    <div class="modal-row modal-rest">';
	    html += '      <label>남은 자리</label>';
	    html += '      <input type="number" class="rest-field" min="1" placeholder="인원 입력">';
	    html += '      <span class="null-error">인원 수를 입력하세요.</span>';  // ✅ 추가
	    html += '    </div>';
	    html += '    <div class="modal-row modal-buttons">';
	    html += '      <button id="btn-add-confirm" class="btn-confirm">추가</button>';
	    html += '      <button id="btn-add-cancel" class="btn-cancel">취소</button>';
	    html += '    </div>';
	    html += '  </div>';
	    html += '</div>';

	    $("body").append(html);

	    // 오류 메시지 숨기기 초기화
	    $(".null-error").hide();

	    // 취소 버튼
	    $("#btn-add-cancel").on("click", function() {
	        $(".modal-overlay").remove();
	    });

	    // 추가 버튼
	    $("#btn-add-confirm").on("click", function() {
	        var selectedDate = $("#select-openday").val();
	        var restCount = $(".rest-field").val();

	        if (!restCount || isNaN(restCount) || restCount <= 0) {
	            $(".null-error").show(); // 경고 표시
	            $(".rest-field").focus();
	            return;
	        }	        
	        // TODO: 서버 전송
	        alert("[" + selectedDate + "] 개강일(" + restCount + "명) 추가 완료!");
	        $(".modal-overlay").remove();
	    });

	    // 입력 시 오류 메시지 자동 숨김
	    $(".rest-field").on("input", function() {
	        $(".null-error").hide();
	    });    
	    
	});
	
	
	

}

function removeEventRegister(){
    // 모든 클릭 이벤트 제거
    $(".active-month-select").off("change")
    $(".btn-close").off("click");
    $(".btn-edit").off("click");
    $(".add-btn").off("click");
    $(".rest-field").off("input");
    $("#btn-add-confirm").off("click");
    $("#btn-add-cancel").off("click");
}
function todayYyyyMmFormatted(){
	    var date = new Date();

	    var year  = date.getFullYear();
	    var month = ('0' + (date.getMonth() + 1)).slice(-2);
	    var day   = ('0' + date.getDate()).slice(-2);

	    return year + "-" + month
	
}

</script>


</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include
				file="../compoents/teacherVerticalBar/teacherVerticalBar.jsp"%>
		</div>


		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>개설 수업 관리</h1>
			</div>
			<div id="contentBody">
			
			</div>
		</div>
	</div>

</body>
</html>
