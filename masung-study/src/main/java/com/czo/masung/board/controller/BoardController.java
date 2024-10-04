package com.czo.masung.board.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.model.dto.BoardFileDTO;
import com.czo.masung.board.model.vo.BoardVO;
import com.czo.masung.board.service.BoardService;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.user.model.dto.UserDTO;
import com.czo.masung.util.MapperUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {
	private final MapperUtil mapperUtil;
	private final BoardService boardService;

	@RequestMapping("/board/list")
	public String list(@Valid PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
		if (pageRequestDTO.getPage() == 0 && bindingResult.hasErrors()) {
			log.error("Validation errors: " + bindingResult.getAllErrors());
			pageRequestDTO = PageRequestDTO.builder().build();
		}
		System.out.println("pageRequestDTO 내용: " + pageRequestDTO);
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);

		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
		
		return "/board/list";
	}

	@GetMapping("/board/register")
	public String registerGet(HttpSession session, RedirectAttributes redirectAttributes, Model model) {
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		if(user == null) {
			return "redirect:/user/login";
		}
		model.addAttribute("loginInfo", user);

		return "/board/register";
	}

	@GetMapping("/board/answerRegister")
	public String answerRegisterGet(int parent_board_number, Model model,HttpSession session, RedirectAttributes redirectAttributes) {
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		if(user == null) {
			return "redirect:/user/login";
		}
		model.addAttribute("parent_board_number", parent_board_number);
		return "/board/register";
	}

	@PostMapping("/board/register")
	public String register(@Valid BoardDTO board, BindingResult bindingResult, RedirectAttributes redirectAttributes, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		board.setUser_id(user.getUser_id());

		System.out.println("게시물 등록 내용: " + board);
		//입력값 유효성 검증 
		if (bindingResult.hasErrors()) {
			for (ObjectError err : bindingResult.getAllErrors()) {
				System.out.println("유효성 검증 오류 : " + String.join(", ", err.getCodes()) + " = " + err.getDefaultMessage());
			}
//			return "redirect:/board/register";
		}
		boardService.register(mapperUtil.map(board, BoardVO.class));

		return "redirect:/board/list";
	}

	@GetMapping("/board/read")
	public String read(int board_number, PageRequestDTO pageRequestDTO, Model model) {
		System.out.println("게시물 번호 내용: " + board_number);
		//조회수 증가
		boardService.increaseViewcnt(board_number);

		model.addAttribute("board", boardService.getRead(board_number));
		return "/board/read";
	}

	@GetMapping("/board/remove")
	public String remove(int board_number, PageRequestDTO pageRequestDTO) {

		boardService.remove(board_number);

		return "redirect:/board/list?" + pageRequestDTO.getLink();
	}

	@GetMapping("/board/modify")
	public String modifyForm(int board_number, PageRequestDTO pageRequestDTO, Model model) {

		model.addAttribute("board", boardService.getRead(board_number));

		return "/board/modify";
	}

	@PostMapping("/board/modify")
	public String modify(BoardDTO board, PageRequestDTO pageRequestDTO) {
		System.out.println("게시물 수정 내용: " + board);
		boardService.modify(mapperUtil.map(board, BoardVO.class));

		return "redirect:/board/read?board_number=" + board.getBoard_number() + "&" + pageRequestDTO.getLink();
	}
	
	@GetMapping(value="/board/download/{file_number}")
	public void download(@PathVariable("file_number") int file_number, HttpServletResponse response) throws Exception {
	//public void download(int file_id, HttpServletResponse response) {
		log.info("file_number = " + file_number);
		BoardFileDTO boardFileDTO = boardService.getBoardFile(file_number);
		if (boardFileDTO == null) {
			response.setStatus(404);
		} else {
			String file_originalname = boardFileDTO.getFile_originalname();
			file_originalname = URLEncoder.encode(file_originalname, "utf-8");			
			
			response.setContentLength(boardFileDTO.getFile_size());
			response.setContentType(boardFileDTO.getFile_content_type());
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Content-disposition", "attachment; fileName=" + file_originalname);
			
			InputStream in = new FileInputStream("C:\\upload\\" + boardFileDTO.getFile_realname());
			in.transferTo(response.getOutputStream());
			in.close();
			
		}
	}
}