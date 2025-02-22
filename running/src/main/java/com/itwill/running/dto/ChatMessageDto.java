package com.itwill.running.dto;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor // Jackson이 Json을 Java 객체로 변환할 수 있게 해야 한다.
@Data
public class ChatMessageDto {
	private String userId;
	private String nickname;
	private String timestamp;
	private Integer teamId;
	private String messageContent;
}
