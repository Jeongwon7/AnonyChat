package com.anonychat.service;

import java.util.List;

import com.anonychat.domain.ChatVO;

public interface ChatService {
	public int register(ChatVO cvo);
	public List<ChatVO> getList(long chatId);
	public List<ChatVO> getRecentList();
}
