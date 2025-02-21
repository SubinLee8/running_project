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
	border: 2px solid #28a745;
	color: #28a745;
	transition: background-color 0.3s, color 0.3s;
}

.custom-btn:hover, .custom-btn:focus, .custom-btn.active {
	background-color: #28a745;
	color: white;
	border-color: #28a745;
}

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

/* 이미지 호버 효과 */
.img-thumbnail {
	transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.img-thumbnail:hover {
	transform: scale(1.05);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

/* 모달 애니메이션 */
.animate-modal {
	animation: fade-in 0.3s ease-in-out;
}

/* 모달 확대 이미지 효과 */
.zoom-in {
	transition: transform 0.3s ease-in-out;
}

.zoom-in:hover {
	transform: scale(1.1);
}
</style>


</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="앨범 목록" />
	</div>
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

					<!-- 소제목 -->
					<h2 class="text-center mt-5">팀 앨범</h2>

					<!-- 앨범 등록 버튼 -->
					<div class="text-start mt-3">
						<c:url var="imageCreatePage"
							value="/teampage/${teamId}/image/create" />
						<a href="${imageCreatePage}" class="btn fw-bold"
							style="background-color: #008C2C; border-color: #005A1E; color: white;">
							앨범 등록 </a>
					</div>

					<!-- 카테고리 선택 -->
					<div class="d-flex align-items-center gap-3 mt-3">
						<div class="form-check">
							<input id="all" name="category" type="radio" value="0" checked
								class="form-check-input"> <label for="all"
								class="form-check-label fw-bold ms-1">전체 보기</label>
						</div>
						<div class="form-check">
							<input id="postImage" name="category" type="radio" value="1"
								class="form-check-input"> <label for="postImage"
								class="form-check-label fw-bold ms-1">게시판 사진만</label>
						</div>
						<div class="form-check">
							<input id="onlyImage" name="category" type="radio" value="2"
								class="form-check-input"> <label for="onlyImage"
								class="form-check-label fw-bold ms-1">앨범 사진만</label>
						</div>
					</div>

					<div id="imageList"></div>

					<!-- 이미지 확대 모달 -->
					<div class="modal fade" id="imageModal" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered"
							style="max-width: 90vw; max-height: 90vh;">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">확대</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body text-center">
									<img id="modalImage" src="" alt="확대된 이미지" class="img-fluid">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 이미지 확대 모달 -->
	<div class="modal fade" id="imageModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered"
			style="max-width: 90vw; max-height: 90vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">확대</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body text-center">
					<img id="modalImage" src="" alt="확대된 이미지" class="img-fluid">
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../fragments/footer.jspf"%>

	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>

	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<script>
		const teamId = '${teamId}'
	</script>
	<c:url var="listJS" value="/js/timage-list.js" />
	<script src="${listJS}"></script>
</body>
</html>