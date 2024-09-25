package com.czo.masung;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.board.service.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@Valid PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {


//		model.addAttribute("pageResponseDTO", boardService.getList(pageRequestDTO));

		return "home";
	}

}
