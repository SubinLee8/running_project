/**
 * tchat/chattingroom.jsp에 연결
 */

document.addEventListener('DOMContentLoaded', () => {

	// WebSocket 오브젝트 생성 (자동으로 접속 시작한다. - onopen 함수 호출)      
	var webSocket = new WebSocket("/running/websocket?teamId=" + teamId);
	// 콘솔 텍스트 에리어 오브젝트      
	var messageTextArea = document.getElementById("messageTextArea");
	var message = document.getElementById("textMessage");
	//전송버튼
	const submitButton = document.querySelector("button#submitButton");
	submitButton.addEventListener('click', sendMessage);
	//채팅창
	const chatBox = document.getElementById("chatBox");

	// 현재 시간 가져오기
	const now = new Date();
	const timeString = now.toLocaleTimeString();

	// WebSocket 서버와 접속이 되면 호출되는 함수      
	webSocket.onopen = function(event) {
		// 콘솔 텍스트에 메시지를 출력한다.        
		messageTextArea.value += "Server connect...\n";
	};
	// WebSocket 서버와 접속이 끊기면 호출되는 함수      
	webSocket.onclose = function(message) {
		// 콘솔 텍스트에 메시지를 출력한다.        
		messageTextArea.value += "Server Disconnect...\n";
	};
	// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수      
	webSocket.onerror = function(message) {
		// 콘솔 텍스트에 메시지를 출력한다.        
		messageTextArea.value += "에러...\n";
	};

	// WebSocket 서버로 부터 메시지가 오면 호출되는 함수      
	webSocket.onmessage = function(message) {
		const msg = JSON.parse(message.data);

		// 콘솔 텍스트에 메시지를 출력한다.        
		const messageDiv = document.createElement("div");
		if (msg.nickname == signedInUserNickname) {
			messageDiv.classList.add("message", "user");
		}
		else {
			messageDiv.classList.add("message", "other");
		}
		messageDiv.innerHTML = `<div><strong>${msg.nickname}</strong></div>
	<div>${msg.messageContent}</div>
	<div class="meta">${msg.timestamp}</div>`;
		chatBox.appendChild(messageDiv);

	};

	// Send 버튼을 누르면 호출되는 함수    
	function sendMessage() {
		if(message.value==''){
			return;
		}  

		// 사용자 정보와 메시지를 포함하는 객체 생성
		var messageFormat = {
			userId: signedInUserId, // 사용자 ID
			nickname: signedInUserNickname, // 닉네임
			timestamp: timeString, // 보낸 시간 (ISO 형식)
			teamId: teamId, // 팀 ID
			messageContent: message.value // 메시지 내용
		};

		// 객체를 JSON 문자열로 변환
		var messageJson = JSON.stringify(messageFormat);

		//웹소켓 서버에 전송
		webSocket.send(messageJson);
		// 송신 메시지를 작성하는 텍스트 박스를 초기화한다.  
		message.value = "";
	}

	// Disconnect 버튼을 누르면 호출되는 함수    
	function disconnect() {
		// WebSocket 접속 해제      
		webSocket.close();
	}
})