<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
				
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
	    <title>모임 일정 수정</title>
	    
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
		/* 작성완료 버튼 */
		.submit-btn {
			background-color: #008C2C;
			color: white;
			border: none;
			transition: background-color 0.3s, color 0.3s;
		}
		
		.submit-btn:hover, .submit-btn:focus {
			background-color: #218838; /* 클릭/호버 시 더 진한 초록색 */
			color: white;
		}
        </style>
	</head>
	<body>
    <%@ include file="../fragments/header.jspf"%>
    <div class="container-fluid">
        <c:set var="pageTitle" value="팀 일정 게시글 수정" />
    </div>
    <div class="container my-3">
        <div class="row d-flex justify-content-center">
            <div class="col-md-12 col-lg-10 col-xl-8">
                <div class="card p-4">
                    <div class="btn-group" role="group" aria-label="Button group">
                        <c:url var="teamPage" value="/team/details">
                            <c:param name="teamid" value="${teamId}" />
                        </c:url>
                        <a href="${teamPage}" class="btn btn-custom">내 팀으로</a>

                        <c:url var="postListPage" value="/teampage/${teamId}/post/list" />
                        <a href="${postListPage}" class="btn btn-custom">팀 게시판</a>

                        <c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
                        <a href="${imageListPage}" class="btn btn-custom">팀 앨범</a>

                        <c:url var="calendarListPage" value="/teampage/${teamId}/tcalendar/list" />
                        <a href="${calendarListPage}" class="btn btn-custom">팀 일정 게시판</a>
                        
                        <c:url var="chatPage" value="/teampage/${teamId}/chat" />
						<a href="${chatPage}" class="btn custom-btn">채팅방</a>
                    </div>
                    <h2 class="text-center mt-5">팀 일정 게시글 수정</h2>
                    
                    <c:url value="/teampage/${teamId}/tcalendar/update" var="tCalendarUpdatedPage"/>
                    <form action="${tCalendarUpdatedPage}" method="post">
                        <input type="hidden" name="calendarId" value="${tCalendar.id}" />
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" id="title" name="title" value="${tCalendar.title}">
                        </div>
                        <div class="form-group">
                            <label for="date">날짜/시간</label>
                            <input type="text" class="form-control" id="date" name="date" autocomplete="off" value="${dateTime}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="5" >${tCalendar.content}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="max_num">최대 인원수</label>
                            <input type="number" class="form-control" id="max_num" name="max_num" min="${tCalendar.maxNum}" max="99" placeholder="${tCalendar.maxNum}" required autofocus>
                        </div>
                        <div class="text-center mt-3">
                            <button type="submit" class="btn submit-btn">작성완료</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../fragments/footer.jspf"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
</body>
</html>