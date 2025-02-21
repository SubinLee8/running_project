package com.itwill.running.web;

import java.io.IOException;
import java.net.URI;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MyWebSocketHandler extends TextWebSocketHandler {
	// 사용자 세션을 저장할 ConcurrentHashMap
	private final ConcurrentHashMap<Integer, Set<WebSocketSession>> chatRoomSessions = new ConcurrentHashMap<>(); // 팀번호, 세션아이디

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//접속된 채팅방을 찾는다.
		int teamId=findTeamId(session.getUri());
		//전송된 데이터를 찾는다
		String payload = message.getPayload();
		// 해당채팅방에 접속한 클라이언트들을 찾는다
		Set<WebSocketSession> sessionsInRoom = chatRoomSessions.get(teamId);

		if (sessionsInRoom != null) {
			for (WebSocketSession sess : sessionsInRoom) {
				if (sess.isOpen()) {
					try {
						//해당 채팅방에 접속된 클라이언트에게 모두 전송
						sess.sendMessage(new TextMessage(payload));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 팀번호 찾기
		int teamId=findTeamId(session.getUri());

		// 사용자 세션과 팀번호를 chatRoomSessions에 저장
		chatRoomSessions.computeIfAbsent(teamId, k -> new HashSet<>()).add(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 사용자 세션 제거
		chatRoomSessions.remove(findTeamId(session.getUri()),session.getId());
	}
	
	public Integer findTeamId(URI uri) {
		int teamId=0;
		String query = uri.getQuery(); 
		String[] params = query.split("&");

		for (String param : params) {
			if (param.startsWith("teamId=")) {
				teamId = Integer.parseInt(param.split("=")[1]);
				return teamId;
			}
		}
		return teamId;
	}
}
