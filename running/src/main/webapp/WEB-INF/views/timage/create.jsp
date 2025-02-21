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

/* 파일 업로드 디자인 */
.file-input-label {
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #f8f9fa;
	border: 2px dashed #008C2C;
	border-radius: 10px;
	padding: 15px;
	cursor: pointer;
	transition: background-color 0.3s ease-in-out;
}

.file-input-label:hover {
	background-color: #e9ecef;
}

.file-input {
	display: none;
}

/* 이미지 미리보기 스타일 */
.preview-container {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 10px;
}

.preview-image {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
	border: 1px solid #ddd;
}

.remove-btn {
	position: absolute;
	top: -5px;
	right: -5px;
	background: red;
	color: white;
	border: none;
	border-radius: 50%;
	width: 20px;
	height: 20px;
	font-size: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.preview-wrapper {
	position: relative;
	display: inline-block;
}
</style>
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="앨범 등록" />
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

					<h2 class="text-center mt-5">팀 앨범 사진 등록</h2>

					<c:url var="imageCreatePage" value="" />
					<form action="${imageCreatePage}" method="post"
						enctype="multipart/form-data" class="p-3">
						<div class="mb-3">
							<label class="form-label fw-bold">팀 ID</label> <input id="teamId"
								name="teamId" value="${teamId}" class="form-control" readonly>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold">사용자 ID</label> <input
								id="userId" name="userId" value="${signedInUserId}"
								class="form-control" readonly>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold">닉네임</label> <input
								id="nickname" name="nickname" type="text"
								value="${signedInUserNickname}" class="form-control" readonly>
						</div>

						<div class="mb-3">
							<label for="file" class="form-label fw-bold">이미지 업로드</label> <input
								type="file" id="file" name="file" accept="image/*" multiple
								class="form-control">
						</div>

						<!-- 업로드한 파일 리스트 -->
						<ul id="fileList" class="list-group list-group-flush mt-2"></ul>

						<!-- 작성 완료 버튼 -->
						<div class="mt-3">
							<div class="text-center mt-4">
								<button type="submit" class="btn btn-success btn-lg px-5"
									style="background-color: #008C2C; border-color: #005A1E; color: white; margin: 0 auto; display: block;">
									작성 완료</button>
							</div>
						</div>
					</form>
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

	<c:url var="createJS" value="/js/timage-create.js" />
	<script src="${createJS}"></script>
</body>
</html>