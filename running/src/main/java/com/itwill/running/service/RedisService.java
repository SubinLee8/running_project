package com.itwill.running.service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwill.running.dto.ChatMessageDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class RedisService {
	private final RedisTemplate<String, Object> redisTemplate;
	@Autowired
	private ObjectMapper objectMapper; // 스프링부트가 아니기 때문에 수동으로 주입.

	public Long saveMessage(Integer teamId, ChatMessageDto message) throws JsonProcessingException {
		String key = "team:" + teamId;
		// Redis에 RPUSH로 저장 (가장오래된 메세지 순으로 읽기 가능)
		Long result = redisTemplate.opsForList().rightPush(key, objectMapper.writeValueAsString(message)); // Redis는
																											// string
																											// 객체만 저장
																											// 가능하므로
		return result;
	}

	public List<ChatMessageDto> getRecentMessage(Integer teamId, Integer count) {
		String key = "team:" + teamId;
		// 최신메세지 count개 조회
		List<Object> obs = redisTemplate.opsForList().range(key, -100, -1);
		// RedisTemplete은 자동으로 Object로 직렬화하여 저장해서.
		if (obs == null || obs.isEmpty()) {
			return Collections.emptyList(); // 빈 리스트 반환
		}

		return obs.stream().map(obj -> {
			try {
				// Object가 실제로 JSON 문자열이라면 String으로 변환 후, ChatMessageDto로 변환
				String json = (String) obj;
				return objectMapper.readValue(json, ChatMessageDto.class); // JSON → 객체 변환
			} catch (JsonProcessingException e) {
				throw new RuntimeException("JSON 변환 실패", e);
			}
		}).collect(Collectors.toList());
	}
}
