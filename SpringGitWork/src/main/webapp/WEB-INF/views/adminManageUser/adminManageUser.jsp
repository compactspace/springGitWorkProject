<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 확인</title>

<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

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

/* 테이블 형태 스타일 */
.user-table, .user-row {
    display: grid;
   grid-template-columns: 80px 1fr 1fr 1fr 1fr 1fr 1fr 1fr;
}



.user-table {
	text-align: center;
	border-bottom: 2px solid #4a90e2;
	font-weight: 600;
	padding: 8px 0;
}

.user-row {
	text-align: center;
	border-bottom: 1px solid #e0e0e0;
	padding: 8px 0;
}

.user-table div, .user-row div {
	padding: 4px 8px;
	word-break: break-word;
}

.user-table {
	margin-bottom: 10px;
}


/*발송 버튼 시작  */

#selectAllWrapper button {
    background-color: #4a90e2; /* 파란색 배경 */
    color: #fff;               /* 흰색 글씨 */
    border: none;
    border-radius: 4px;
    padding: 8px 16px;
    margin-right: 8px;
    font-size: 0.95em;
    cursor: pointer;
    transition: all 0.3s ease;
}

#selectAllWrapper button:last-child {
    margin-right: 0;
}

#selectAllWrapper button:hover {
    background-color: #357abd; /* 조금 더 진한 파랑 */
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

#selectAllWrapper button:active {
    transform: translateY(0);
    box-shadow: none;
}

#btnSend {
    background-color: #28a745; /* 초록색 */
}

#btnSend:hover {
    background-color: #218838;
}

/*발송 버튼 종료  */

</style>

<script>
const contextPath="${pageContext.request.contextPath}";

window.onload = function(){    
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        }
    }); 
    
    // Promise를 사용해서 데이터 받아 renderUserTable 호출
    searchUserList()
        .then(res => {
            renderUserTable(res.findUserList);
        })
        .catch(err => {
            console.error("사용자 목록 조회 실패:", err);
        });
    
    
    
    
    
    
 // 전체 선택
    $(document).on("click", "#btnSelectAll", function() {
        $(".send-checkbox").prop("checked", true).trigger("change");
    });

    // 전체 해제
    $(document).on("click", "#btnDeselectAll", function() {
        $(".send-checkbox").prop("checked", false).trigger("change");
    });

    // 발송 버튼 (체크된 사용자만)
    $(document).on("click", "#btnSend", function() {
        const selectedUsers = [];
        $(".send-checkbox:checked").each(function() {
            const userRow = $(this).closest(".user-row");
            const userId = userRow.find("div:nth-child(2)").text();
            selectedUsers.push(userId);
        });
        if(selectedUsers.length === 0){
            alert("선택된 사용자가 없습니다.");
            return;
        }
        console.log("발송 대상 사용자:", selectedUsers);
        // 여기서 AJAX로 서버 발송 API 호출 가능
    });    
    
    
    
    
 // 상위 컨테이너에 위임
   $(document).on("click", ".info-btn", function(e){
        e.stopPropagation();
        const userCode = $(this).closest(".user-row").data("user_code");
        console.log("회원정보 버튼 클릭:", userCode);
    });

   $(document).on("click", ".admin-btn", function(e){
        e.stopPropagation();
        const userCode = $(this).closest(".user-row").data("user_code");
        console.log("관리 버튼 클릭:", userCode);
    });

    
}



function searchUserList(){
    return new Promise((resolve, reject) => {
        $.ajax({
            url: contextPath + "/api/admin/get-userlist",
            type: "POST",
            success: function(res){
                resolve(res);
            },
            error: function(xhr, status, err){
                reject({xhr, status, err});
            }
        });
    });
}



//렌더 함수에서는 버튼 클릭 이벤트 제거
function renderUserTable(users) {
    var container = $("#contentBodyMain");
    container.empty();

    if (!users || users.length === 0) {
        container.append("<div>데이터가 없습니다.</div>");
        return;
    }

    // 헤더
    var header = $("<div>").addClass("user-table");
    header.append("<div>발송 체크</div>");
    header.append("<div>회원관리</div>");
    header.append("<div>ID</div>");
    header.append("<div>가입일</div>");
    header.append("<div>전화번호</div>");
    header.append("<div>광고 문자메시지 발송동의</div>");
    header.append("<div>결제 건수</div>");
    header.append("<div>게시글 작성 수</div>");
    container.append(header);

    // 데이터 행
    users.forEach(function(user) {
        var row = $("<div>").addClass("user-row");
        row.attr("data-user_code", user.userCode || "");
        row.attr("data-agreed", user.agreed);

        var signupDate = user.createSignup ? new Date(user.createSignup) : "";
        var formattedDate = "";
        if (signupDate) {
            formattedDate = signupDate.getFullYear() + "-" +
                String(signupDate.getMonth() + 1).padStart(2,'0') + "-" +
                String(signupDate.getDate()).padStart(2,'0') + " " +
                String(signupDate.getHours()).padStart(2,'0') + ":" +
                String(signupDate.getMinutes()).padStart(2,'0');
        }

        // 발송 체크
        var sendCheckCell = $("<div>");
        if (user.agreed) {
            var checkbox = $("<input>").attr("type", "checkbox").addClass("send-checkbox");
            sendCheckCell.append(checkbox);
        }
        row.append(sendCheckCell);

        // 회원관리 버튼 (HTML만 넣고 이벤트는 위임)
        var manageCell = $("<div>").addClass("manage-cell");
        manageCell.append('<button class="info-btn">회원정보</button>');
        manageCell.append('<button class="admin-btn">관리</button>');
        row.append(manageCell);

        // 나머지 컬럼
        row.append("<div>" + user.id + "</div>");
        row.append("<div>" + formattedDate + "</div>");
        row.append("<div>" + user.userTell + "</div>");
        row.append("<div>" + (user.agreed ? "동의" : "미동의") + "</div>");
        row.append("<div>" + (user.payCnt != null ? user.payCnt : 0) + "</div>");
        row.append("<div>" + (user.writingCnt != null ? user.writingCnt : 0) + "</div>");

        container.append(row);
    });
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
				<h1>대시보드</h1>
				<div class="header-subtitle">주요 요약 정보</div>
			</div>
			<div id="contentBody">
				<div id="selectAllWrapper"
					style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
					<!-- 왼쪽 버튼 그룹 -->
					<div>
						<button id="btnSelectAll">전체 선택</button>
						<button id="btnDeselectAll">전체 해제</button>
					</div>

					<!-- 오른쪽 발송 버튼 -->
					<div>
						<button id="btnSend">발송</button>
					</div>
				</div>
				<div id="contentBodyMain">
				</div>
			</div>
		</div>
	</div>
</body>
</html>


