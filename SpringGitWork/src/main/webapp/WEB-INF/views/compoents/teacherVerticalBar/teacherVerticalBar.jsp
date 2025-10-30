<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<sec:authorize access="hasAuthority('ROLE_TEACHER')">
	<nav id="verticalBarWrapper"></nav>

	<sec:authentication property="principal" var="user" />

	<script>
	// ✅ 로그인된 강사 승인 여부
	var isApproved = ${user.approved}; // true / false

	// ✅ 현재 URL 마지막 경로 추출 (prefix 비교용)
	var currentParam = window.location.pathname.split('/').pop();

	// ✅ 메뉴 구조 정의
	var titleMenu = [
	    { name: "내정보", prefix: "teacher-my-info", url: "${pageContext.request.contextPath}/teacher/teacher-my-info", children: [] },

	    { name: "수업관리", prefix: "teacher-manage-onedayclass", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass", children: [
	        { name: "월 등록", prefix: "teacher-manage-onedayclass-month-register", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass-month-register" },
	        { name: "수업 정보등록 및 관리", prefix: "teacher-manage-onedayclassinfo", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclassinfo" },
	        { name: "등록된 월별 수업 일정 관리", prefix: "teacher-manage-onedayclass-schedule", url: "${pageContext.request.contextPath}/teacher/teacher-manage-onedayclass-schedule" }

	    ] },
	    
	    

	    { name: "승인현황", prefix: "teacher-applicant-status", url: "${pageContext.request.contextPath}/teacher/teacher-applicant-status", children: [] },

	    { 
	        name: "결제관리", prefix: "teacher-payinfo", url: "${pageContext.request.contextPath}/teacher/teacher-payinfo",
	        children: [
	            { name: "결제 내역", prefix: "teacher-payinfo-history", url: "${pageContext.request.contextPath}/teacher/pay-history" },
	            { name: "환불 내역", prefix: "teacher-refund-history", url: "${pageContext.request.contextPath}/teacher/refund-history" }
	        ]
	    }
	];

	// ✅ 메뉴 HTML 생성 함수
	function createMenuHTML(menuArray, currentParam) {
	    var html = '<ul class="menu">';

	    menuArray.forEach(function(item) {
	        var hasChildren = item.children && item.children.length > 0;

	        // 현재 메뉴 활성화 판단 (prefix 기준)
	        var isItemActive = currentParam === item.prefix;
	        var hasActiveChild = hasChildren && item.children.some(sub => currentParam === sub.prefix);

	        var activeClass = (isItemActive || hasActiveChild) ? "active" : "";
	        var expandedClass = hasActiveChild ? "expanded" : "";

	        // 승인 대기 시 접근 제한
	        var disabled = (!isApproved && item.prefix === "teacher-manage-onedayclass");
	        var href = hasChildren ? "javascript:void(0);" : (disabled ? "javascript:void(0);" : item.url);
	        var clickHandler = disabled ? 'onclick="alert(\'아직 관리자의 승인 대기중입니다.\')"' : '';

	        html += '<li class="menu-item ' + expandedClass + '">';
	        html += '<a class="' + activeClass + '" href="' + href + '" ' + clickHandler + '>' + item.name + '</a>';

	        // 하위 메뉴 구성
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
		width: 250px;
		height: 100vh;
		background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
		border-right: 1px solid #e3e6ea;
		font-family: 'Noto Sans KR', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		box-shadow: 3px 0 12px rgba(0, 0, 0, 0.05);
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}

	.menu, .sub-menu {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	.menu-item > a {
		display: flex;
		align-items: center;
		padding: 16px 22px;
		color: #2c3e50;
		font-weight: 500;
		text-decoration: none;
		transition: all 0.25s ease;
		border-left: 4px solid transparent;
	}

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

	.sub-menu {
		display: none;
		background-color: #f9fafb;
		border-left: 1px solid #e5e7eb;
	}

	.menu-item.expanded > .sub-menu {
		display: block;
	}

	.sub-menu-item > a {
		display: block;
		padding: 12px 38px;
		font-size: 0.93em;
		color: #555;
		text-decoration: none;
		transition: all 0.2s ease;
		border-left: 3px solid transparent;
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

	@media (max-width: 768px) {
		#verticalBarWrapper {
			width: 200px;
		}
		.menu-item > a {
			padding: 14px 18px;
			font-size: 0.95em;
		}
		.sub-menu-item > a {
			padding: 10px 30px;
			font-size: 0.9em;
		}
	}
	</style>
</sec:authorize>