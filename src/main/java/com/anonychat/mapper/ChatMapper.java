package com.anonychat.mapper;

import java.util.List;

import com.anonychat.domain.ChatVO;

public interface ChatMapper {
	public List<ChatVO> getChatList(long chatId);
	public int insert(ChatVO cvo);
	public List<ChatVO> getRecentList();
}