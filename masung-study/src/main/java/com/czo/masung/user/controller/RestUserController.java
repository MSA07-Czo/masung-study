package com.czo.masung.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.user.model.dto.UserDTO;
import com.czo.masung.user.model.vo.UserVO;
import com.czo.masung.user.service.UserService;
import com.czo.masung.util.MapperUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class RestUserController {
	@Autowired
	private UserService userService;
	
	private final MapperUtil mapperUtil;

	@GetMapping("/idCheck")
	public ResponseEntity<Map<String, Object>> isCheck(String uid) {
		
		log.info("uid : " + uid);
		
		Map<String, Object> map = new HashMap<>();
		UserDTO userDTO = userService.getRead(uid);
		map.put("status", 1);
		
		if (userDTO != null) {
			map.put("result", true);
		} else {
			map.put("result", false);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/member_api/insert")
	public ResponseEntity<Map<String, Object>> insert(@RequestBody UserDTO user) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("status", 1);
		
		try { 
			if (userService.insert(mapperUtil.map(user, UserVO.class)) == 1) {
				map.put("result", true);
			} else {
				map.put("result", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
		}
		return ResponseEntity.ok(map);
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("/search")
	public ResponseEntity<Map<String, Object>> search(PageRequestDTO pageRequestDTO) {
		
		log.info("keyword : " + pageRequestDTO.getKeyword());
		
		ObjectMapper objectMapper = new ObjectMapper();
		PageResponseDTO<UserDTO> pageResponseDTO = userService.getList(pageRequestDTO);
		Map<String, Object> map = new HashMap<>();
		map = objectMapper.convertValue(pageResponseDTO, Map.class);

		return ResponseEntity.ok(map);
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("/pagination")
	public ResponseEntity<Map<String, Object>> list(PageRequestDTO pageRequestDTO) {
		
		log.info("pageRequestDTO : " + pageRequestDTO.toString());
		System.out.println("pageRequestDTO : " + pageRequestDTO.toString());
		
		ObjectMapper objectMapper = new ObjectMapper();
		PageResponseDTO<UserDTO> pageResponseDTO = userService.getList(pageRequestDTO);
		Map<String, Object> map = new HashMap<>();
		map = objectMapper.convertValue(pageResponseDTO, Map.class);

		return ResponseEntity.ok(map);
	}
}