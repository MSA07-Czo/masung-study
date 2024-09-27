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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import java.util.Date;
import java.text.SimpleDateFormat;

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
	
	@RequestMapping(value="register", method = RequestMethod.GET)
	public String insertGet() {
		
		return "/user/register";
	}

	@RequestMapping(value="register", method = RequestMethod.POST)
	public String insert(UserDTO user) {
		userService.insert(mapperUtil.map(user, UserVO.class));
		
		return "redirect:/";
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
		
		model.addAttribute("user", userService.getRead(uid));
		
		return "/user/modify";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modify(UserDTO user) {
		
		userService.modify(mapperUtil.map(user, UserVO.class));
		
		return "redirect:read?uid=" + user.getUser_id();
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String loginForm() {
		HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getResponse();
		
		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equals("remember_me")) {
				UserDTO user = userService.getRead_uuid(cookie.getValue());
				if (user != null) {
					HttpSession session = request.getSession();
					user.setUser_recent_login(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					UserVO userVO = mapperUtil.map(user, UserVO.class);
					userService.modify_recentLogin(userVO);
					userService.insert_loginHis(userVO);
					session.setAttribute("loginInfo", user);
					cookie.setMaxAge(60 * 10);
					response.addCookie(cookie);
					
					return "redirect:/";
				}
			}
		}
		return "/user/login";
	}
	
	@RequestMapping(value="login", method = RequestMethod.POST)
	public String login(UserDTO inUser, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO user = userService.login(inUser);
		if (user != null) { 
			user.setUser_recent_login(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			UserVO userVO = mapperUtil.map(user, UserVO.class);
			userService.modify_recentLogin(userVO);
			userService.insert_loginHis(userVO);
			if (inUser.isAuto_login()) {
				//3. 쿠키 값을 추가한다
				Cookie cookie = new Cookie("remember_me", user.getUser_uuid());
				cookie.setMaxAge(60 * 10);//10분만 사용됨
				cookie.setPath("/");
				
				response.addCookie(cookie);
			}
			session.setAttribute("loginInfo", user);
			System.out.println("로그인 성공");
			System.out.println(user);
			System.out.println("loginInfo :" + session.getAttribute("loginInfo"));
			return "redirect:/";
		} else {
			return "redirect:/user/login?error=error";
		}
	}
	
	@RequestMapping(value="logout", method = RequestMethod.GET)
	//public String logout(HttpServletRequest request, HttpServletResponse response) {
	public String logout(HttpSession session) {
		
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		user.setUser_uuid("");
		user.setUser_recent_logout(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		UserVO userVO = mapperUtil.map(user, UserVO.class);
		userService.modify_uuid(userVO);
		userService.modify_recentLogout(userVO);
		userService.insert_logoutHis(userVO);
		//세션에 저장된 모든 정보를 무효하 한다 
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="findId", method = RequestMethod.GET)
	public String findIdGet() {
		
		return "/user/findId";
	}

	@RequestMapping(value="findId", method = RequestMethod.POST)
	public String findId(@RequestParam("user_name") String user_name,
						@RequestParam("user_email") String user_email,
						@RequestParam("user_phone") String user_phone, Model model) {

		String userId = userService.findId(user_name, user_email, user_phone);
		if (userId != null) {
			model.addAttribute("user_id", userId);		
			return "/user/findId";
		} else {
			return "redirect:/user/findId?error=error";
		}
	}
	
	@RequestMapping(value="findPwd", method = RequestMethod.GET)
	public String findPwdGet() {
		
		return "/user/findPwd";
	}

	@RequestMapping(value="findPwd", method = RequestMethod.POST)
	public String findPwd(@RequestParam("user_id") String user_id,
						@RequestParam("user_name") String user_name,
						@RequestParam("user_email") String user_email,
						@RequestParam("user_phone") String user_phone,
						@RequestParam("user_birth_date") String user_birth_date, Model model) {
		
		String userPwd = userService.findPwd(user_id, user_name, user_email, user_phone, user_birth_date);
		if (userPwd != null) {
			model.addAttribute("user_pwd", userPwd);		
			return "/user/findPwd";
		} else {
			return "redirect:/user/findPwd?error=error";
		}
	}
}
