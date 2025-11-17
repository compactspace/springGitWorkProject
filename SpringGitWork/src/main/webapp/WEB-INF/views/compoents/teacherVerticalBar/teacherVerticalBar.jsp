<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<sec:authorize access="hasAuthority('ROLE_TEACHER')">
<nav id="verticalBarWrapper"></nav>


<sec:authentication property="principal" var="user" />

<script>
// ✅ 로그인된 아이디
var username = "${user.username}";
console.log("userName: "+username)
// ✅ 로그인된 강사 승인 여부
var isApproved = ${user.approved}; // true / false

// ✅ 현재 URL 마지막 경로 추출 (prefix 비교용)
var currentParam = window.location.pathname.split('/').pop();

console.log("currentParam: "+currentParam);





// ✅ 메뉴 구조 정의
var titleMenu = [
    { name: "내정보", prefix: "teacher-my-info", url: "${pageContext.request.contextPath}/teacher/teacher-my-info", children: [] },

    { name: "수업관리", prefix: "teacher-manage-onedayclass",
    	isApproved: isApproved, // ✅ 첫 번째 메뉴에만 추가
    	url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass", children: [
        { name: "월 등록", prefix: "teacher-manage-onedayclass-month-register", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass-month-register" },
        { name: "수업 정보등록 및 관리", prefix: "teacher-manage-onedayclassinfo", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclassinfo" },
        { name: "등록된 월별 수업 일정 관리", prefix: "teacher-manage-onedayclass-schedule", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass-schedule" }
    ] },
    
    { name: "승인현황", prefix: "teacher-applicant-status", url: "${pageContext.request.contextPath}/teacher/teacher-applicant-status", children: [] }

    //결제 관리는 추후 추가 아직 DB도 백엔드도 없음
    /*   ,
    { 
        name: "결제관리", prefix: "teacher-payinfo", url: "${pageContext.request.contextPath}/teacher/teacher-payinfo",
        children: [
            { name: "결제 내역", prefix: "teacher-payinfo-history", url: "${pageContext.request.contextPath}/teacher/pay-history" },
            { name: "환불 내역", prefix: "teacher-refund-history", url: "${pageContext.request.contextPath}/teacher/refund-history" }
        ]
    } */ 
   ];

// ✅ 메뉴 HTML 생성 함수
function createMenuHTML(menuArray, currentParam) {
	
	
	menuArray.forEach(function(item) {
	    // "수업관리" 메뉴에만 적용
	    if (item.prefix === "teacher-manage-onedayclass") {
	        item.isApproved = isApproved; // 메뉴 객체에 승인 상태 추가

	        if (!isApproved) {
	            // false면 자식 메뉴를 제거
	            item.children = [];
	        }
	        // true면 자식 메뉴 그대로 유지
	    }
	});

	
	
	
	
	
    var html = '';
    // 상단 아이디 + 로그아웃 + 승인 상태
html += '<div class="top-bar">';
html += '  <div class="user-info">';
html += '    <span class="username">' + username + '</span>';
html += '    <form action="${pageContext.request.contextPath}/users/logout" method="POST" class="logout-form">';
html += '      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />';
html += '      <button type="submit" class="logout-btn">로그아웃</button>';
html += '    </form>';
html += '  </div>';
html += '  <div class="approval-status">';
html += '    승인 상태: ' + (isApproved ? '승인됨' : '미승인');
html += '  </div>';
html += '  <div class="home-buttons">';
html += '    <div class="home-btn management-home" onclick="location.href=\'${pageContext.request.contextPath}/teacher/teacher-my-info\'">관리홈</div>';
html += '    <div class="home-btn user-home" onclick="location.href=\'${pageContext.request.contextPath}/\'">유저홈</div>';
html += '  </div>';
html += '</div>';



    // 메뉴 리스트
    html += '<ul class="menu">';
    menuArray.forEach(function(item) {
        var hasChildren = item.children && item.children.length > 0;
        var isItemActive = currentParam === item.prefix;
        var hasActiveChild = hasChildren && item.children.some(sub => currentParam === sub.prefix);
        var activeClass = (isItemActive || hasActiveChild) ? "active" : "";
        var expandedClass = hasActiveChild ? "expanded" : "";

        var disabled = (!isApproved && item.prefix === "teacher-manage-onedayclass");
        var href = hasChildren ? "javascript:void(0);" : (disabled ? "javascript:void(0);" : item.url);
        var clickHandler = disabled ? 'onclick="alert(\'아직 관리자의 승인 대기중입니다.\')"' : '';
       
        
        
        html += '<li class="menu-item ' + expandedClass + '">';
        html += '<a class="' + activeClass + '" href="' + href + '" ' + clickHandler + '>' + item.name + '</a>';

        if (hasChildren) {
            var subMenuDisplay = hasActiveChild ? "block" : "none";
            html += '<ul class="sub-menu" style="display:' + subMenuDisplay + ';">';
            item.children.forEach(function(sub) {
                var subActiveClass = (currentParam === sub.prefix) ? "active" : "";
                html += '<li class="sub-menu-item">';
                html += '<a class="' + subActiveClass + '" href="' + sub.url + '">' + sub.name + '</a>';
                html += '</li>';
            });
            html += '</ul>';
        }

        html += '</li>';
    });
    html += '</ul>';
    return html;
}

// ✅ DOM 로드 후 메뉴 생성
document.addEventListener("DOMContentLoaded", function() {
    var wrapper = document.getElementById("verticalBarWrapper");
    wrapper.innerHTML = createMenuHTML(titleMenu, currentParam);

    // 서브 메뉴 토글 이벤트
    var menuItems = wrapper.querySelectorAll('.menu-item > a');
    menuItems.forEach(function(item) {
        item.addEventListener('click', function(e) {
            var parentLi = this.parentNode;
            var subMenu = parentLi.querySelector('.sub-menu');
            if (subMenu) {
                e.preventDefault();
                subMenu.style.display = (subMenu.style.display === 'block') ? 'none' : 'block';
                parentLi.classList.toggle('expanded');
            }
        });
    });
});
</script>

<style>
/* === 전체 수직바 === */
#verticalBarWrapper {  
    height: 100vh;
    background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
    border-right: 1px solid #e3e6ea;
    font-family: 'Noto Sans KR', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
    overflow-x: hidden; /* 수평 스크롤 제거 */
    box-sizing: border-box;
}

/* 모든 자식 요소 박스 사이징 적용 */
#verticalBarWrapper *, 
#verticalBarWrapper li, 
#verticalBarWrapper a {
    box-sizing: border-box;
    min-width: 0; /* flex 내부 폭 초과 방지 */
}

/* ===== 상단 바 ===== */
.top-bar {
    padding: 16px 16px;
    border-bottom: 1px solid #e3e6ea;
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 50px;
    
}

.user-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logout-form { margin: 0; }
.logout-btn {
    background: #f44336;
    color: #fff;
    border: none;
    padding: 4px 10px;
    border-radius: 3px;
    cursor: pointer;
    font-size: 0.9em;
}
.logout-btn:hover { background: #d32f2f; }

.approval-status {
    font-size: 0.85em;
    color: #555;
}

.home-buttons {
    display: flex;
    gap: 8px;
    margin-top: 4px;
}

.home-btn {
    flex: 1;
    text-align: center;
    padding: 6px 0;
    background: #007bff;
    color: #fff;
    border-radius: 3px;
    cursor: pointer;
    font-size: 0.9em;
}
.home-btn:hover { background: #0056b3; }

/* ===== 메뉴 리스트 ===== */
.menu, .sub-menu {
    list-style: none;
    padding: 0;
    margin: 0;
    width: 100%;
}

.menu-item, .sub-menu-item {
    width: 100%;
}

/* 메뉴 링크 */
.menu-item > a, .sub-menu-item > a {
    display: block;
    width: 100%;
    padding: 14px 18px;
    color: #2c3e50;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.25s ease;
    border-left: 4px solid transparent;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden;    /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* ... 표시 */
}

/* 메뉴 링크 호버/액티브 */
.menu-item > a:hover {
    background: rgba(0, 123, 255, 0.08);
    color: #007bff;
}

.menu-item > a.active {
    background: linear-gradient(90deg, #007bff 0%, #3399ff 100%);
    color: #fff;
    border-left: 4px solid #0056b3;
    box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
}

/* 서브 메뉴 */
.sub-menu {
    display: none;
    background-color: #f9fafb;
    border-left: 1px solid #e5e7eb;
    width: 100%;
    overflow-x: hidden; /* 수평 스크롤 제거 */
}

.menu-item.expanded > .sub-menu {
    display: block;
}

/* 서브 메뉴 링크 */
.sub-menu-item > a {
    display: block;
    width: 100%;
    padding: 10px 28px;
    font-size: 0.93em;
    color: #555;
    text-decoration: none;
    transition: all 0.2s ease;
    border-left: 3px solid transparent;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.sub-menu-item > a:hover {
    background: rgba(0, 123, 255, 0.07);
    color: #007bff;
}

.sub-menu-item > a.active {
    font-weight: 600;
    color: #007bff;
    border-left: 3px solid #007bff;
    background-color: rgba(0, 123, 255, 0.05);
}

.menu-item:not(:last-child) {
    border-bottom: 1px solid #f1f1f1;
}

/* ===== 반응형 ===== */
@media (max-width: 768px) {
    #verticalBarWrapper { width: 200px; }
    .menu-item > a { padding: 12px 14px; font-size: 0.95em; }
    .sub-menu-item > a { padding: 8px 24px; font-size: 0.9em; }
    .home-btn { font-size: 0.85em; padding: 5px 0; }
}

</style>
</sec:authorize>
