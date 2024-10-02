package com.czo.masung.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.service.BoardService;
import com.czo.masung.page.CommentPageRequestDTO;
import com.czo.masung.page.CommentPageResponseDTO;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.board.model.dto.CommentDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/async/board")
public class BoardRestController {
	
	private final BoardService boardService;
	
	@GetMapping("list")
	public ResponseEntity<Map<String, Object>> getBoardList(PageRequestDTO pageRequestDTO) {
	    System.out.println("비동기 게시물 요청 목록: " + pageRequestDTO);      
	    PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
	    System.out.println("비동기 게시물 응답 목록: " + pageResponseDTO);

	    Map<String, Object> response = new HashMap<>();
	    response.put("pageResponse", pageResponseDTO);
	    response.put("pageRequest", pageRequestDTO);

	    return ResponseEntity.ok(response);
	}
	//댓글 비동기처리
	@GetMapping("comment")
	public ResponseEntity<Map<String, Object>> getComment(CommentPageRequestDTO commentPageRequestDTO){
		System.out.println("비동기 댓글 요청 목록: " + commentPageRequestDTO);
		CommentPageResponseDTO<CommentDTO> comment = boardService.getComment(commentPageRequestDTO);
		
		Map<String, Object> response = new HashMap<>();
		response.put("commentPageRequest", commentPageRequestDTO);
		response.put("comment", comment);
		System.out.println("비동기 댓글 응답 목록: " + response);
		
		return ResponseEntity.ok(response);
	}
}
