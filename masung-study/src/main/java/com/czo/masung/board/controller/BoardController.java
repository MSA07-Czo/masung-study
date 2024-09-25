package com.czo.masung.board.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.czo.masung.board.model.dto.BoardDTO;
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
		log.info("board/list() 로그: " + pageRequestDTO.toString());
		if (pageRequestDTO.getPage() == 0 && bindingResult.hasErrors()) {
			log.error("Validation errors: " + bindingResult.getAllErrors());
			pageRequestDTO = PageRequestDTO.builder().build();
		}
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		log.info("pageResponseDTO 로그: " + pageResponseDTO.toString());
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);

		return "/board/list";
	}

	@GetMapping("/todo/register")
	public String registerGet() {
		log.info("todo/register() 로그: ");

		return "/todo/register";
	}
//
//	@RequestMapping(value="/todo/insert", method = RequestMethod.POST)
//	//	public String insert(String title, String dueDate) {
//	public String insert(@Valid TodoDTO todo, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		log.info("todo/insert 처리할 것 () ..... ");
//		log.info("title : " + todo.getTitle());
//		log.info("dueDate : " + todo.getDueDate());
//
//		//입력값 유효성 검증 
//		todo.setUid("aaa");
//		if (bindingResult.hasErrors()) {
//			for (ObjectError err : bindingResult.getAllErrors()) {
//				log.error("유효성 검증 오류 : " + String.join(", ", err.getCodes()) + " = " + err.getDefaultMessage());
//			}
//			redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
//			return "redirect:/todo/insert";
//		}
//
//
//		todoService.insert(mapperUtil.map(todo, TodoVO.class));
//
//		return "redirect:/todo/list";
//	}
//
//	@RequestMapping(value="/todo/read", method = RequestMethod.GET)
//	public String read(long id, PageRequestDTO pageRequestDTO, Model model) {
//
//		model.addAttribute("todo", todoService.getRead(id));
//
//		return "/todo/read";
//	}
//
//	@RequestMapping(value="/todo/remove", method = RequestMethod.GET)
//	public String remove(long id, PageRequestDTO pageRequestDTO) {
//
//		todoService.remove(id);
//
//		return "redirect:/todo/list?" + pageRequestDTO.getLink();
//	}
//
//	@RequestMapping(value="/todo/modify", method = RequestMethod.GET)
//	public String modifyForm(long id, PageRequestDTO pageRequestDTO, Model model) {
//
//		model.addAttribute("todo", todoService.getRead(id));
//
//		return "/todo/modify";
//	}
//
//	@RequestMapping(value="/todo/modify", method = RequestMethod.POST)
//	public String modify(TodoDTO todo, PageRequestDTO pageRequestDTO) {
//
//		todoService.modify(mapperUtil.map(todo, TodoVO.class));
//
//		return "redirect:/todo/read?id=" + todo.getId() + "&" + pageRequestDTO.getLink();
//	}
}