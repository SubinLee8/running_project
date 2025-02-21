<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>마이페이지</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">

    <style>
        /* 전체 페이지 스타일 */
    html, body {
        height: 100%;
        background-color: transparent !important;
        margin: 0;
        padding: 0;
    }
    
    /* 기본적으로 5개까지만 보이고 나머지는 스크롤 */
    #residence[size] {
        height: auto;
        overflow-y: auto;
    }
    
    .image-option {
        cursor: pointer;
        transition: transform 0.2s ease-in-out;
    }
    
    .image-option:hover {
        transform: scale(1.05);
    }
    
    /* 선택된 이미지 강조 효과 */
    .image-option input:checked + img {
        border: 4px solid #28a745;
        box-shadow: 0 0 10px rgba(40, 167, 69, 0.5);
    }
    
    /* 선택 시 체크 아이콘 표시 */
    .image-option input:checked ~ .image-overlay {
        display: flex !important;
        align-items: center;
        justify-content: center;
        background: rgba(0, 0, 0, 0.4);
        border-radius: 50%;
    }
    </style>
    
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="유저 수정" />
        </div>
        
        <div class="container my-3">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12 col-lg-10 col-xl-8">
                    <div class="card p-4 shadow-sm">
                        <form method="post">
                            <!-- 숨겨진 필드 (id, password, imgId, age) -->
                            <input class="d-none" type="text" id="userId" name="userId" value="${user.userId}" />
                            <input class="d-none" type="password" id="password" name="password" value="${user.password}" />
                            <input class="d-none" type="text" id="imgId" name="imgId" value="${user.imgId}" />
                            <input class="d-none" type="text" id="age" name="age" value="${user.age}" />
        
                            <!-- 프로필 정보 입력 -->
                            <div class="profile-container d-flex align-items-center gap-3">
                                <img src="<c:url value='/image/view/user/${signedInUserId}' />" 
                                     alt="프로필 이미지" 
                                     class="rounded-circle border border-success shadow-sm"
                                     style="width: 120px; height: 120px; object-fit: cover;">
                                <button type="button" id="changeImageBtn" class="btn btn-outline-success btn-sm fw-bold" 
                                        data-user-id="${sessionScope.signedInUserId}" data-bs-toggle="modal" data-bs-target="#imageModal">
                                    프로필 변경
                                </button>
                            </div>
        
                            <div class="profile-details w-100">
                                <div class="row g-3 mt-1">
                                    <!-- 닉네임 입력 + 중복 체크 결과 -->
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">닉네임</label>
                                        <input type="text" id="nickname" name="nickname" value="${user.nickname}"
                                               class="form-control border-success shadow-sm">
                                        <div id="checkNicknameResult" class="mt-1 text-danger"></div>
                                    </div>
        
                                    <!-- 이름 입력 -->
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">이름</label>
                                        <input type="text" id="username" name="username" value="${user.username}"
                                               class="form-control border-success shadow-sm">
                                    </div>
        
                                    <!-- 성별 선택 -->
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">성별</label>
                                        <select name="gender" id="gender" class="form-select border-success shadow-sm">
                                            <option value="1" ${user.gender == '1' ? 'selected' : ''}>남성</option>
                                            <option value="2" ${user.gender == '2' ? 'selected' : ''}>여성</option>
                                        </select>
                                    </div>
        
                                    <!-- 휴대전화번호 입력 + 중복 체크 결과 -->
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">휴대전화번호</label>
                                        <input type="text" id="phonenumber" name="phonenumber" value="${user.phonenumber}"
                                               class="form-control border-success shadow-sm">
                                        <div id="checkPhoneNumberResult" class="mt-1 text-danger"></div>
                                    </div>
        
                                    <!-- 이메일 입력 + 중복 체크 결과 -->
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">이메일</label>
                                        <input disabled type="text" id="email" name="email" value="${user.email}"
                                               class="form-control border-success shadow-sm">
                                        <div id="checkEmailResult" class="mt-1 text-danger"></div>
                                    </div>
        
                                    <!-- 거주지 선택 -->
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">거주지 선택</label>
                                        <c:set var="seoulDistricts" value="
                                            강남구, 강동구, 강북구, 강서구, 관악구, 광진구, 구로구, 금천구, 노원구, 도봉구, 동대문구, 동작구,
                                            마포구, 서대문구, 서초구, 성동구, 성북구, 송파구,
                                            양천구, 영등포구, 용산구, 은평구, 종로구, 중구, 중랑구
                                        " />
                                        <c:set var="cleanedDistricts" value="${fn:replace(seoulDistricts, ' ', '')}" />
                                        <c:set var="districtList" value="${fn:split(cleanedDistricts, ',')}" />
                                        <select name="residence" id="residence" class="form-select border-success shadow-sm">
                                            <option value="${user.residence}" ${empty user.residence ? 'selected' : ''}>
                                                ${not empty user.residence ? user.residence : '주소 선택'}
                                            </option>
                                            <c:forEach var="district" items="${districtList}">
                                                <option value="${district}" ${district eq user.residence ? 'selected' : ''}>
                                                    ${district}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
        
                            <hr/>
        
                        </form>
                           <!-- 버튼 섹션 -->
                            <div class="d-flex flex-column align-items-center gap-3">
                                <button class="btn fw-bold btn-lg w-100" id="btnUpdate" data-user-id="${sessionScope.signedInUserId}"
                                        style="background-color: #28a745; border-color: #008C2C ; color: white;">
                                    작성 완료
                                </button>
                            </div>
        
                            <hr/>
        
                            <div class="d-flex justify-content-center gap-2">
                                <button class="btn btn-warning fw-bold px-4" id="changePasswordBtn" data-user-id="${sessionScope.signedInUserId}" style="color: white;">
                                    비밀번호 변경
                                </button>
                                <button class="btn btn-danger fw-bold px-4 ms-2" id="btnDelete" data-user-id="${sessionScope.signedInUserId}">
                                    계정 탈퇴
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="modal fade" id="imageModal" data-bs-backdrop="static" data-bs-keyboard="false" 
                 aria-labelledby="imageModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered"> <!-- 모달 크기 확대 및 중앙 정렬 -->
                    <div class="modal-content">
                        <!-- 모달 헤더 (X 버튼 제거됨) -->
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title fw-bold">프로필 이미지 변경</h5>
                        </div>
            
                        <!-- 모달 바디 -->
                        <div class="modal-body text-center">
                            <!-- 현재 이미지 미리보기 -->
                            <img id="previewImage"
                                 src="<c:url value='/image/view/user/${signedInUserId}' />"
                                 alt="프로필 이미지 미리보기"
                                 class="rounded-circle border border-success shadow-sm"
                                 style="width: 100px; height: 100px; object-fit: cover;">
            
                            <c:set var="imageList"
                                value="${fn:split('profile01.jpeg,profile02.jpeg,profile03.jpeg,profile04.jpeg,profile05.jpeg', ',')}" />
            
                            <!-- 이미지 선택 영역 -->
                            <div id="imageForm" class="d-flex flex-wrap justify-content-center mt-3">
                                <c:forEach var="image" items="${imageList}" varStatus="status">
                                    <label class="image-option position-relative mx-2">
                                        <input type="radio" name="imgId" value="${status.index + 1}" class="d-none"
                                               ${userImagePath.endsWith(image) ? 'checked' : ''}>
                                        <img src="../images/${image}"
                                             alt="기본 이미지 ${status.index + 1}"
                                             data-img-id="${status.index + 1}"
                                             data-image-name="기본 이미지 ${status.index + 1}"
                                             data-image-file="${image}"
                                             class="selectable-image rounded-circle shadow-sm"
                                             style="width: 100px; height: 100px; object-fit: cover;">
                                        <div class="image-overlay position-absolute top-0 start-0 w-100 h-100 d-none">
                                            <i class="bi bi-check-circle-fill text-white fs-3"></i>
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
            
                        <!-- 모달 푸터 -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button id="btnUpload" type="button" class="btn btn-primary" data-user-id="${sessionScope.signedInUserId}">
                                업로드
                            </button>
                        </div>
                    </div>
                </div>
            </div>
                        
            <div class="modal fade" id="passwordModal" data-bs-backdrop="static" data-bs-keyboard="false" 
                 aria-labelledby="passwordModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered"> <!-- 중앙 정렬 -->
                    <div class="modal-content">
                        <!-- 모달 헤더 (X 버튼 제거됨) -->
                        <div class="modal-header bg-warning text-dark">
                            <h5 class="modal-title fw-bold" style="color: white;">비밀번호 변경</h5>
                        </div>
            
                        <!-- 모달 바디 -->
                        <div class="modal-body px-4">
                            <form id="passwordForm">
                                <!-- 현재 비밀번호 -->
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label fw-bold">현재 비밀번호</label>
                                    <input type="password" id="currentPassword" class="form-control shadow-sm" required />
                                </div>
            
                                <!-- 새 비밀번호 -->
                                <div class="mb-3">
                                    <label for="newFirstPassword" class="form-label fw-bold">새 비밀번호</label>
                                    <input type="password" id="newFirstPassword" class="form-control shadow-sm" required />
                                </div>
            
                                <!-- 새 비밀번호 확인 -->
                                <div class="mb-3">
                                    <label for="newSecondPassword" class="form-label fw-bold">새 비밀번호 확인</label>
                                    <input type="password" id="newSecondPassword" class="form-control shadow-sm" required />
                                </div>
            
                                <!-- 모달 푸터 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                    <button id="btnUpdatePassword" type="submit" class="btn btn-primary">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    
    <!-- CSS Script -->
    	<%@ include file="../fragments/footer.jspf"%>
        <script>
        document.addEventListener("DOMContentLoaded", function () {
            const selectElement = document.getElementById("residence");

            selectElement.addEventListener("focus", function () {
                this.setAttribute("size", "5"); // 드롭다운 열 때 5개까지만 보이도록 설정
            });

            selectElement.addEventListener("change", function () {
                this.removeAttribute("size"); // 선택하면 드롭다운 닫힘
                this.blur(); // 즉시 포커스 해제하여 반응 빠르게
            });

            selectElement.addEventListener("blur", function () {
                this.removeAttribute("size"); // 포커스 벗어나면 원래 크기로 복귀
            });
        });
        
        document.addEventListener("DOMContentLoaded", function () {
            // 이미지 선택 시 스타일 변경
            document.querySelectorAll('.image-option input').forEach(input => {
                input.addEventListener('change', function () {
                    document.querySelectorAll('.image-option img').forEach(img => {
                        img.style.border = "2px solid black"; // 기본 스타일로 초기화
                        img.style.boxShadow = "none";
                    });

                    const selectedImage = this.nextElementSibling;
                    selectedImage.style.border = "4px solid #28a745";
                    selectedImage.style.boxShadow = "0 0 10px rgba(40, 167, 69, 0.5)";
                });
            });
        });
        
        </script>    
        
          	
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <script>
         //세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
         //->comment.js 파일의 코드들에서 그 변수를 사용할 수 있도록 하기 위해서
         const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
         const signedInUserNickname = '${signedInUserNickname}';
         </script>
        
        <!-- Axios JS -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <c:url var="userModifyJS" value="/js/user_modify.js"/>
        <script src="${userModifyJS}"></script>
	</body>
</html>