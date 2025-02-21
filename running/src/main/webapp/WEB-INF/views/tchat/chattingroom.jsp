<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅룸</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
.custom-btn {
	display: inline-block; /* 버튼이 정상적으로 스타일을 갖도록 변경 */
	background-color: transparent;
	border: 2px solid #008C2C;
	color: #008C2C;
	transition: background-color 0.3s, color 0.3s;
	padding: 8px 16px; /* 버튼 크기 조절 */
	text-align: center;
	text-decoration: none; /* 링크 밑줄 제거 */
	border-radius: 5px; /* 버튼 모서리 둥글게 */
}

.custom-btn:hover, .custom-btn:focus, .custom-btn.active {
	background-color: #008C2C;
	color: white;
	border-color: #008C2C;
}

.chat-container {
	display: flex;
	flex-direction: column;
	align-items: center; /* 내부 요소 가로 정렬 */
	justify-content: center; /* 내부 요소 세로 정렬 */
	width: 100%; /* 부모 컨테이너를 꽉 채우도록 설정 */
}

.chat-box {
	width: 100%;
	max-width: 600px; /* 채팅 박스 최대 너비 설정 */
	height: 500px; /* 채팅창 높이 고정 */
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 10px;
	background: #f8f9fa;
	overflow-y: auto; /* 스크롤 가능 */
}


.input-group {
	max-width: 600px; /* 입력 필드의 최대 너비 설정 */
}

.message {
	margin-bottom: 10px;
	padding: 10px;
	border-radius: 8px;
	max-width: 80%;
	word-wrap: break-word;
}

.message.user {
	background-color: #d1e7dd; /* 부트스트랩의 text-success 색상 */
	align-self: flex-end;
}

.message.other {
	background-color: #e9ecef;
	align-self: flex-start;
}

.meta {
	font-size: 12px;
	color: #6c757d;
}
</style>
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 border-0">
					<div class="btn-group" role="group" aria-label="Button group">
						<c:url var="teamPage" value="/team/details">
							<c:param name="teamid" value="${teamId}" />
						</c:url>
						<a href="${teamPage}" class="btn custom-btn">내 팀으로</a>

						<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
						<a href="${postListPage}" class="btn custom-btn">팀 게시판</a>

						<c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
						<a href="${imageListPage}" class="btn custom-btn">팀 앨범</a>

						<c:url var="calendarListPage"
							value="/teampage/${teamId}/tcalendar/list" />
						<a href="${calendarListPage}" class="btn custom-btn">팀 일정 게시판</a>

						<c:url var="chatPage" value="/teampage/${teamId}/chat" />
						<a href="${chatPage}" class="btn custom-btn">채팅방</a>
					</div>

					<h2 class="text-center mt-5">팀 채팅방</h2>

					<div class="chat-container">

						<!-- 채팅 메시지 표시 영역 -->
						<div id="chatBox" class="chat-box d-flex flex-column p-3"></div>


						<!-- 메시지 입력 & 버튼 -->
						<div class="input-group mt-3">
							<input id="textMessage" type="text" class="form-control"
								placeholder="메시지를 입력하세요..." onkeypress="handleKeyPress(event)">
							<button class="btn btn-success" id="submitButton">전송</button>
							<!--<button class="btn btn-danger" onclick="disconnect()">Disconnect</button>-->
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>

	<%@ include file="../fragments/footer.jspf"%>
	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
		const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
		const signedInUserNickname = '${signedInUserNickname}';
		const teamId = '${teamId}';
	</script>
	<c:url value="/js/chatroom.js" var="teamCreateJs" />
	<script src="${teamCreateJs}"></script>

	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>

</html>