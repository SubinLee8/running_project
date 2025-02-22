package com.itwill.running.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.util.List;

import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwill.running.dto.ChatMessageDto;
import com.itwill.running.service.RedisService;
import com.itwill.running.service.TMemberService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ChatController {
	private final TMemberService memberService;
	private final RedisService redisService;
	

	@MessageMapping("/chat/{teamId}")
	@SendTo("/topic/team/{teamId}")
	public String sendMessageToTeam(@DestinationVariable String teamId, String message) {
		// 팀별 메시지 전송 (teamId로 그룹화)
		return message;  
	}

	@GetMapping("/teampage/{teamId}/chat")
	public String openChatRoom(@PathVariable Integer teamId, Model model, HttpSession session) {
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			return "redirect:"+"/team/details?teamid="+teamId;
		}

		model.addAttribute("teamId", teamId);
		return "tchat/chattingroom";
	}
	
	@PostMapping("teampage/api/chat")
	public ResponseEntity<Long> saveMessage(@RequestParam("teamid") Integer teamId,@RequestBody ChatMessageDto dto) throws JsonProcessingException{
		long result=redisService.saveMessage(teamId, dto);
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("teampage/api/chat/getAll")
	public ResponseEntity<List<ChatMessageDto>> getAll(@RequestParam("teamid") Integer teamId){
		int count=100; //최근 메세지 100개만
		List<ChatMessageDto> lists= redisService.getRecentMessage(teamId, count);
		return ResponseEntity.ok(lists);
	}
	
	
}
