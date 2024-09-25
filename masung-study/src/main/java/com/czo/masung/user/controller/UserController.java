package com.czo.masung.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.czo.masung.user.repository.UserRepository;
import com.czo.masung.user.service.UserService;
import com.czo.masung.user.model.dto.UserDTO;
import com.czo.masung.user.model.vo.UserVO;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.util.MapperUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	@Autowired
	private MapperUtil mapperUtil;

	@Autowired
	private UserService userService;
	
	//@RequestMapping(value = "list", method = RequestMethod.GET)
	@GetMapping("list")
	public String list(@Valid PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
		if (bindingResult.hasErrors()) {
			pageRequestDTO = PageRequestDTO.builder().build();
		}
		model.addAttribute("pageResponseDTO", userService.getList(pageRequestDTO));
		
		return "/user/list";
	}
	
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public String insertGet() {
		log.info("member/insert() ..... ");
		
		return "/user/insert";
	}

	@RequestMapping(value="insert", method = RequestMethod.POST)
	public String insert(UserDTO user) {
		userService.insert(mapperUtil.map(user, UserVO.class));
		
		return "redirect:list";
	}
	
	@RequestMapping(value="read", method = RequestMethod.GET)
	public String read(String uid, Model model) {
		
		model.addAttribute("user", userService.getRead(uid));
		
		return "/user/mypage";
	}
	
	@RequestMapping(value="remove", method = RequestMethod.GET)
	public String remove(String uid) {
		
		userService.remove(uid);
		
		return "redirect:list";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.GET)
	public String modifyForm(String uid, Model model) {
		
		model.addAttribute("member", userService.getRead(uid));
		
		return "/user/modify";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modify(UserDTO user) {
		
		userService.modify(mapperUtil.map(user, UserVO.class));
		
		return "redirect:read?uid=" + user.getUser_id();
	}
	
//	@RequestMapping(value="login", method = RequestMethod.GET)
//	public String loginForm() {
//		HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
//		HttpServletResponse response = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getResponse();
//		
//		System.out.println("로그인 화면");
//		for (Cookie cookie : request.getCookies()) {
//			if (cookie.getName().equals("remember_me")) {
//				UserDTO member = userService.getRead_uuid(cookie.getValue());
//				if (member != null) {
//					HttpSession session = request.getSession();
//					
//					session.setAttribute("loginInfo", member);
//					cookie.setMaxAge(60 * 10);
//					response.addCookie(cookie);
//					
//					return "redirect:/todo/list";
//				}
//			}
//		}
//		return "/member/login";
//	}
//	
//	@RequestMapping(value="login", method = RequestMethod.POST)
//	public String login(UserDTO inMember, HttpServletRequest request, HttpServletResponse response) {
//		
//		HttpSession session = request.getSession();
//		UserDTO member = userService.login(inMember);
//		if (member != null) { 
//			if (inMember.isAuto_login()) {
//				//3. 쿠키 값을 추가한다
//				Cookie cookie = new Cookie("remember_me", member.getUuid());
//				cookie.setMaxAge(60 * 10);//10분만 사용됨
//				cookie.setPath("/");
//				
//				response.addCookie(cookie);
//			}
//			session.setAttribute("loginInfo", member);
//			return "redirect:/todo/list";
//		} else {
//			return "redirect:/member/login?error=error";
//		}
//	}
//	
//	@RequestMapping(value="logout", method = RequestMethod.GET)
//	//public String logout(HttpServletRequest request, HttpServletResponse response) {
//	public String logout(HttpSession session) {
//		
//		MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
//		member.setUuid("");
//		memberService.modify_uuid(mapperUtil.map(member, MemberVO.class));
//
//		//세션에 저장된 모든 정보를 무효하 한다 
//		session.invalidate();
//		return "redirect:/member/login";
//	}
}
