<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="headerforqna.jsp"%>
<body>
	<div id="wrapper">

		<header>
			<nav>
				<ul class="navul">
					<li><a href="onedayclass.jsp">원데이클래스</a></li>
					<li><a href="getworklist.do">참여자분들의 작품</a></li>

					<li><a href="firstgetboad.do?page=0">여러분의게시판</a></li>
					<c:choose>
					        <c:when test="${userId ne null}">
                    <c:if test="${user_where=='finalluser'}">
                     <li>${userId}님<a href="myinfo.jsp"> 정보수정</li>
                       <li><a href="cartlist.do?id=${userId}">장바구니</a></li>
                       </c:if>
                        <li><a href="cartlist.do?id=${userId}">장바구니</a></li>    
               </c:when>
						<c:otherwise>
							<li><a href="login.jsp">로그인</a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="productlist.do">팬시상품</a></li>
				</ul>
			</nav>
			<!-- nav -->
		</header>
		<!-- header -->
		<br> <br> <br> <br>
		<div id="carousel">
			<div id="carouselimg">
				<h2>여러분의 게시판입니다.</h2>
			</div>
			<br> <br> <br> <br>
			<ul class="menue_ul">
				<li id="gasipanli" class="menue_li">게시판</li>
				<li id="qnali" class="menue_li">Q&A</li>
				<li class="menue_li">NOTICE</li>
			</ul>
		</div>
		<div class="qnawrapper">
			<ul class="qnaul">
				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">학원 방식처럼 등록하고 달단위로 다니는 건가요?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">아닙니다. 등록에 대한 부담감을 덜기위해 무조건 당일 수업만 진행하고
								있습니다.</div>
						</div>
					</div>
				</li>
				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">수업시간은 어떻게 되나요?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">최대 2시간을 원칙으로 하지만 여유있게 작품이 완성되기 직전이면 융통성 있기
								더하는 경우도 많습니다.</div>
						</div>
					</div>
				</li>
				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">수업방식은 어떻게 진행되나요?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">소규모 인원으로(보통은 5명) 진행 되기 때문에 , 여러분이 주제를 고르시면
								제가 한분한분 돌아가며 지도해드리고있습니다.</div>
						</div>
					</div>
				</li>

				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">그림은 초보에요, 수업은 초급반 중급반이 따로 있나요?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">따로 반은 두지 않으며, 학생분들이 원하는 주제와, 실력을 보고 제가 밑그림을
								모두 그려드리는 경우도있습니다.</div>
						</div>
					</div>
				</li>

				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">예약후, 당일날 못가게 되면?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">정당한 사유가 있다면, 최대 2주간은 잡아드리며, 물론 2주 이내로
								환불이가능하십니다.</div>
						</div>
					</div>
				</li>

				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">미술용품이 없어요 구매후 수업에 참여해야하나요?</div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">아닙니다. 원데이클래스 소개글처럼, 수업 진행시간 동안 저희가 대여해드리고
								있습니다.</div>
						</div>
					</div>
				</li>

				<li class="qnali">
					<div class="qusetionli">
						<span>원데이클래스관련</span>
						<div id="q1">그림주제는 자유인가요></div>
						<div class="answerli">
							<span>A</span>
							<div class="a1">가능하십니다. 단, 다양한 연령층이 오시는 경우가 많아, 신체부위 노출이나
								혐오스러운 그림은 저희가 사전에 불가하다 말씀드리고있습니다.</div>
						</div>
					</div>
				</li>

			</ul>
		</div>

	</div>

</body>
</html>