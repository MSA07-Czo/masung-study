package com.czo.masung.user.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.czo.masung.user.repository.UserRepository;
import com.czo.masung.user.model.dto.UserDTO;
import com.czo.masung.user.model.vo.UserVO;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;

import com.czo.masung.util.MapperUtil;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	//private static ModelMapper modelMapper = MapperUtil.INSTANCE.getMapper();
	
	private final MapperUtil mapperUtil;
	private final UserRepository userRepository;

	public PageResponseDTO<UserDTO> getList(PageRequestDTO pageRequestDTO) {
		List<UserDTO> list = userRepository.getList(pageRequestDTO).stream().map(user -> mapperUtil.map(user, UserDTO.class)).collect(Collectors.toList());
		
		return new PageResponseDTO<UserDTO>(pageRequestDTO, list, userRepository.getTotalCount(pageRequestDTO));
	}
	
	
	public UserDTO getRead(String uid) {
		UserVO user = userRepository.getRead(uid).orElse(null);
		return user != null ? mapperUtil.map(user, UserDTO.class) : null; 
	}
	
	public UserDTO getRead_uuid(String uuid) {
		UserVO user = userRepository.getRead_uuid(uuid).orElse(null);
		return user != null ? mapperUtil.map(user, UserDTO.class) : null; 
	}
	
	public int remove(String uid) {
		return userRepository.remove(uid);
	}
	
	public int modify(final UserVO newUser) {
		return userRepository.modify(newUser);  
	}
	
	public int modify_uuid(final UserVO newUser) {
		return userRepository.modify_uuid(newUser);  
	}
	
	public int insert(final UserVO newUser) {
		return userRepository.insert(newUser);
	}

	public UserDTO login(UserDTO inUser) {
		UserVO user = userRepository.getRead(inUser.getUser_id()).orElse(null);
		if (user != null && user.isEqualPwd(inUser.getUser_pwd())) {
			if (inUser.isAuto_login()) {
				//1. uuid를 생성한다 
				String uuid = UUID.randomUUID().toString();
				
				//2. 회원 테이블에 uuid를 변경한다
				user.setUser_uuid(uuid);
				userRepository.modify_uuid(user);
				
				//3. 쿠키 값을 추가한다 -> contoller에서 처리한다 
			} else {
				//1. 회원 테이블에 uuid를 제거한다
				user.setUser_uuid("");
				userRepository.modify_uuid(user);
			}
			
			return mapperUtil.map(user, UserDTO.class);
		}
		return null;
	}
	
	public String findId(String user_name, String user_email, String user_phone) { 
		String user_id = userRepository.findId(user_name, user_email, user_phone).orElse(null);
		return user_id != null ? user_id : null;
	}
	
	public String findPwd(String user_id, String user_name, String user_email, String user_phone, String user_birth_date) { 
		String user_pwd = userRepository.findId(user_name, user_email, user_phone).orElse(null);
		return user_pwd != null ? user_pwd : null;
	}
	
}
