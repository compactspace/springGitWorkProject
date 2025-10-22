<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .comment-root {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    max-width: 800px;
    margin: 20px auto;
    padding: 0 15px;
  }


  ul {
    list-style: none;
    padding-left: 20px;
    margin: 10px 0;
    border-left: 2px solid #ddd;
  }

  .comment-item {
    margin-top: 30px;
      margin-bottom: 30px;
    position: relative;
    padding-left: 10px;
  }

  .comment-text {
    background: #f9f9f9;
    padding: 10px 12px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    font-size: 14px;
    color: #333;
  }

  .comment-text .nickname {
    font-weight: 600;
    color: #0073e6;
  }

  .comment-cnt {
    display: inline-block;
    margin-top: 4px;
    font-size: 12px;
    color: #666;
    cursor: pointer;
  }

  .reply-btn {
    background-color: #0073e6;
    color: white;
    border: none;
    padding: 4px 10px;
    border-radius: 4px;
    font-size: 12px;
    cursor: pointer;
    margin-left: 10px;
    transition: background-color 0.3s ease;
  }

  .reply-btn:hover {
    background-color: #005bb5;
  }
</style>

<div class="comment-root"></div>

<script>
  // ===== 댓글 데이터 준비 =====
  let data = ${listJson};

  if (typeof data === 'string') {
    data = JSON.parse(data);
  }

  // ===== 댓글 ID → 댓글 객체 Map 생성 =====
  const commentById = new Map();

  function flattenComments(treeData) {
    treeData.forEach(comment => {
      commentById.set(comment.artwork_comment_id, comment);
      if (comment.children && comment.children.length > 0) {
        flattenComments(comment.children);
      }
    });
  }

  flattenComments(data); // 작전: 트리 구조를 평탄화
  console.log("🔥 commentById", commentById);

  // ===== 댓글 트리를 HTML로 렌더링 =====
  function createCommentHTML(comments, openStatus = false) {
    let display = openStatus ? "none" : "block";
    let html = '<ul class="hidded-children" style="display:' + display + ';">';

    comments.forEach(function(comment) {
      let comentCnt = comment.children.length;
   
     

      html += '<li class="comment-item" data-comment-id="' + comment.artwork_comment_id + '">';
      html += '<div class="comment-text">' + comment.comment_text + ' (<span class="nickname">' + comment.user_nickname + '</span>)</div>';

      if (comentCnt > 0) {
        html += '<span class="comment-cnt">답글 ' + comentCnt + '개</span>';
      }

      // 답글 버튼 (부모ID, 조부모ID 저장)
      html += '<span class="reply-btn" data-mygranparentid="' + comment.parent_comment_id + '" data-myparentid="' + comment.artwork_comment_id + '">답글</span>';

      if (comentCnt > 0) {
        html += '<br/><span class="comment-cnt">열기</span>';
      }

      // 자식 댓글 재귀 렌더링
      if (comment.children && comment.children.length > 0) {
        html += createCommentHTML(comment.children, true);
      }

      html += '</li>';
    });

    html += '</ul>';
    return html;
  }

  
  // ===== 초기 렌더링 =====
  const html = createCommentHTML(data);
  $('.comment-root').html(html);

  // ===== 답글 열기/접기 토글 =====
  $(document).on("click", ".comment-cnt", function() {
    let $commentItem = $(this).closest('.comment-item');
    let $hiddedChildren = $commentItem.children('.hidded-children');
    let currentDisplay = $hiddedChildren.css("display");

    if (currentDisplay === "none") {
      $hiddedChildren.show();
      $(this).text("접기");
    } else {
      $hiddedChildren.hide();
      $(this).text("열기");
    }
  });

  // ===== 답글 버튼 클릭 시 작동 =====
  $(document).on('click', '.reply-btn', function () {
    const myParentId = $(this).data('myparentid');
    const myGrandParentId = $(this).data('mygranparentid');

    
   console.log("myParentId: "+myParentId+" myGrandParentId: "+myGrandParentId);
   
    
    
    // 🔥 작전 발동: Map에서 O(1)로 부모/조부모 댓글 찾기
    const parentComment = commentById.get(myParentId);
    const grandParentComment = commentById.get(myGrandParentId);

/*     console.log("🧩 내가 답글 달려는 부모 댓글:", parentComment);
    console.log("🧩 조부모 댓글:", grandParentComment); */

    
    // 🔧 테스트용 자동 답글 객체 생성
    const newReply = {
      comment_text: "💬 테스트로 생성된 자동 답글입니다.",
      user_nickname: "me",
      artwork_comment_id: Date.now(),
      parent_comment_id: myParentId,
      children: []
    };

    // 🔥 작전 발동: 트리 구조에 삽입
    parentComment.children.push(newReply);
    commentById.set(newReply.artwork_comment_id, newReply); // Map 최신화

    // 🔥 작전 발동: DOM에 정확히 삽입
    const newReplyHTML = createCommentHTML([newReply], false);
    var $parentEl = $('[data-comment-id="' + myParentId + '"]');
    console.log($parentEl);
    
    
    
 // 🔥 작전 발동: DOM 트리에도 정확하게 삽입
    let $childList = $parentEl.children('ul.hidded-children');


    
    if ($childList.length === 0) {
      // 댓글 자식 영역이 없으면 새로 만들어서 보여줌
      $childList = $('<ul class="hidded-children" style="display: block;"></ul>');
      $parentEl.append($childList);
    } else {
      // 🔥 댓글 자식 영역이 이미 있지만 닫혀 있으면 펼쳐줌
      if ($childList.css("display") === "none") {
        $childList.show();

        // UX 향상: "열기" → "접기"로 바꿔주기
        $parentEl.find(".comment-cnt").last().text("접기");
      }
    }

    console.log( $childList)
    
    $childList.append(newReplyHTML); // ✨ 최종 삽입

  });
</script>



