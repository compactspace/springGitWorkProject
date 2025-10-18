<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="headerforgetBoard.jsp"%>
<%@ include file="changebodyforgetBoard.jsp"%>

<hr>

<button class="myimg" type="button">게시물 수정하기</button>
<div class="table">
	<div class="table-row-group">
		<div class="table-row">
			<div class="table-cell">${showboard.title}</div>
			<div class="table-cell">${showboard.regdate}</div>
		</div>
		<div class="table-row">
			<div class="table-cell">${showboard.writer}</div>
			<div class="table-cell">${showboard.cnt}</div>
		</div>
		<div class="table-row">
			<div class="table-cell"><img src="/img_board/${showboard.filename}"></div>
			<div class="table-cell">${showboard.content }</div>
		</div>
	
	</div>

</div>






<div id="modalContainer" class="hidden">
	<div id="modalContent">
		<div class="alldivwrapper">
			<div class="imgdiv">
				<h1>
					게시물수정 <img class="imgs" src="img_membership/membership.png">
				</h1>

			</div>
			<div id="loginformwrapper">

				<form action="/insertboard.do" method="post"
					enctype="multipart/form-data">
					<div class="iddiv">
						<textarea name="title" cols="30" row="5"
							palceholder="150글자 까지만등록가능합니다."></textarea>
						<input type="hidden" name="writer" value="${userId}">
						<h3>그림을등록해주세요</h3>
						<!--value="${userVO.id}" 를 지워봄  -->
						<input type="file" name="worklist_img_upload" required>
					</div>
					<div class="passworddiv">
						<h3>그림소개나 후기를 올려주세요</h3>
						<!--value="${userVO.password}" 를 지워봄  -->
						<textarea name="worklist_comment" cols="30" row="5"
							palceholder="150글자 까지만등록가능합니다."></textarea>
					</div>
					<br> <br>
					<div class="login_membershipdivwrapper">
						<!-- 조심해라! form태그 안에 버튼 태그 타입의 디폴트값은 submit으로  현재 로그인 버튼은 서브밋이다. -->
						<h3 style="text-algin: center">주의사항</h3>
						<hr>
						<p>
							여러분의 작품들은 다양한 연령층이 올리고 공유하는 곳이기에 신체노출과 같은 수위가 높은 사진은 관리자에의해
							삭제될수있습니다.<br> 다음은 예시입니다.
						</p>

						<div id="examplecontainer">
							<div id="noimgitems">
								<img class="yesorno" src="./yseornoimg/noimg.png">
								<h3>나쁜예시</h3>
								<p>상반신 기준 쇄골밑 부분은 모자이크 처리를 하여도 관리자에의해 삭제됩니다</p>
							</div>
							<div id="yesimgitems">
								<img class="yesorno" src="./yseornoimg/yesimg.png">
								<h3>옳바른예시</h3>
								<p>상반신 기준 쇄골밑 부분은 삭제 처리를하면 가능합니다.</p>
							</div>
						</div>

						<button class="loginbtn">게시물등록하기</button>
						<br>
						<br>
						<button type="button" class="loginbtn cancelimginsert">게시물등록취소</button>
						<br>
						<br>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>






</body>
</html>