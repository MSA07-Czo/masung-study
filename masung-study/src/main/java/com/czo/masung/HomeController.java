package com.czo.masung;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;

import com.czo.masung.board.service.BoardService;
import com.czo.masung.page.PageRequestDTO;

@Controller
@RequiredArgsConstructor
public class HomeController {

	private final BoardService boardService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@Valid PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {

		model.addAttribute("topGoodList", boardService.getTopGoodList(pageRequestDTO));
		model.addAttribute("topViewList", boardService.getTopViewList(pageRequestDTO));

		return "home";
	}
}
