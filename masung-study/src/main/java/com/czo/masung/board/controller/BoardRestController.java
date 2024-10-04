package com.czo.masung.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.service.BoardService;
import com.czo.masung.page.CommentPageRequestDTO;
import com.czo.masung.page.CommentPageResponseDTO;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.user.model.dto.UserDTO;
import com.czo.masung.util.MapperUtil;
import com.czo.masung.board.model.dto.CommentDTO;
import com.czo.masung.board.model.vo.CommentVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/async/board")
public class BoardRestController {
	private final MapperUtil mapperUtil;
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
	//댓글 목록 비동기처리
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
	//댓글 등록 비동기처리
	@PostMapping("comment/register")
	public ResponseEntity<Map<String, Object>> submitComment(@RequestBody CommentDTO comment, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		Map<String, Object> response = new HashMap<>();
		
		if(user == null) {
			response.put("message", "로그인이 필요합니다.");
			response.put("status", "fail");
			
			return ResponseEntity.ok(response);
		}
		comment.setUser_id(user.getUser_id());
		boardService.registerComment(mapperUtil.map(comment, CommentVO.class));
		CommentPageRequestDTO commentPageRequestDTO = new CommentPageRequestDTO(1, 50, comment.getBoard_number());
		
		getComment(commentPageRequestDTO);
		response.put("message", "댓글이 등록되었습니다.");
		response.put("status", "success");
		System.out.println("댓글 등록 응답 목록: " + response);
		return ResponseEntity.ok(response);
	}
}
