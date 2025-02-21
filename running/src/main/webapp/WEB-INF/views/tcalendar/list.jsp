<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Running</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

/* 새글 작성 버튼 */
.btn-create {
	background-color: #008C2C;
	color: white;
	border: 1px solid #008C2C;
}

.btn-create:hover {
	background-color: #218838; /* 마우스를 올렸을 때의 조금 어두운 색상 */
	color: white;
}

.float-right {
	float: right; /* 오른쪽에 위치 */
}

/* 게시글 카드 */
.card-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px; /* 카드 사이의 간격 조정 */
}

.col-md-6 {
	flex: 1 1 calc(50% - 20px); /* 카드가 두 칼럼으로 배치됨 */
	max-width: calc(60% - 20px); /* 카드의 최대 너비 설정 */
	box-sizing: border-box; /* 패딩과 보더를 포함한 크기 계산 */
}

.filter-form {
	margin-bottom: 20px; /* 원하는 여백 값으로 설정 */
}

.font-weight-bold {
	font-weight: bold;
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* 페이징 버튼 */
/* 클릭된 페이지 번호 버튼에 대해 색상과 배경 색상 변경 */
.page-item.active .page-link {
	color: #28a745; /* 텍스트 색상 */
	background-color: transparent; /* 배경색을 투명하게 유지 */
	border-color: #28a745; /* 테두리 색상 */
}

/* 페이지 링크가 클릭되었을 때 */
.page-link:active {
	color: #28a745; /* 클릭했을 때 텍스트 색상 */
	background-color: transparent; /* 클릭했을 때 배경색 */
	border-color: #28a745; /* 클릭했을 때 테두리 색상 */
}
</style>

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="팀 일정 게시글 목록" />
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

					<h2 class="text-center mt-5">팀 일정 게시판</h2>

					<!-- 새글 생성 버튼 (팀장만 보이게) -->
					<div class="text-end mt-3">
						<c:url var="calendarCreatePage"
							value="/teampage/${teamId}/tcalendar/create" />
						<c:if test="${isTeamLeader}">
							<a href="${calendarCreatePage}" class="btn btn-success">새글 생성</a>
						</c:if>
					</div>

					<!-- 필터링 콤보박스 -->
					<c:url value="/teampage/${teamId}/tcalendar/list" var="ListPage" />
					<form action="${ListPage}" method="get"
						style="margin-bottom: 20px;">
						<label for="filter">검색:</label> <select name="filter" id="filter"
							onchange="this.form.submit()">
							<option value="1" ${filter == '1' ? 'selected' : ''}>전체</option>
							<option value="2" ${filter == '2' ? 'selected' : ''}>모집중인
								게시글</option>
							<option value="3" ${filter == '3' ? 'selected' : ''}>모집종료된
								게시글</option>
						</select>
					</form>

					<div class="card-container d-flex flex-wrap">
						<c:choose>
							<c:when test="${empty tCalendars}">
								<p>등록된 글이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<c:forEach var="calendar" items="${tCalendars}">
									<div class="col-md-6 mb-4">
										<div class="card">
											<div class="card-header d-flex justify-content-between">
												<span class="formattedDate font-weight-bold">${calendar.formattedDateTime}</span>
												<span class="font-weight-bold"> <c:choose>
														<c:when
															test="${calendar.currentNum < calendar.maxNum and !calendar.expired}">
															<span style="color: #e60000;">• 모집중</span>
														</c:when>
														<c:otherwise>
															<span style="color: gray;">모집종료</span>
														</c:otherwise>
													</c:choose>
												</span>
											</div>

											<div class="card-body">
												<h5 class="card-title" style="margin-bottom: 10px;">${calendar.title}</h5>
												<p class="card-text">
													<c:choose>
														<c:when test="${fn:length(calendar.content) > 15}">
													                ${fn:substring(calendar.content, 0, 15)}...
													            </c:when>
														<c:otherwise>
													                ${calendar.content}
													            </c:otherwise>
													</c:choose>
												</p>
												<p class="card-text">
													<i class="fas fa-user text-primary"></i>
													${calendar.currentNum}명 / ${calendar.maxNum}명
												</p>
												<c:url var="calendarDetailPage"
													value="/teampage/${teamId}/tcalendar/details">
													<c:param name="calendarId" value="${calendar.id}" />
												</c:url>
												<a href="${calendarDetailPage}" class="btn"
													style="background-color: #008C2C; color: white;">자세히 보기</a>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 페이징 처리 : 페이지 숫자버튼 5개까지 보임-->
					<c:set var="beginPage" value="${1}" />
					<c:set var="endPage" value="${1}" />
					<c:choose>
						<c:when test="${currentPage <= 3}">
							<c:set var="beginPage" value="${1}" />
							<c:set var="endPage" value="${totalPages < 5 ? totalPages : 5}" />
						</c:when>
						<c:otherwise>
							<c:set var="beginPage" value="${currentPage - 2}" />
							<c:set var="endPage"
								value="${(currentPage + 2) > totalPages ? totalPages : (currentPage + 2)}" />
						</c:otherwise>
					</c:choose>

					<div class="mt-3">
						<nav aria-label="Page navigation">
							<ul class="pagination d-flex justify-content-center">
								<!-- 맨 처음 페이지 버튼 -->
								<li class="page-item"><c:choose>
										<c:when test="${currentPage > 1}">
											<c:url var="firstPageUrl"
												value="/teampage/${teamId}/tcalendar/list">
												<c:param name="page" value="1" />
												<c:param name="filter" value="${filter}" />
											</c:url>
											<a class="page-link text-success" href="${firstPageUrl}"
												aria-label="First"> <span aria-hidden="true">&laquo;&laquo;
													첫 페이지</span>
											</a>
										</c:when>
									</c:choose></li>

								<!-- 이전 페이지 버튼 -->
								<li class="page-item"><c:choose>
										<c:when test="${currentPage > 1}">
											<c:url var="prevPageUrl"
												value="/teampage/${teamId}/tcalendar/list">
												<c:param name="page" value="${currentPage - 1}" />
												<c:param name="filter" value="${filter}" />
											</c:url>
											<a class="page-link text-success" href="${prevPageUrl}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;
													이전</span>
											</a>
										</c:when>
									</c:choose></li>

								<!-- 페이지 번호 버튼 -->
								<c:forEach begin="${beginPage}" end="${endPage}" var="i">
									<li class="page-item ${i == currentPage ? 'active' : ''}">
										<c:url var="pageUrl"
											value="/teampage/${teamId}/tcalendar/list">
											<c:param name="page" value="${i}" />
											<c:param name="filter" value="${filter}" />
										</c:url> <a class="page-link text-success" href="${pageUrl}">${i}</a>
									</li>
								</c:forEach>

								<!-- 다음 페이지 버튼 -->
								<li class="page-item"><c:choose>
										<c:when test="${currentPage < totalPages}">
											<c:url var="nextPageUrl"
												value="/teampage/${teamId}/tcalendar/list">
												<c:param name="page" value="${currentPage + 1}" />
												<c:param name="filter" value="${filter}" />
											</c:url>
											<a class="page-link text-success" href="${nextPageUrl}"
												aria-label="Next"> <span aria-hidden="true">다음
													&raquo;</span>
											</a>
										</c:when>
									</c:choose></li>

								<!-- 맨 마지막 페이지 버튼 -->
								<li class="page-item"><c:choose>
										<c:when test="${currentPage < totalPages}">
											<c:url var="lastPageUrl"
												value="/teampage/${teamId}/tcalendar/list">
												<c:param name="page" value="${totalPages}" />
												<c:param name="filter" value="${filter}" />
											</c:url>
											<a class="page-link text-success" href="${lastPageUrl}"
												aria-label="Last"> <span aria-hidden="true">마지막
													페이지 &raquo;&raquo;</span>
											</a>
										</c:when>
									</c:choose></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>