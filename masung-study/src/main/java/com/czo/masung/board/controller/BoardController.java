package com.czo.masung.board.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.model.vo.BoardVO;
import com.czo.masung.board.service.BoardService;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
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
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);

		return "/board/list";
	}

	@GetMapping("/board/register")
	public String registerGet() {
		return "/board/register";
	}

	@PostMapping("/board/register")
	public String register(@Valid BoardDTO board, BindingResult bindingResult, RedirectAttributes redirectAttributes) {

		//입력값 유효성 검증 
		if (bindingResult.hasErrors()) {
			for (ObjectError err : bindingResult.getAllErrors()) {
				log.error("유효성 검증 오류 : " + String.join(", ", err.getCodes()) + " = " + err.getDefaultMessage());
			}
			redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
			return "redirect:/board/register";
		}


		boardService.register(mapperUtil.map(board, BoardVO.class));

		return "redirect:/board/list";
	}

	@GetMapping("/board/read")
	public String read(int board_number, PageRequestDTO pageRequestDTO, Model model) {
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

		boardService.modify(mapperUtil.map(board, BoardVO.class));

		return "redirect:/board/read?id=" + board.getBoard_number() + "&" + pageRequestDTO.getLink();
	}
}