<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<sec:csrfMetaTags />
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            }
        });
    </script>
<meta charset="UTF-8">
<title>${workDetail.title}-작품 상세</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

.container {
	justify-content: center;
	max-width: 600px;
	margin: 40px auto;
	background: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 30px;
	border-radius: 8px;
	display: flex;
	flex-direction: row;
	align-items: flex-start;
}



.right-sub-container{
	max-width: 320px;
    min-width: 300px;
}

.left-content {
	max-width: 250px;
	/*  min-height: 800px;
    max-height: 800px; */
	overflow-y: auto;
}

.left-content {
	flex: 2;
	padding-right: 20px;
	border-right: 1px solid #eee;
}

.right-comment {
	display: flex;
	flex-direction: column;
	max-height: 600px; /* 또는 원하는 높이 */
	position: relative;
	overflow-y: auto;
}

.bottom-message {
	text-align: right;
	margin-top: auto;
	padding: 10px 0;
	color: #666; /* 약간 어두운 회색 */
	font-size: 14px;
}

.bottom-message .login-highlight {
	color: #4a90e2; /* 은은한 파랑 (iOS 기본 블루 느낌) */
	font-weight: 600;
	cursor: pointer;
	transition: color 0.3s ease;
}

.bottom-message .login-highlight:hover {
	color: #357ABD; /* 살짝 더 진한 파랑으로 hover 효과 */
	text-decoration: underline;
}

.title {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 10px;
}

.meta {
	color: #666;
	font-size: 14px;
	margin-bottom: 20px;
}

.thumbnail {
	width: 100%;
	max-width: 500px;
	border-radius: 5px;
	margin-bottom: 20px;
}

.content {
	font-size: 16px;
	line-height: 1.6;
}

.right-comment h3 {
	margin-top: 0;
	font-size: 18px;
	margin-bottom: 15px;
}

.comment {
	border-bottom: 1px solid #eee;
	padding: 10px 0;
}

.comment:last-child {
	border-bottom: none;
}

.comment-author {
	font-weight: bold;
}

.comment-text {
	margin-top: 5px;
	font-size: 14px;
}

.comment-author,.comment-date{
font-size: 14px;
}


.children-cnt{
font-size: 12px;
display: inline-block;
    width: 100%;
    margin: 0 auto;
    text-align: center;
    padding: 10px 0px;
}


#createContent {
	resize: none;
	overflow: hidden;
}

#createContent {
	/*     width: 100%; */
	box-sizing: border-box;
	font-size: 14px;
	line-height: 1.4;
	/* padding: 12px 15px; */
	margin-left: 25px;
	border: 1.5px solid #ccc;
	border-radius: 6px;
	resize: vertical;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
	min-height: 100px;
	margin-top: 10px;
}

#createContent:focus {
	border-color: #4a90e2;
	outline: none;
	box-shadow: 0 0 6px rgba(74, 144, 226, 0.5);
}

.input-container {
	display: flex;
	align-items: flex-end;
	margin-top: 10px;
	padding: 0 25px;
	gap: 8px;
}

#submitBtn {
	background-color: #4a90e2;
	color: white;
	border: none;
	padding: 10px 16px;
	font-size: 14px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	height: fit-content;
}

#submitBtn:hover {
	background-color: #357ABD;
}

/*   /* 반응형 */
@media ( max-width : 768px) {
	.container {
		flex-direction: column;
	}
	.left-content, .right-comment {
		padding: 0;
		border: none;
	}
	.left-content {
		margin-bottom: 30px;
	}
}

* /
	/* 모달 내부 기본 스타일 */  
#replyModal p {
	font-size: 16px;
	font-weight: 600;
	margin-bottom: 10px;
	color: #333;
}

#replyModal textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	font-size: 14px;
	border: 1.5px solid #ccc;
	border-radius: 6px;
	resize: vertical;
	box-sizing: border-box;
	transition: border-color 0.3s ease;
}

#replyModal textarea:focus {
	border-color: #4a90e2;
	outline: none;
	box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
}

/* jQuery UI 다이얼로그 버튼 스타일 커스터마이징 */
.ui-dialog-buttonpane {
	text-align: right;
	padding: 10px 15px;
	background-color: #f9f9f9;
	border-top: 1px solid #ddd;
}

.ui-dialog-buttonpane button {
	background-color: #4a90e2;
	color: white;
	border: none;
	padding: 8px 16px;
	margin-left: 10px;
	font-size: 14px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.ui-dialog-buttonpane button:hover {
	background-color: #357ABD;
}

/* 취소 버튼만 별도 스타일 */
.ui-dialog-buttonpane button:last-child {
	background-color: #ccc;
	color: #333;
}

.ui-dialog-buttonpane button:last-child:hover {
	background-color: #aaa;
}



    #mobileNave{

  display: none;
}

/*모바일 시작  */
@media screen and (max-width: 760px) {


    /* 네비게이션 전환 */
    #pcNave {
        display: none;
    }
    #mobileNave {
        display: block;
    }
}
/*모바일 종료  */


</style>




<script>
  var isAuthenticated = false;
  
  var iscommenWriteLockUser="false"
</script>
<sec:authorize access="isAuthenticated()">
	<script>
  isAuthenticated = true;
</script>
</sec:authorize>

<script>
let offset = 0;
const limit = 10;
let buildedTreeData=null





    // HTML 특수문자 치환 함수 (XSS 방지)    
    var work_ID=null
  function escapeHtml(text) {
    if (!text) return '';
    return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

    
  function buildCommentHtml(comments) {
	  
	    if (!comments || comments.length === 0) return '';
	    
	    
	    let html = '<ul class="comment-list">';
	    comments.forEach(comment => {
	    let	parent_id=null;
	    let 최상위댓글기준자식갯수=0;
	   	//	console.log("parent_id: "+comment?.parent_id);
	   	//	console.log(comment.children);
	   		
	   		최상위댓글기준자식갯수=comment?.children.length;	   		
	   			//console.log("최상위댓글기준자식갯수: "+최상위댓글기준자식갯수)
	   		
	   		
	    	if(comment?.parent_id!=undefined && comment.parent_id!=null){
	    		parent_id=comment.parent_id;
	    	}
	    	html += 
	    	    '<li class="comment">' +
	    	    '<div class="comment-meta" data-comment_id="' + comment.comment_id + '" data-parent_id="' + parent_id + '">' +
	    	            '<span class="comment-author">' + comment.user_code + '</span> | ' +
	    	            '<span class="comment-date">' + formatDate(comment.created_at) + '</span>' +	    	            
	    	            (isAuthenticated&&iscommenWriteLockUser==='false'?'<span class="coment_write"> 답글 </span>':'')
	    	             +
	    	        '</div>' +
	    	        '<div class="comment-text">' + escapeHtml(comment.content)+ '</div>' +
	    	        (comment.children && comment.children.length > 0 ?
	    	        		'<span class="children-cnt" data-isOpen="open"> 답글'+최상위댓글기준자식갯수 +'개 모두보기 </span>'
	    	        		
	    	        		:'')
	    	      +
	    	        '<div class="hided-children" style="' + 
	    	           (comment.children && comment.children.length > 0 ? 'display:none;' : '') + 
	    	           '">' +
	    	        (comment.children && comment.children.length > 0 ? buildCommentHtml(comment.children) : '') +
	    	        '</div>' +
	    	    '</li>';

	    });
	    html += '</ul>';
	    return html;
	    
	}
  
  
  function findParentCommentBranch(parentId) {
	    const $commentMetaHtmlTags = $('.comment-meta');
	    let parentHtmlTag = null;

	    
	    $commentMetaHtmlTags.each(function () {
	        const $this = $(this);
	        //최상위는 parent_id 가 null 이니깐
	        const dataParentId = $this.data('parent_id')||$this.data('comment_id');

	        // parent_id는 숫자거나 문자열일 수 있어서 타입 일치 주의
	        if (String(dataParentId) === String(parentId)) {
	        	
	        	  // 📌 부모 댓글의 .comment-text 내용 가져오기
	            const $closestLi = $this.closest('li.comment');
	            const $commentText = $closestLi.find('.comment-text').first();
	            const commentTextContent = $commentText.text().trim();

	        	
	        	
	        	 //  console.log('✅ 일치! parentId:', parentId, '== data-parent_id:', dataParentId, '📝 부모 댓글 내용:', commentTextContent);
	            parentHtmlTag = $this;
	            return false; // break out of .each() loop
	        }
	    });

	    return parentHtmlTag;
	}

  
  
  
  function addParentBranchAsChildrenWithNoRefetching(parentHtmlTag, commentId, commentContent) {
	    if (!parentHtmlTag || parentHtmlTag.length === 0) {
	        console.warn('❌ 부모 태그를 찾을 수 없습니다.');
	        return;
	    }

	    var $parentLi = parentHtmlTag.closest('li.comment');
	    var $hidedChildren = $parentLi.find('.hided-children').first();

	    if ($hidedChildren.length === 0) {
	        console.warn('❌ .hided-children 요소가 없습니다.');
	        return;
	    }

	    // 숨겨져 있다면 보이게
	    $hidedChildren.show();

	    // ✅ 새로운 자식 댓글 HTML 구성 (최소한의 정보로)
	    var replyHtml = ''
	        + '<li class="comment">'
	        +   '<div class="comment-meta" data-comment_id="' + commentId + '" data-parent_id="' + parentHtmlTag.data('comment_id') + '">'
	        +     '<span class="comment-author">(나)</span> | '
	        +     '<span class="comment-date">방금 전</span>'
	        +   '</div>'
	        +   '<div class="comment-text">' + escapeHtml(commentContent) + '</div>'
	        + '</li>';

	    // DOM 삽입
	    $hidedChildren.append(replyHtml);

	  
	}
  
  
  
  
  function findCurrentTopLevelCommentId() {
	    const $commentMetaHtmlTags = $('.comment-meta');
	    let currentMaxCommentId = null;

	    $commentMetaHtmlTags.each(function(index, el) {
	        const $el = $(el);
	        const parentId = $el.data("parent_id");

	        if (!parentId) { // parent_id가 없으면 최상위 댓글
	            const commentId = parseInt($el.data("comment_id"), 10);

	            if (currentMaxCommentId === null || commentId > currentMaxCommentId) {
	                currentMaxCommentId = commentId;
	            }
	        }
	    });

	    return currentMaxCommentId;
	}
  
  
  
  function addTopLevelBranchWithNoRefetching(insertedCommentId,comment) {
	    // 현재 페이지 내의 최상위 댓글 요소만 필터링
	    var $topLevelCommentItems = $('li.comment').filter(function () {
	        var parentId = $(this).find('> .comment-meta').data('parent_id');
	        return parentId === "" || parentId === null || parentId === undefined;
	    });

	    
	    // 삽입할 새 댓글 템플릿
	    var newCommentHtml = ''
	        + '<li class="comment">'
	        +   '<div class="comment-meta" data-comment_id="' + insertedCommentId + '" data-parent_id="">'
	        +     '<span class="comment-author">(나)</span> | '
	        +     '<span class="comment-date">방금 전</span>'
	        +   '</div>'
	        +   '<div class="comment-text">'+comment+'</div>'
	        +   '<ul class="hided-children" style="display:none;"></ul>'
	        + '</li>';

	    // 최상단에 삽입 (첫 번째 최상위 댓글 앞에)
	    if ($topLevelCommentItems.length > 0) {
	        $topLevelCommentItems.first().before(newCommentHtml);
	    } else {
	        // 최상위 댓글이 없다면, ul.comment-list가 있다고 가정하고 거기에 추가
	        $('.comment-list').prepend(newCommentHtml);
	    }

	   // console.log('✅ 단발성으로 최상위 댓글 맨 위에 추가됨:', insertedCommentId);
	}  

  
  
  function formatDate(timestamp) {
	    const date = new Date(timestamp);
	    return date.toLocaleString(); // 예: "2025. 10. 13. 오후 5:44"
	}

 
    // 페이지 로드 시 AJAX로 댓글 가져와서 렌더링 예시
    window.onload = () => {  
    	iscommenWriteLockUser="${commentWriteLockUser}";
    	work_ID="${workDetail.work_id}";

    	  
        $("#loadMoreBtn").on("click", function () {        		
        	  fetchGetMoreWorkComments(true); // append 모드
        	});        
        
    	
    	//console.log("work_ID: "+work_ID);    	
    	 offset = 0;
    	  fetchGetMoreWorkComments(false); // 처음은 전체 초기화
    };   
    
    const fetchGetMoreWorkComments = (append = false) => {
    	  $.ajax({
    	    url: "${pageContext.request.contextPath}/api/guest/get-more-work-comments",
    	    type: "GET",
    	    data: {
    	      work_id: work_ID,
    	      limit: limit,
    	      offset: offset
    	    },
    	    dataType: "json",
    	    success: function (data) {
    	      const commentsContainer = document.querySelector(".comments-container");
    	      const commentHtml = buildCommentHtml(data);
    	    
    	      
    	      if (append) {
    	        commentsContainer.insertAdjacentHTML("beforeend", commentHtml);
    	      } else {
    	        commentsContainer.innerHTML = commentHtml;
    	      }

    	      offset += limit;

    	      // 더 가져올 댓글이 없으면 버튼 숨기기
    	      if (data.length < limit) {
    	        $("#loadMoreBtn").hide();
    	      }

    	      eventResister(); // 클릭 이벤트 재연결
    	    },
    	    error: function () {
    	      alert("댓글 불러오기 실패");
    	    }
    	  });
    	};

    
    const eventResister = () => {
    	 $(".coment_write").on("click", function () {
            const commentMeta = $(this).closest(".comment-meta");
            const parent_ID = commentMeta.data("parent_id");
            const comment_ID = commentMeta.data("comment_id");
            const userCode = commentMeta.find(".comment-author").text().replace("사용자 코드: ", "").trim();

            
          //  console.log("parent_ID:", parent_ID);
           // console.log("comment_ID:", comment_ID);
           // console.log("userCode:", userCode);
            
            
            $("#replyToUser").text(userCode);

            $("#replyModal").dialog({
                modal: true,
                width: 400,
                buttons: {
                    "작성": function () {
                        const comment = $("#replyContent").val();

                        if (isEmpty(comment)) {
                            alert("댓글 내용을 입력해주세요.");
                            return;
                        }

                        if (comment.trim().length > 2200) {
                            alert("댓글은 최대 2200자까지 입력할 수 있습니다.");
                            return;
                        }                        
        

                        $.ajax({
                            url: "${pageContext.request.contextPath}/api/users/write-work-comments",
                            type: "POST",
                            dataType: "json",
                            data: {
                                parentId: comment_ID ,
                                commentId: comment_ID || null,
                                workId: work_ID,
                                comment: comment.trim()
                            },
                            
                            success: function (data) {
                        //   	console.log("댓댓글 등록되었습니다.")
                                $("#replyContent").val('');
                                $("#replyModal").dialog("close");
                            /*     console.log(buildedTreeData) */
                            
                       let commentId = data.commentId;
                       let targetParentId = parent_ID || comment_ID;

                            
    const parentHtmlTag = findParentCommentBranch(targetParentId);
    

    addParentBranchAsChildrenWithNoRefetching(parentHtmlTag, commentId, comment.trim());
    
                            
                            
                    /*             fetchGetMoreWorkComments(); */
                                
                                
                            },
                            error: function (xhr, status, error) {
                                alert("댓글 등록에 실패했습니다.");
                            }
                        });
                    },
                    "취소": function () {
                        $("#replyContent").val('');
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    $("#replyContent").val('');
                    $("#replyContent").focus();
                }
            }); // <=== 이 부분 닫힘 괄호와 세미콜론 추가
        });
        
         
        
         
         
 
        $(".children-cnt").on("click",function (){       
        
        	
        	//   let $btn = $(this) 자바스크립트 변수왼쪽에 $ 가 붙으면 dom객체가 아닌 제이쿼리 객체를 담고있단
        	// 의미의 개발자들의 관례(convention)다.
        	
        	 let $btn = $(this);
        	    let $childrenBox = $btn.next(".hided-children");

        	    // 기본 상태는 close (접혀 있음)
        	    let toggleStatus = $btn.data("isopen") || "close";
        	    let currentText = $btn.text();

        	    if (toggleStatus === "open") {
        	        // 열려있을 경우 → 접기
        	        $btn.data("isopen", "close");
        	        $childrenBox.hide();

        	        // '접기' → '모두보기'로 변경
        	        $btn.text(currentText.replace("접기", "모두보기"));
        	      
        	    } else {
        	        // 닫혀있을 경우 → 열기
        	        $btn.data("isopen", "open");
        	        $childrenBox.show();

        	        // '모두보기' → '접기'로 변경
        	        $btn.text(currentText.replace("모두보기", "접기"));
        	   
        	    }

        })
        
        
        
        $(function () {
        	  const $textarea = $("#createContent");
        	  const $submitBtn = $("#submitBtn");

        	  // 자동 높이 조절 함수
        	  function autoResize(el) {
        	    el.style.height = 'auto';
        	    el.style.height = el.scrollHeight + 'px';
        	  }

        	  // textarea 입력 이벤트: 자동 줄바꿈
        	  $textarea.on("input", function () {
        	    autoResize(this);
        	  });

        	  // Shift + Enter 줄바꿈 / Enter → 전송
        	  $textarea.on("keydown", function (e) {
        	    if (e.key === "Enter" && !e.shiftKey) {
        	      e.preventDefault(); // 기본 Enter 줄바꿈 막기
        	      $submitBtn.click(); // 전송 버튼 클릭
        	    }
        	  });

        	  // 전송 버튼 클릭 이벤트 (ajax 전송 예시)
        	  $submitBtn.on("click", function () {
        	    const comment = $textarea.val().trim();

        	    if (comment === '') {
        	      alert("댓글을 입력해주세요.");
        	      return;
        	    }
        	    
        	    
        	    
        	    // 🔻 여기에 실제 전송 AJAX 호출 추가
        	    $.ajax({
        	      url: "${pageContext.request.contextPath}/api/users/write-work-comments",
        	      type: "POST",
        	      dataType: "json",
        	      data: {
        	    	parentId: 0,
        	        workId:  work_ID,
        	        comment: comment
        	      },
        	      
        	      success: function (res) {
        	    	//  console.log(res)
        	    	  
        	    	  if(res.success){
        	     //   console.log("댓글이 등록되었습니다.");
        	        $textarea.val('');
        	        autoResize($textarea[0]);   
        	        
        	        let currnetTopLevelCommentId=findCurrentTopLevelCommentId();
        	        
        	        addTopLevelBranchWithNoRefetching(currnetTopLevelCommentId,comment);
        	      /* fetchGetMoreWorkComments(true); */
        	      
        	      
        	      
        	        
        	    	  }
        	        // 새로고침 없이 댓글 다시 불러오고 싶다면 여기서 다시 ajax로 댓글 불러오기 호출
        	      },
        	      error: function () {
        	        alert("댓글 등록 실패");
        	      }
        	    });
        	  });

        	  // 초기 높이 설정
        	  autoResize($textarea[0]);
        	});      
        
        
      


        
    };
    
    
    function isEmpty(value) {
    	  return value === undefined || value === null || value.trim() === '';
    	}
    
    
    
    
    //나중에 따로 보안한뒤 eventResister 메서드 속에서 호출하자.
    //지금은 그냥 버튼으로 페이징 처리를 한다.
/*     function  verticalSocrollGetCommentList(){
    	
    	 
        $(document).ready(function () {
        	  const $commentContainer = $(".right-comment");
        	  let isLoading = false;
        	  const THRESHOLD = 10;

        	  // 디바운스 함수
        	  function debounce(fn, delay) {
        	    let timer = null;
        	    return function (...args) {
        	      clearTimeout(timer);
        	      timer = setTimeout(() => fn.apply(this, args), delay);
        	    };
        	  }

        	  const handleScroll = debounce(function () {
        	    const scrollTop = $commentContainer.scrollTop();
        	    const scrollHeight = $commentContainer[0].scrollHeight;
        	    const containerHeight = $commentContainer.outerHeight();
        	    
        	//    console.log("areAllCommentsClosed():"+areAllCommentsClosed());
        	    
        	    if(!areAllCommentsClosed())return;
        	    
        	    if (scrollTop + containerHeight >= scrollHeight - THRESHOLD) {
        	      if (!isLoading) {
        	        isLoading = true;
        	      //  console.log("📌 하단 도달: API 호출 시작");

        	        loadMoreComments()
        	          .then((result) => {
        	            //console.log("✅ 결과:", result);
        	            isLoading = false;
        	          })
        	          .catch((err) => {
        	          //  console.error("❌ 실패:", err);
        	            isLoading = false;
        	          });
        	      }
        	    }
        	  }, 200);

        	  $commentContainer.on("scroll", handleScroll);

        	  // ✅ 실제 API 호출 함수 (성공 시 "success", 실패 시 "fail" 반환)
        	  function loadMoreComments() {
        	    return new Promise((resolve, reject) => {
        	      $.ajax({
        	        url: "/comments/loadMore", // 🔁 여기에 실제 API 경로 설정
        	        method: "GET",
        	        dataType: "json", // 서버 응답 형식이 JSON이라고 가정
        	        success: function (res) {
        	          if (res && res.status === "success") {
        	            // 여기에 댓글 DOM 추가 로직이 있으면 삽입
        	            // 예: $(".right-comment").append(res.html);
        	            resolve("success");
        	          } else {
        	            resolve("fail");
        	          }
        	        },
        	        error: function () {
        	          reject("fail");
        	        }
        	      });
        	    });
        	  }
        	});
    	
    	
    } */
    
    
    
    
    
    function areAllCommentsClosed() {
    	  let allClosed = true;
    	  $(".children-cnt").each(function() {
    		 // console.log($(this).data("isopen"));
    		  
    	    if ($(this).data("isopen") === "open") {
    	      allClosed = false;
    	      return false; // 반복 중단
    	    }
    	  });
    	  return allClosed;
    	}

    

</script>




</head>
<body>

 	<div id="pcNave">
 <%@ include file="../pcNave.jsp"%>
</div>
<div id="mobileNave">
 <%@ include file="../mobileNave.jsp"%>
</div>

	<!-- 컨테이너 시작 -->
	<div class="container">

		<!-- 왼쪽: 작품 상세 -->
		<div class="left-content">
			<div class="title">${workDetail.title}</div>

			<div class="meta">작성자 코드: ${workDetail.user_code} | 작성일:
				${workDetail.created_at}</div>

			<img class="thumbnail"
				src="${pageContext.request.contextPath}/resources/${workDetail.thumbnail_url}"
				alt="작품 썸네일" />

			<div class="content">${workDetail.content}</div>
		</div>



		<div class="right-sub-container">
			<div class="right-comment">
				<!-- <h3>댓글</h3> -->
				<!-- 댓글들만 넣는 별도 영역 -->
				<div class="comments-container"></div>
			</div>


<div class="load-more-wrapper" style="text-align: center; margin-top: 10px;">
  <div id="loadMoreBtn">댓글 더보기</div>
</div>


			<div class='create-comment-inputfield'>
				<sec:authorize access="!isAuthenticated()">
					<div class="bottom-message">
						댓글을 남기시려면 <span class="login-highlight">로그인</span>
					</div>
					<script>
  document.querySelector('.login-highlight').addEventListener('click', function() {
    // 로그인 페이지로 이동
    window.location.href = '${pageContext.request.contextPath}/guest/login';
  });
</script>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">				
				
    <c:choose>
    
     <c:when test="${commenWriteLockUser eq 'true'}">
            <div class="comment-restrict-message">
            ${commenWriteLockUser}
            ${commenWriteLockUser eq 'true'}
            
                <p style="color:red;">댓글 작성이 제한되었습니다. 관리자에게 문의하세요.</p>
            </div>
        </c:when>
        <c:otherwise>
        
      
           
            <div class="input-container">
                <textarea id="createContent" rows="1" placeholder="댓글을 작성하세요..."></textarea>
                <button id="submitBtn" type="button">전송</button>
            </div>
        </c:otherwise>
    </c:choose>
</sec:authorize>


			</div>



		</div>



	</div>
	<!-- 컨터이너 종료 -->

	<!-- 답글 작성 모달 -->
	<div id="replyModal" title="댓글 작성" style="display: none;">
		<p>
			<span id="replyToUser"></span>님에게
		</p>
		<textarea id="replyContent" rows="5" style="width: 100%;"></textarea>
	</div>

</body>
</html>
