package com.anonychat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anonychat.domain.ChatVO;
import com.anonychat.mapper.ChatMapper;

import lombok.Setter;

@Service
public class ChatServiceImpl implements ChatService {

	@Setter(onMethod_ = @Autowired)
	private ChatMapper mapper;
	
	@Override
	public int register(ChatVO cvo) {
		return mapper.insert(cvo);
	}

	@Override
	public List<ChatVO> getList(long chatId) {
		return mapper.getChatList(chatId);
	}
	
	@Override
	public List<ChatVO> getRecentList() {
		return mapper.getRecentList();
	}


}
