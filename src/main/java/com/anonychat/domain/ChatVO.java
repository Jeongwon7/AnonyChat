package com.anonychat.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ChatVO {
	private long chatId;
	private String chatName;
	private String chatContent;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm")
	private Date chatTime;
}

