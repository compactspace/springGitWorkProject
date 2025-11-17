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

let readDocumentListCopy=null;

window.onload = function(){	
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");

	$.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	    }
	});  
	 getApplicantDocuments();
	 
}


function getApplicantDocuments(){
	$.ajax({
		url:"${pageContext.request.contextPath}/api/admin/get-readed-document-list",
		type:"GET",
		success:function(res){
			
			
			  const { readDocumentList } = res;
			    console.log(readDocumentList);

			    // 복사 배열에 저장
			    readDocumentListCopy = [...readDocumentList];
			    console.log(readDocumentListCopy);

			    // 복사 배열 기준으로 렌더링
			 
			    renderDocumentsTable();
			    
			
		},
		err:function(){}
		
		
	})
	///get-unread-document-list
	
	
}






function renderDocumentsTable() {
    var container = document.getElementById("documentInfoContainer");
    container.innerHTML = "<h2>문서 정보 (테이블 형식)</h2>"; // 초기화

    if(!readDocumentListCopy || readDocumentListCopy.length === 0) {
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

    for(var i = 0; i < readDocumentListCopy.length; i++) {
    	
    	
    	
        var doc = readDocumentListCopy[i];
        
        // 가능한 액션 초기화 (현재 상태 제외)
        var myPossibleAction = {
            "Approved": "승인",
            "Rejected": "거절",
            "Insufficient": "보완 요청",
            "Resubmit": "재제출 요청"
        };

        // 현재 상태 액션 제외
        if(doc.status && myPossibleAction[doc.status]) {
            delete myPossibleAction[doc.status];
        }
        
   
        
        var statusHtml = '';
        switch(doc.status) {
            case 'Approved':
                statusHtml = '<span class="status-badge status-approved" title="문서가 정상적으로 승인되었습니다">승인 완료</span>';
                break;
            case 'Rejected':
                statusHtml = '<span class="status-badge status-rejected" title="' + (doc.review_comment || '서류가 승인 기준에 맞지 않아 거절되었습니다') + '">거절됨</span>';
                break;
            case 'Insufficient':
                statusHtml = '<span class="status-badge status-insufficient" title="' + (doc.review_comment || '서류 보완이 필요합니다') + '">보완 요청</span>';
                break;
            case 'Resubmit':
                statusHtml = '<span class="status-badge status-resubmit" title="' + (doc.review_comment || '보완 후 다시 제출을 요청했습니다') + '">재제출 요청</span>';
                break;
            default:
                statusHtml = '<span class="status-badge status-pending" title="검토가 대기 중입니다">대기중</span>';
        }
        
        // 액션 버튼 생성
     // 액션 버튼 생성
        var actionButtons = '';
        if(doc.status === "Rejected"){
            actionButtons = '<span class="status-message">거절된 문서입니다</span>';
        } else {
            for(var key in myPossibleAction){
                var btnClass = key.toLowerCase() + '-btn'; // 예: approved-btn
                actionButtons += '<button class="' + btnClass + 
                                 '" data-idx="'+i+'" data-teacher-id="' + doc.teacher_id + 
                                 '" data-action="' + myPossibleAction[key] + '">' + 
                                 myPossibleAction[key] + 
                                 '</button> ';
            }
        }
            
            
        
        
        tableHtml += '<div class="table-row">' +
                     '<div class="table-cell">' + doc.company_name + '</div>' +
                     '<div class="table-cell">' + doc.representative_name + '</div>' +
                     '<div class="table-cell">' + doc.registration_number + '</div>' +
                     '<div class="table-cell">' + doc.address + '</div>' +
                     '<div class="table-cell">' + doc.company_phone + '</div>' +
                     '<div class="table-cell">' + doc.email + '</div>' +
                     '<div class="table-cell">' + doc.document_type + '</div>' +
                     '<div class="table-cell">' + statusHtml + '</div>' +
                     '<div class="table-cell">' + new Date(doc.uploaded_at).toLocaleString() + '</div>' +
                     '<div class="table-cell">' +actionButtons +
                     '</div>' +
                     '<div class="table-cell">' +
                        '<span class="show-document" data-teacher-id="' + doc.teacher_id + '">다운</span>' +
                     '</div>' +
                     '</div>';
    }

    tableHtml += '</div></div>';
    container.innerHTML += tableHtml;

    
    // 이벤트 연결
    container.querySelectorAll(".approved-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Approved", idx);
        });
    });

    container.querySelectorAll(".rejected-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Rejected", idx);
        });
    });
    
    
    
    // 이벤트 연결
    container.querySelectorAll(".insufficient-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Insufficient", idx);
        });
    });

    container.querySelectorAll(".resubmit-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            const teacherId = this.getAttribute("data-teacher-id");
            const idx = parseInt(this.getAttribute("data-idx"));
            updateDocumentStatus(teacherId, "Resubmit", idx);
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
            readDocumentListCopy = findUpdate(readDocumentListCopy, newStatus, idx);
            renderDocumentsTable(); // 리렌더링
        },
        error: function(xhr,status,error){
         
        	console.log("xhr: ",xhr);
        		console.log("status: ",status);
        		console.log("error: ",error);
        	
        }
    });
}



// 배열에서 상태  변경
function findUpdate(list, newStatus, idx){  
    list[idx].status=newStatus;
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