<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
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
		/* 클릭된 링크에 대해 색상 변경 */
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
		/* 리스트 테이블 열 고정 */
		.fixed-table {
			table-layout: fixed;
			width: 100%;
		}
		
		.fixed-table th:nth-child(1), .fixed-table td:nth-child(1) {
			width: 45%;
		} /* 제목 */
		.fixed-table th:nth-child(2), .fixed-table td:nth-child(2) {
			width: 16.67%;
		} /* 작성자 */
		.fixed-table th:nth-child(3), .fixed-table td:nth-child(3) {
			width: 16.67%;
		} /* 조회수 */
		.fixed-table th:nth-child(4), .fixed-table td:nth-child(4) {
			width: 38.33%;
		} /* 작성시간 */
		.fixed-table th, .fixed-table td {
			white-space: nowrap; /* 줄바꿈 방지 */
			text-overflow: ellipsis; /* 길면 생략 (...) */
			overflow: hidden;
		}
		</style>
		<link
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
		rel="stylesheet">
	</head>
	<body>
    <%@ include file="../fragments/header.jspf"%>
    <div class="container-fluid">
        <c:set var="pageTitle" value="팀 게시글 목록" />
    </div>

    <div class="container my-3">
        <div class="row d-flex justify-content-center">
            <div class="col-md-12 col-lg-10 col-xl-8">
                <div class="card p-4 border-0">
                    <!-- 네비게이션 버튼 그룹 -->
                    <div class="btn-group" role="group" aria-label="Button group">
                        <c:url var="teamPage" value="/team/details">
                            <c:param name="teamid" value="${teamId}" />
                        </c:url>
                        <a href="${teamPage}" class="btn custom-btn">내 팀으로</a>

                        <c:url var="postListPage" value="/teampage/${teamId}/post/list" />
                        <a href="${postListPage}" class="btn custom-btn">팀 게시판</a>

                        <c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
                        <a href="${imageListPage}" class="btn custom-btn">팀 앨범</a>

                        <c:url var="calendarListPage" value="/teampage/${teamId}/tcalendar/list" />
                        <a href="${calendarListPage}" class="btn custom-btn">팀 일정 게시판</a>
                        
                        <c:url var="chatPage" value="/teampage/${teamId}/chat" />
						<a href="${chatPage}" class="btn custom-btn">채팅방</a>
                    </div>

                    <h2 class="text-center mt-5">팀 게시판</h2>

                    <!-- 검색 폼 -->
                    <c:url var="postSearchPage" value="/teampage/${teamId}/post/list" />
                    <form action="${postSearchPage}" method="get" id="searchForm">
                        <div class="d-flex align-items-center mb-3">
                            <!-- 검색 타입 선택 -->
                            <select id="type" name="type" class="form-select me-3" style="width: 120px;">
                                <option value="t" ${param.type eq 't' ? 'selected' : ''}>제목</option>
                                <option value="c" ${param.type eq 'c' ? 'selected' : ''}>내용</option>
                                <option value="tc" ${param.type eq 'tc' ? 'selected' : ''}>제목+내용</option>
                                <option value="n" ${param.type eq 'n' ? 'selected' : ''}>작성자</option>
                            </select>

                            <!-- 검색어 입력 -->
                            <input type="text" name="keyword" class="form-control me-3"
                                placeholder="검색어, 공백 불가" required value="${param.keyword}">

                            <!-- 검색 버튼 -->
                            <button id="searchButton" class="btn btn-success text-white">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- 버튼: 전체 보기, 새글작성 -->
                    <div class="mb-3">
                        <c:url var="postListPage" value="/teampage/${teamId}/post/list" />
                        <a href="${postListPage}" class="btn btn-outline-success me-2">전체 보기</a>
                    <div></div>

                    <!-- 게시글 테이블 -->
                    <div class="card mt-3">
                        <div class="card-body">
                            <table class="table table-striped table-hover fixed-table">
                                <thead class="table-success">
                                    <tr>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>조회수</th>
                                        <th>작성시간</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty posts}">
                                            <tr>
                                                <td colspan="4">등록된 게시글이 없습니다.</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="post" items="${posts}">
                                                <tr>
                                                    <td>
                                                        <c:url var="postDetailsPage" value="/teampage/${post.teamId}/post/${post.id}/details" />
                                                        <a href="${postDetailsPage}" class="text-success">${post.title}</a>
                                                    </td>
                                                    <td>${post.nickname}</td>
                                                    <td>${post.viewCount}</td>
                                                    <td>${post.formattedModifiedTime}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <div style="text-align: right;">
							    <c:url var="postCreatePage" value="/teampage/${teamId}/post/create" />
							    <a class="btn btn-outline-success" href="${postCreatePage}">새글작성</a>
							</div>
                        </div>
                    </div>

                    <!-- 페이징 처리 -->
					<div class="mt-3">
					    <nav aria-label="Page navigation">
					        <ul class="pagination d-flex justify-content-center">
					            <!-- 이전 페이지 버튼 -->
					            <c:if test="${currentPage > 1}">
					                <li class="page-item">
					                    <!-- 이전 페이지 URL 계산 -->
					                    <c:choose>
					                        <c:when test="${empty type and empty keyword}">
					                            <c:set var="prevPageUrl" value="?page=${currentPage - 1}" />
					                        </c:when>
					                        <c:otherwise>
					                            <c:set var="prevPageUrl" value="?page=${currentPage -1 }&amp;type=${type}&amp;keyword=${keyword}" />
					                        </c:otherwise>
					                    </c:choose>
					                    <a class="page-link text-success" href="${prevPageUrl}" aria-label="Previous">
					                        <span aria-hidden="true">&laquo; 이전</span>
					                    </a>
					                </li>
					            </c:if>
					
					            <!-- 페이지 번호 버튼 -->
					            <c:forEach begin="${startPage}" end="${endPage}" var="page">
					                <!-- 페이지 번호 URL 계산 -->
					                <c:choose>
					                    <c:when test="${empty type and empty keyword}">
					                        <c:set var="pageUrl" value="?page=${page}" />
					                    </c:when>
					                    <c:otherwise>
					                        <c:set var="pageUrl" value="?page=${page}&amp;type=${type}&amp;keyword=${keyword}" />
					                    </c:otherwise>
					                </c:choose>
					                <li class="page-item ${page == currentPage ? 'active' : ''}">
					                    <a class="page-link text-success" href="${pageUrl}">
					                        ${page}
					                    </a>
					                </li>
					            </c:forEach>
					
					            <!-- 다음 페이지 버튼 -->
					            <c:if test="${currentPage < totalPage}">
					                <li class="page-item">
					                    <!-- 다음 페이지 URL 계산 -->
					                    <c:choose>
					                        <c:when test="${empty type and empty keyword}">
					                            <c:set var="nextPageUrl" value="?page=${currentPage + 1}" />
					                        </c:when>
					                        <c:otherwise>
					                            <c:set var="nextPageUrl" value="?page=${currentPage + 1}&amp;type=${type}&amp;keyword=${keyword}" />
					                        </c:otherwise>
					                    </c:choose>
					                    <a class="page-link text-success" href="${nextPageUrl}" aria-label="Next">
					                        <span aria-hidden="true">다음 &raquo;</span>
					                    </a>
					                </li>
					            </c:if>
					        </ul>
					    </nav>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
					

	<%@ include file="../fragments/footer.jspf"%>
    <!-- Bootstrap JS 링크 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- Axios Http JS -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	</body>
</html>