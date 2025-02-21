<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>모임 일정 생성</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- jQuery & jQuery UI   -->
<!-- (1) jQuery UI 컴포넌트에 필요한 스타일시트 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- (2) jQuery의 핵심 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- (3) jQuery UI 라이브러리로 추가 UI 컴포넌트를 제공 -->
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<!-- jQuery Timepicker 플러그인 -->
<!-- (1) 시간 선택 플러그인용 자바스크립트 파일 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.js"></script>
<!-- (2) 시간 선택 플러그인용 스타일시트 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.css">

<script>
	        $(function() {
	            // 한국어 지역화 설정
	            $.timepicker.regional['ko'] = {
	                timeOnlyTitle: '시간 선택',
	                timeText: '시간',
	                hourText: '시',
	                minuteText: '분',
	                secondText: '초',
	                millisecText: '밀리초',
	                microsecText: '마이크로초',
	                timezoneText: '시간대',
	                currentText: '현재 시간',
	                closeText: '확인',
	                amNames: ['오전', 'AM', 'A'],
	                pmNames: ['오후', 'PM', 'P'],
	                isRTL: false
	            };
	            $.timepicker.setDefaults($.timepicker.regional['ko']);
	
	            // 날짜 선택 기능 활성화
	            $("#date").datepicker({
	                dateFormat: 'yy-mm-dd',
	                minDate: 0 // 오늘 이후 날짜만 선택 가능
	            });
	
	            // 시간 선택 기능 활성화
	            $("#time").timepicker({
	                timeFormat: 'tt h:mm',
	                interval: 10, // 10분 간격
	                minTime: '06:00am',
	                maxTime: '11:30pm',
	                defaultTime: '12:00pm',
	                startTime: '06:00am',
	                dynamic: false,
	                dropdown: true,
	                scrollbar: true,
	                stepMinute: 10 // 사용자가 선택할 분 간격
	            });
	        });
	    </script>
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
        <c:set var="pageTitle" value="팀 일정 게시글 새글 작성" />
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

                        <c:url var="calendarListPage" value="/teampage/${teamId}/tcalendar/list" />
                        <a href="${calendarListPage}" class="btn custom-btn">팀 일정 게시판</a>
                        
                        <c:url var="chatPage" value="/teampage/${teamId}/chat" />
						<a href="${chatPage}" class="btn custom-btn">채팅방</a>
                    </div>

                    <h2 class="text-center mt-5">팀 일정 게시글 생성</h2>

                    <c:url value="/teampage/${teamId}/tcalendar/create" var="tCalendarCreatePage" />
                    <form action="${tCalendarCreatePage}" method="post">
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="date">날짜 선택</label>
                            <input type="text" class="form-control" id="date" name="date" autocomplete="off" required>
                        </div>
                        <div class="form-group">
                            <label for="time">시간 선택</label>
                            <input type="text" class="form-control" id="time" name="time" autocomplete="off" required>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="max_num">최대 인원수</label>
                            <input type="number" class="form-control" id="max_num" name="max_num" min="2" max="99" required>
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
    
    <!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
</body>
</html>

