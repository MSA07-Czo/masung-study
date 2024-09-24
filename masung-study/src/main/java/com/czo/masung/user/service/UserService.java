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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	//private static ModelMapper modelMapper = MapperUtil.INSTANCE.getMapper();
	
	private final MapperUtil mapperUtil;
	private final UserRepository userRepository;

	public PageResponseDTO<UserDTO> getList(PageRequestDTO pageRequestDTO) {
		List<UserDTO> list = userRepository.getList(pageRequestDTO).stream().map(member -> mapperUtil.map(member, UserDTO.class)).collect(Collectors.toList());
		
		return new PageResponseDTO<UserDTO>(pageRequestDTO, list, userRepository.getTotalCount(pageRequestDTO));
	}
	
	
	public UserDTO getRead(String uid) {
		UserVO member = userRepository.getRead(uid).orElse(null);
		return member != null ? mapperUtil.map(member, UserDTO.class) : null; 
	}
	
	public UserDTO getRead_uuid(String uuid) {
		UserVO member = userRepository.getRead_uuid(uuid).orElse(null);
		return member != null ? mapperUtil.map(member, UserDTO.class) : null; 
	}
	
	public int remove(String uid) {
		return userRepository.remove(uid);
	}
	
	public int modify(final UserVO newMember) {
		return userRepository.modify(newMember);  
	}
	
	public int modify_uuid(final UserVO newMember) {
		return userRepository.modify_uuid(newMember);  
	}
	
	public int insert(final UserVO newMember) {
		return userRepository.insert(newMember);
	}

//	public UserDTO login(UserDTO inMember) {
//		UserVO member = userRepository.getRead(inMember.getUid()).orElse(null);
//		if (member != null && member.isEqualPwd(inMember.getPwd())) {
//			if (inMember.isAuto_login()) {
//				//1. uuid를 생성한다 
//				String uuid = UUID.randomUUID().toString();
//				
//				//2. 회원 테이블에 uuid를 변경한다
//				member.setUuid(uuid);
//				memberDAO.modify_uuid(member);
//				
//				//3. 쿠키 값을 추가한다 -> contoller에서 처리한다 
//			} else {
//				//1. 회원 테이블에 uuid를 제거한다
//				member.setUuid("");
//				memberDAO.modify_uuid(member);
//			}
//			
//			return mapperUtil.map(member, MemberDTO.class);
//		}
//		return null;
//	}
//	
}
