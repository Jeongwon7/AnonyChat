package com.anonychat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anonychat.domain.ChatVO;
import com.anonychat.service.ChatService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/chats")
@AllArgsConstructor
@Log4j
public class ChatController {
	@Setter(onMethod_ = @Autowired)
	private ChatService service;
	
	//채팅 등록 chat insert
	@PostMapping(value="/new", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE})//TEXT_PLAIN_VALUE 문자
	public ResponseEntity<String> create(@RequestBody ChatVO cvo){
		log.info("VO: "+cvo);
		int insertCount = service.register(cvo);
		log.info("chat insert count: "+insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : //석세스 문자와 상태값 200 리턴
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);//상태값 500 리턴
	}
	
	//최근 10개 채팅 조회
	@GetMapping(produces = {MediaType.APPLICATION_ATOM_XML_VALUE, 
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ChatVO>> getRecentList(){
		System.out.println("list: "+service.getRecentList());
		return new ResponseEntity<>(service.getRecentList(), HttpStatus.OK);
	}
	
	//실시간 채팅 조회
	@GetMapping(value="/{chatId}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE, 
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ChatVO>> getChatList(@PathVariable("chatId") long chatId){
		System.out.println("ㄹㅇlist: "+service.getList(chatId));
		return new ResponseEntity<>(service.getList(chatId), HttpStatus.OK);
}
	
}
