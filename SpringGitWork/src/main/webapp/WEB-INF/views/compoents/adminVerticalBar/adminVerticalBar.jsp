<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<sec:authorize access="hasAuthority('ROLE_ADMIN')">
<nav id="verticalBarWrapper"></nav>

<sec:authentication property="principal" var="user" />

<script>
// ✅ 로그인된 아이디
var username = "${user.username}";



// ✅ 현재 URL 마지막 경로 추출 (prefix 비교용)
var currentParam = window.location.pathname.split('/').pop();
//console.log("currentParam: "+currentParam);



// ✅ 메뉴 구조 정의
// ✅ admin용 타이틀 메뉴 구조 예시
var titleMenu = [
    { name: "Admin 대시보드", prefix: "main", url: "${pageContext.request.contextPath}/admin/main", children: [] },
    ,
    

    { name: "거래처 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "신규 거래처 등록", prefix: "new-vendor-insert", url: "${pageContext.request.contextPath}/admin/new-vendor-insert" },
        { name: "거래처 상품정보 등록", prefix: "new-vendor-insert", url: "${pageContext.request.contextPath}/admin/manage-vendor-list" },
       // { name: "계약 관리", prefix: "delivery-list", url: "${pageContext.request.contextPath}/admin/delivery-list" }
       /*  ,{ name: "활동 로그", prefix: "user-log", url: "${pageContext.request.contextPath}/admin/user/user-log" } */
    ] }
    ,
    { name: "상품 입점 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "상품 입고 등록", prefix: "new-vendor-insert", url: "${pageContext.request.contextPath}/admin/stockin-from-vendor" },
       // { name: "계약 관리", prefix: "delivery-list", url: "${pageContext.request.contextPath}/admin/delivery-list" }
       /*  ,{ name: "활동 로그", prefix: "user-log", url: "${pageContext.request.contextPath}/admin/user/user-log" } */
    ] }
    ,
    
    { name: "주문 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "주문 목록", prefix: "order-list", url: "${pageContext.request.contextPath}/admin/order-list" },
        { name: "배송 관리", prefix: "delivery-list", url: "${pageContext.request.contextPath}/admin/delivery-list" }
       /*  ,{ name: "활동 로그", prefix: "user-log", url: "${pageContext.request.contextPath}/admin/user/user-log" } */
    ] }
    ,
    /* { name: "Admin 기업 사용자 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "기업-사용자 목록", prefix: "user-list", url: "${pageContext.request.contextPath}/admin/user/user-list" },
        { name: "권한 관리", prefix: "user-role", url: "${pageContext.request.contextPath}/admin/user/user-role" },
        { name: "활동 로그", prefix: "user-log", url: "${pageContext.request.contextPath}/admin/user/user-log" }
    ] }
    , */
    
    { name: "사용자 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "사용자 목록", prefix: "user-list", url: "${pageContext.request.contextPath}/admin/user-list" },
      /*   { name: "권한 관리", prefix: "user-role", url: "${pageContext.request.contextPath}/admin/user/user-role" },
        { name: "활동 로그", prefix: "user-log", url: "${pageContext.request.contextPath}/admin/user/user-log" } */
    ] }
    
    
    ,
    { name: "신청서류 관리", prefix: "admin-user", url: "${pageContext.request.contextPath}/admin/user", children: [
        { name: "미처리 서류", prefix: "unread-document-list", url: "${pageContext.request.contextPath}/admin/unread-document-list" },
        { name: "처리된 서류 관리", prefix: "readed-document-list", url: "${pageContext.request.contextPath}/admin/readed-document-list" }
    ] }
    ,
/*     { name: "Admin 시스템 설정", prefix: "admin-settings", url: "${pageContext.request.contextPath}/admin/settings", children: [
        { name: "일반 설정", prefix: "settings-general", url: "${pageContext.request.contextPath}/admin/settings/settings-general" },
        { name: "보안 설정", prefix: "settings-security", url: "${pageContext.request.contextPath}/admin/settings/settings-security" }
    ] },
    { name: "Admin 통계", prefix: "admin-stats", url: "${pageContext.request.contextPath}/admin/stats", children: [
        { name: "사용자 통계", prefix: "stats-user", url: "${pageContext.request.contextPath}/admin/stats/stats-user" },
        { name: "시스템 통계", prefix: "stats-system", url: "${pageContext.request.contextPath}/admin/stats/stats-system" }
    ] }
    , */
   
    
    { name: "쇼핑몰 상품관리", prefix: "admin-stats", url: "${pageContext.request.contextPath}/admin/stats", children: [
    	{ name: "상품 카테고리 등록", prefix: "add-category", url: "${pageContext.request.contextPath}/admin/add-category" },
    // 구현기능은 아까우니 써먹을게 있다면 당해 jsp로 가서 써먹을게있는지 보자.	{ name: "상품 등록", prefix: "add-product", url: "${pageContext.request.contextPath}/admin/add-product" },
        { name: "상품 홈페이지 노출 관리", prefix: "active-product-list", url: "${pageContext.request.contextPath}/admin/active-product-list" }
    	//,{ name: "시스템 통계", prefix: "stats-system", url: "${pageContext.request.contextPath}/admin/stats/stats-system" }
    ] }
    
  
];


// ✅ 메뉴 HTML 생성 함수
function createMenuHTML(menuArray, currentParam) {
    var html = '';

    // 상단바
    html += '<div class="top-bar">';
    html += '  <div class="user-info">';
    html += '    <span class="username">' + username + '</span>';
    html += '    <form action="${pageContext.request.contextPath}/admin/logout" method="POST" class="logout-form">';
    html += '      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />';
    html += '      <button type="submit" class="logout-btn">로그아웃</button>';
    html += '    </form>';
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

        var href = hasChildren ? "javascript:void(0);" : item.url;

        html += '<li class="menu-item ' + expandedClass + '">';
        html += '<a class="' + activeClass + '" href="' + href + '">' + item.name + '</a>';

        // 자식 메뉴가 있을 때만 서브 메뉴 생성
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
