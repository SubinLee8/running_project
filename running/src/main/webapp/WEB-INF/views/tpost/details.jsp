<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Running</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
/* 내팀으로, 팀게시판, 팀앨범, 팀일정게시판 버튼 */
.custom-btn {
	background-color: transparent;
	border: 2px solid #008C2C;
	color: #008C2C;
	transition: background-color 0.3s, color 0.3s;
}

.custom-btn:hover, .custom-btn:focus, .custom-btn.active {
	background-color: #008C2C;
	color: white;
	border-color: #008C2C;
}
</style>

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="팀 게시글 상세보기" />
	</div>
	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4">

					<!-- 버튼 그룹 -->
					<div class="btn-group mb-3" role="group" aria-label="Button group">
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
						<a href="${calendarListPage}" class="btn custom-btn">팀 일정</a>

						<c:url var="chatPage" value="/teampage/${teamId}/chat" />
						<a href="${chatPage}" class="btn custom-btn">채팅방</a>
					</div>

					<!-- 작성자 정보 -->
					<div class="d-flex align-items-center text-muted small mb-3">
						<img class="rounded-circle me-2"
							src="/running/image/view/user/${post.userId}" alt="avatar"
							width="35" height="35"> <span>${post.nickname} •
							${post.formattedCreatedTime}에 작성</span>
					</div>

					<!-- 제목 -->
					<h3 class="fw-bold mb-4">${post.title}</h3>

					<!-- 내용 -->
					<p class="mb-4">${post.content}</p>

					<!-- 조회수 및 날짜 정보 -->
					<div class="row">
						<div class="col-md-6 text-muted">
							<strong>조회수:</strong> ${post.viewCount}
						</div>
						<!-- <div class="col-md-6 text-muted text-end">
							<strong>작성일:</strong> ${post.createdTime}
						</div>-->
					</div>

					<hr>

					<!-- 첨부파일 섹션 -->
					<div class="mt-4">
						<h5 class="text-success fw-bold">첨부파일</h5>
						<c:choose>
							<c:when test="${empty images}">
								<p class="text-muted">등록된 파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<ul class="list-group list-group-flush">
									<c:forEach var="image" items="${images}">
										<li class="list-group-item d-flex align-items-center"><c:url
												value="/teampage/${teamId}/image/view/${image.uniqName}"
												var="listPage"></c:url> <img alt="${image.originName}"
											class="rounded me-2" src="${listPage }"
											style="width: 50px; height: 50px;"> <span
											class="me-auto">${image.originName}</span> <c:url
												var="imageDownloadPath"
												value="/teampage/${teamId}/image/download/${image.uniqName}" />
											<a class="btn btn-sm btn-outline-primary"
											href="${imageDownloadPath}">다운로드</a></li>
									</c:forEach>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>

					<hr>

					<!-- 수정 및 삭제 버튼 -->
					<c:if test="${signedInUserId eq post.userId}">
						<div class="text-center mt-3">
							<c:url var="postUpdatePage"
								value="/teampage/${post.teamId}/post/${post.id}/update" />
							<a class="btn btn-outline-success me-2" href="${postUpdatePage}">수정</a>
							<button class="btn btn-danger" id="btnDelete">삭제</button>
						</div>
					</c:if>

				</div>
			</div>
		</div>
	</div>


	<!-- comment 작성 -->
	<c:if test="${not empty signedInUserNickname}">
		<div class="container my-1 py-1">
			<div class="row d-flex justify-content-center">
				<div class="col-md-12 col-lg-10 col-xl-8">
					<div class="card p-4">
						<div class="comment-container mt-3">
							<div class="d-flex flex-start">
								<!-- 유저 프로필 이미지 -->
								<img class="rounded-circle shadow-1-strong me-3"
									src="/running/image/view/user/${signedInUserId}" alt="avatar"
									width="65" height="65" />

								<div class="flex-grow-1 flex-shrink-1">
									<div>
										<div class="d-flex justify-content-between align-items-center">
											<p class="mb-1 fw-bold">${signedInUserNickname}</p>
										</div>

										<!-- 댓글 작성 폼 -->
										<div class="mb-3">
											<textarea class="form-control" id="ctext" rows="3"
												placeholder="댓글을 입력하세요..."></textarea>
										</div>


										<!-- 댓글 작성 버튼 -->
										<button type="submit" class="btn btn-primary btn-sm"
											id="btnRegisterComment">댓글 작성</button>
									</div>
								</div>
							</div>
							<!-- d-flex 종료 -->
						</div>
						<!-- comment-container 종료 -->
					</div>
					<!-- card 종료 -->
				</div>
			</div>
		</div>
	</c:if>







	<!-- 댓글 목록 -->
	<section class="gradient-custom mt-4" id="commentSection"></section>

	<!-- 페이지네이션 -->
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center" id="pagination">
			<!-- 페이지네이션 버튼이 여기에 삽입됩니다 -->
		</ul>
	</nav>



	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
	<script>
		const teamId = '${post.teamId}';
		const postId = '${post.id}';
		const signedInUserId = '${signedInUserId}';
		const signedInUserNickname = '${signedInUserNickname}';
		const userId = '${post.userId}';
	</script>

	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url var="detailsJS" value="/js/tpost-details.js" />
	<script src="${detailsJS}"></script>
</body>
</html>