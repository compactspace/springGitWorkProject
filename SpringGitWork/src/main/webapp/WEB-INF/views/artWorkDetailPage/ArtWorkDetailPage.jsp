<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html>
<html>
<sec:csrfMetaTags />
<head>
    <meta charset="UTF-8">
    <title>작품 상세</title>

    <!-- Summernote CSS/JS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script> 
    
    <style>
    
    

    
    .artworkContent-wrapper {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;       
    }

    /* Summernote 기본 에디터 크기 조절 */
    .note-editor.note-frame {
        border: none;
        background-color: transparent;
    }
    
    
    
    

    .note-editable {
        border-radius: 6px;
        padding: 20px;
       height: auto !important;
        background-color: transparent !important;
        font-size: 16px;
        line-height: 1.6;
        color: #333;
    }

.breadcrumb-wrapper {
    background-color: #fff8f0;
  	 max-width: 800px;
        margin: 40px auto;
        padding: 20px;     
        font-size: 20px  
    
}

.breadcrumb {
  
    color: #d2691e;
    font-weight: bold;
}

.breadcrumb a.breadcrumb-link {
    color: #ff7f50;
    text-decoration: none;
}

.breadcrumb a.breadcrumb-link:hover {
    text-decoration: underline;
}

.breadcrumb-current {
    color: #d2691e;
}
    .iput-form {
        display: flex;
        gap: 20px;
        margin-top: 40px;
        border: var(--sui-input-border, 1px solid #c2c6ca);
    border-radius: var(--sui-input-border-radius, 4px);
    padding: var(--sui-input-padding, 5px);
    }

    .input-left {
        flex: 1;
    }

    .input-left textarea {
        width: 100%;
        resize: none;
        font-size: 16px;
        padding: 10px;
        border: none;
        background: none;
        color: #666;
        outline: none;
    }

    .input-right {
        width: 150px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .input-right button {
        padding: 10px;
        font-size: 16px;
        background: none;
        border: none;
        color: #666;
        cursor: pointer;
    }

    .char-count {
        font-size: 14px;
        color: #666;
        text-align: right;
    }
    
    
   #saveBtn {
    text-align: right;
    }
    
</style>    
    
</head>
<body>


<%@ include file="../pcNave.jsp"%>


<div class="breadcrumb-wrapper">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/guest/communityPage" class="breadcrumb-link">커뮤니티</a> &gt; 
        <span class="breadcrumb-current">미술작업물</span>
    </div>
</div>

<div class="artworkContent-wrapper">
<div id="artworkContent">${artWorkDetail.content}</div>
   <div class="iput-form">
    <div class="input-left">
        <textarea id="commentTextarea" maxlength="300" placeholder="댓글을 입력하세요..."></textarea>
    </div>
    <div class="input-right">
        <button id="saveBtn">저장</button>
        <div class="char-count" id="charCount">(300자)</div>
    </div>
</div>

<div class="comment-fragment">
</div>



</div>
<!-- 로그인 안내 모달 -->
<div id="loginModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; 
    background:rgba(0,0,0,0.5); z-index:9999; align-items:center; justify-content:center;">
    <div style="background:#fff; padding:20px; border-radius:6px; max-width:400px; width:90%; text-align:center;">
        <p style="font-size:16px; color:#333;">로그인이 필요한 서비스입니다.<br>로그인 페이지로 이동하시겠습니까?</p>
        <div style="margin-top:20px;">
            <button id="modalYes" style="margin-right:10px; padding:8px 16px; font-size:14px; cursor:pointer;">예</button>
            <button id="modalNo" style="padding:8px 16px; font-size:14px; cursor:pointer;">아니오</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#artworkContent').summernote({
            lang: 'ko-KR',
            toolbar: false,
            airMode: false,
            disableResizeEditor: true,
            height: 300,
            disableDragAndDrop: true,
            shortcuts: false,
            placeholder: '내용이 없습니다.',
            callbacks: {
                onInit: function () {
                    // 읽기 전용 설정
                    $('#artworkContent').next('.note-editor').find('.note-editable').attr('contenteditable', false);
                }
            }
        });        
        
        getMoreArtworkComment();        
        
    });
    
    
    $('#btn').on("click",function(){
    	
    	console.log("click")
    	x();
    })
    

 
 function getMoreArtworkComment(){
	  $.ajax({
      	url:"${pageContext.request.contextPath}/guest/artwork-comment",
      	type:"POST",
      	data:{test:"x"},
      	 success: function(responseHtml) {
      	        // 받아온 HTML을 .comment-fragment 내부에 삽입
      			$('.comment-fragment').append(responseHtml);
      	        
      	        
      	    }
      	
      })
	 
 }
    
    
    
  
    // 로그인 여부 변수 (JSP에서 설정)
    const isAuthenticated = <sec:authorize access="isAuthenticated()">true</sec:authorize><sec:authorize access="!isAuthenticated()">false</sec:authorize>;

    
    if (!isAuthenticated) {
        $('#commentTextarea, #saveBtn').on('click', function (e) {
            e.preventDefault();
            $('#loginModal').css('display', 'flex');  // 모달 열기
        });

        $('#modalYes').on('click', function () {
            window.location.href = '${pageContext.request.contextPath}/guest/login';
        });

        $('#modalNo').on('click', function () {
            $('#loginModal').hide();  // 모달 닫기
        });
        
    }

    else{
    	   
    	 // 실시간 글자 수 표시
    	    $(document).on('input', '#commentTextarea', function () {
    	        const len = $(this).val().length;
    	        $('#charCount').text(len+'/300자');
    	    });

    	    // 저장 버튼 클릭
    	    $('#saveBtn').on('click', function () {
    	        const content = $('#commentTextarea').val().trim();

    	        if (content.length === 0) {
    	            alert("댓글을 입력해주세요.");
    	            return;
    	        }

    	        // Ajax로 서버 전송 (예시)
    	        $.ajax({
    	            url: '${pageContext.request.contextPath}/user/artwork-comment/write',
    	            type: 'POST',
    	            data: { content: content },
    	            success: function (res) {
    	                alert("댓글이 저장되었습니다!");
    	                $('#commentTextarea').val('');
    	                $('#charCount').text('(0/300자)');
    	                // 필요 시 댓글 리스트 새로고침
    	            },
    	            error: function () {
    	                alert("오류가 발생했습니다. 다시 시도해주세요.");
    	            }
    	        });
    	    });
    }
   
    
 


</script>

</body>
</html>
