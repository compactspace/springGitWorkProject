<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>내 정보 확인</title>

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
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
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
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

/* 조회 버튼 시작 */
#searchFilters {
	margin-bottom: 20px;
}

#searchFilters input {
	padding: 5px 8px;
	margin-right: 10px;
	width: 120px;
}

#searchFilters button {
	padding: 6px 12px;
	margin-right: 5px;
	background-color: #4a90e2;
	border: none;
	color: #fff;
	border-radius: 4px;
	cursor: pointer;
}

#searchFilters button:hover {
	background-color: #357ABD;
}

#statusFilters {
    margin-bottom: 20px;
}

#statusFilters button {
    padding: 6px 12px;
    margin-right: 5px;
    background-color: #4a90e2; 
    border: none;
    color: #fff;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.1s;
    font-weight: 500;
}

#statusFilters button:hover {
    background-color: #357ABD;
    transform: translateY(-2px);
}

#statusFilters button.active {
    background-color: #50C878; 
}

/* 조회 버튼 종료 */




/* 내정보 시작 */
.info-container {
	display: flex;
	flex-direction: column;
	margin: 40px auto;
	font-family: 'Arial', sans-serif;
	padding: 20px 30px;
}

.info-container h2 {
	margin-bottom: 20px;
	font-size: 1.5em;
	color: #333;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}

.info-row {
	display: flex;
	margin-bottom: 12px;
}

.info-row div:first-child {
	flex: 1;
	font-weight: bold;
	color: #555;
}

.info-row div:last-child {
	flex: 2;
	color: #333;
}
/* 내정보 종료 */
.table-container {
	display: flex;
	flex-direction: column;
	border: 1px solid #ccc;
	border-radius: 6px;
	overflow: hidden;
	margin-top: 20px;
	font-family: Arial, sans-serif;
}

/* 헤더 행 */
.table-header, .table-row {
	display: flex;
	min-height: 40px; /* 최소 높이 확보 */
}

/* 헤더 스타일 */
.table-header {
	background-color: #f5f5f5;
	font-weight: bold;
}

/* 각 셀 */
.table-cell {
	flex: 1;
	padding: 12px 8px; /* 충분한 좌우/상하 여백 */
	border-right: 1px solid #ddd;
	word-break: break-word; /* 긴 글도 줄바꿈 */
	line-height: 1.4; /* 가독성 좋은 줄간격 */
	white-space: normal; /* 텍스트 줄바꿈 허용 */
}

/* 마지막 셀은 border 제거 */
.table-header .table-cell:last-child, .table-row .table-cell:last-child
	{
	border-right: none;
}

/* 데이터 행 색상 */
.table-row:nth-child(even) {
	background-color: #fafafa;
}

/* hover 효과 */
.table-row:hover {
	background-color: #f0f8ff;
}

/* 작은 화면용 가로 스크롤 */
.table-wrapper {
	overflow-x: auto;
}
</style>

<script>
const contextPath="${pageContext.request.contextPath}";

let unReadDocumentListCopy=null;

window.onload = function(){	
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");

	$.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	    }
	});  
	
	// JSP 값 문자열로 받기
	 // JSP에서 값 문자열로 받기
  	var fromOuterStart  = "${startDate}";
    var fromOuterEnd    = "${endDate}";

    // 널, undefined, 빈 문자열 체크 후 기본값 할당
    if (!fromOuterStart || fromOuterStart === "null") {
    	fromOuterStart = getTodayDateFormByYyyyMmDd();
    }

    if (!fromOuterEnd || fromOuterEnd === "null") {
    	fromOuterEnd = getTomorrowDateFormByYyyyMmDd();
    }

    console.log("fromOuterStart:", fromOuterStart);
    console.log("fromOuterEnd:", fromOuterEnd);
	
	
	
	 getApplicantDocuments(fromOuterStart,fromOuterEnd);
	 
	 
	 
		$("#btnApplyPeriod").click(function() {
			const start = $("#startDate").val();
			const end = $("#endDate").val();
			if (!start || !end) {
				alert("시작일과 종료일을 선택해주세요.");
				return;
			}
			getApplicantDocuments(start, end);
		});
	 
	 
		
		$("#btnToday").click(function() {
			const start = getTodayDateFormByYyyyMmDd();
			const end = getTomorrowDateFormByYyyyMmDd();			
			getApplicantDocuments(start, end);
		});
		
		
	 
		$("#btnRecent7Days").click(function() {
			const end = new Date();
			const start = new Date();
			start.setDate(end.getDate() - 6);
			$("#startDate").val($.datepicker.formatDate('yy-mm-dd', start));
			$("#endDate").val($.datepicker.formatDate('yy-mm-dd', end));
			getApplicantDocuments($.datepicker.formatDate('yy-mm-dd', start), $.datepicker.formatDate('yy-mm-dd', end));
		});
		$("#btnCurrentMonth").click(function() {
			const today = new Date();
			const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
			const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
			$("#startDate").val($.datepicker.formatDate('yy-mm-dd', firstDay));
			$("#endDate").val($.datepicker.formatDate('yy-mm-dd', lastDay));
			getApplicantDocuments($.datepicker.formatDate('yy-mm-dd', firstDay), $.datepicker.formatDate('yy-mm-dd', lastDay));
		});
		$("#btnPreviousMonth").click(function() {
			const date = new Date();
			date.setMonth(date.getMonth() - 1);
			const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
			const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
			$("#startDate").val($.datepicker.formatDate('yy-mm-dd', firstDay));
			$("#endDate").val($.datepicker.formatDate('yy-mm-dd', lastDay));
			getApplicantDocuments($.datepicker.formatDate('yy-mm-dd', firstDay), $.datepicker.formatDate('yy-mm-dd', lastDay));
		});

		// 상태 버튼 이벤트 및 트리거 대상
		$("#statusFilters button").click(function() {
			selectedStatus = $(this).data("status");
			const start = $("#startDate").val();
			const end = $("#endDate").val();
			getApplicantDocuments(start, end);
		});
	 
	 
	 
	 
	 
	 
	 
}// 온로드 레디



function getTodayDateFormByYyyyMmDd() {
    var d = new Date();
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}

function getTomorrowDateFormByYyyyMmDd() {
    var d = new Date();
    d.setDate(d.getDate() + 1); // 다음날
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}







function getApplicantDocuments(stDate,edDate){
	
	console.log('stDate',stDate,' edDate: ',edDate);
	
	const url = "${pageContext.request.contextPath}/api/admin/get-unread-document-list"
        + (stDate ? "?stDate=" + encodeURIComponent(stDate) : "")
        + (edDate ? (stDate ? "&" : "?") + "edDate=" + encodeURIComponent(edDate) : "");

	 $.ajax({
		url:url,
		type:"GET",
		success:function(res){
			
			
			  const { unReadDocumentList } = res;
			    console.log(unReadDocumentList);

			    // 복사 배열에 저장
			    unReadDocumentListCopy = [...unReadDocumentList];
			    console.log(unReadDocumentListCopy);

			    // 복사 배열 기준으로 렌더링
			  //  renderAllDocumentsFromCopy();
			    renderDocumentsTable();
			    
			
		},
		err:function(){}
		
		
	})
	///get-unread-document-list
	
	
}


function renderAllDocumentsFromCopy() {
    var container = document.getElementById("documentInfoContainer");
    container.innerHTML = "<h2>문서 정보</h2>"; // 초기화

    if(!unReadDocumentListCopy || unReadDocumentListCopy.length === 0) {
        container.innerHTML += "<p>미처리건 문서가 없습니다.</p>";
        return;
    }

    for(var i = 0; i < unReadDocumentListCopy.length; i++) {
        var doc = unReadDocumentListCopy[i];

        container.innerHTML += 
            '<div class="info-row"><div>회사명</div><div>' + doc.company_name + '</div></div>' +
            '<div class="info-row"><div>대표자</div><div>' + doc.representative_name + '</div></div>' +
            '<div class="info-row"><div>사업자등록번호</div><div>' + doc.registration_number + '</div></div>' +
            '<div class="info-row"><div>주소</div><div>' + doc.address + '</div></div>' +
            '<div class="info-row"><div>전화번호</div><div>' + doc.company_phone + '</div></div>' +
            '<div class="info-row"><div>이메일</div><div>' + doc.email + '</div></div>' +
            '<div class="info-row"><div>문서종류</div><div>' + doc.document_type + '</div></div>' +
            '<div class="info-row"><div>상태</div><div>' + doc.status + '</div></div>' +
            '<div class="info-row"><div>업로드 날짜</div><div>' + new Date(doc.uploaded_at).toLocaleString() + '</div></div>' +
            '<div class="info-row"><div>제출 파일</div><div>' + doc.file_path + '</div></div>' +
            '<hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">';
    }
}



function renderDocumentsTable() {
    var container = document.getElementById("documentInfoContainer");
    container.innerHTML = "<h2>문서 정보 (테이블 형식)</h2>"; // 초기화

    if(!unReadDocumentListCopy || unReadDocumentListCopy.length === 0) {
        container.innerHTML += "<p>미처리건 문서가 없습니다.</p>";
        return;
    }
    

    var tableHtml = '<div class="table-wrapper"><div class="table-container">';
    tableHtml += '<div class="table-header">' +
                 '<div class="table-cell">회사명</div>' +
                 '<div class="table-cell">대표자</div>' +
                 '<div class="table-cell">사업자등록번호</div>' +
                 '<div class="table-cell">주소</div>' +
                 '<div class="table-cell">전화번호</div>' +
                 '<div class="table-cell">이메일</div>' +
                 '<div class="table-cell">문서종류</div>' +
                 '<div class="table-cell">상태</div>' +
                 '<div class="table-cell">업로드 날짜</div>' +
                 '<div class="table-cell">액션</div>' +
                 '<div class="table-cell">제출 파일</div>' +
                 '</div>';

    for(var i = 0; i < unReadDocumentListCopy.length; i++) {
        var doc = unReadDocumentListCopy[i];
        tableHtml += '<div class="table-row">' +
                     '<div class="table-cell">' + doc.company_name + '</div>' +
                     '<div class="table-cell">' + doc.representative_name + '</div>' +
                     '<div class="table-cell">' + doc.registration_number + '</div>' +
                     '<div class="table-cell">' + doc.address + '</div>' +
                     '<div class="table-cell">' + doc.company_phone + '</div>' +
                     '<div class="table-cell">' + doc.email + '</div>' +
                     '<div class="table-cell">' + doc.document_type + '</div>' +
                     '<div class="table-cell">' + doc.status + '</div>' +
                     '<div class="table-cell">' + new Date(doc.uploaded_at).toLocaleString() + '</div>' +
                     '<div class="table-cell">' +
                        '<button class="approve-btn" data-idx="'+i+'" data-teacher-id="' + doc.teacher_id + '">승인</button> ' +
                        '<button class="reject-btn" data-idx="'+i+'" data-teacher-id="' + doc.teacher_id + '">거절</button>' +
                     '</div>' +
                     '<div class="table-cell">' +
                        '<span class="show-document" data-teacher-id="' + doc.teacher_id + '">다운</span>' +
                     '</div>' +
                     '</div>';
    }

    tableHtml += '</div></div>';
    container.innerHTML += tableHtml;

    // 이벤트 연결
    container.querySelectorAll(".approve-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Approve", idx);
        });
    });

    container.querySelectorAll(".reject-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Reject", idx);
        });
    });

    container.querySelectorAll(".show-document").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            downloadDocument(teacherId);
        });
    });
}

// 상태 업데이트 + 복사본 처리
function updateDocumentStatus(teacherId, newStatus, idx){
    $.ajax({
        url: contextPath + "/api/admin/update-document-status",
        type: "POST",
        data: { teacherId: teacherId, status: newStatus },
        success: function(res){ 	
        	
        	
            // 상태 변경 후 배열에서 제거 또는 상태 갱신
            unReadDocumentListCopy = findUpdate(unReadDocumentListCopy, newStatus, idx);
            renderDocumentsTable(); // 리렌더링
        },
        error: function(xhr,status,error){
         
        	console.log("xhr: ",xhr);
        		console.log("status: ",status);
        		console.log("error: ",error);
        	
        }
    });
}

// 배열에서 상태 변경 후 제거
function findUpdate(list, newStatus, idx){
    // 만약 승인/거절 후 목록에서 제거하려면
    list.splice(idx, 1); // 해당 인덱스 제거
    return [...list]; // 새 배열로 리턴
}



// 다운로드 함수
function downloadDocument(teacherId) {
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    var xhr = new XMLHttpRequest();
    xhr.open("POST", contextPath + "/api/admin/get-document-file", true);
    xhr.setRequestHeader(header, token);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.responseType = "blob";

    xhr.onload = function() {
        if (xhr.status === 200) {
            var disposition = xhr.getResponseHeader('Content-Disposition');
            var fileName = 'downloaded-file';
            if(disposition && disposition.indexOf('filename=') !== -1){
                var matches = disposition.match(/filename\*?=([^;]+)/i);
                if(matches && matches[1]){
                    fileName = decodeURIComponent(matches[1].replace(/UTF-8''/,'').replace(/["']/g,''));
                }
            }

            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(xhr.response);
            link.download = fileName;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            window.URL.revokeObjectURL(link.href);
        } else {
            alert("파일 다운로드 중 오류 발생");
        }
    };

    xhr.onerror = function() {
        alert("파일 다운로드 중 오류 발생");
    };

    xhr.send("teacherId=" + encodeURIComponent(teacherId));
}


</script>

</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
		</div>
		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>미처리 서류 처리</h1>
				<div class="header-subtitle">반드시 제출 서류 파일 확인후 상태를 변경하세요</div>
			</div>
			
			<div id="searchFilters">
				<label for="startDate">시작일:</label> <input type="text" id="startDate" readonly>
				<label for="endDate">종료일:</label> <input type="text" id="endDate" readonly>
				<button id="btnApplyPeriod">기간 적용</button>
				<button id="btnToday">오늘</button>
				<button id="btnRecent7Days">최근 7일</button>
				<button id="btnCurrentMonth">당월</button>
				<button id="btnPreviousMonth">전월</button>
			</div>
					
					

			<!--  우측 시작  -->
			<div id="content-body">

				<div class="info-container" id="documentInfoContainer">
					<h2>문서 정보</h2>
					<!-- 데이터가 여기에 동적으로 삽입됩니다 -->
				</div>

			</div>



		</div>


	</div>
</body>
</html>