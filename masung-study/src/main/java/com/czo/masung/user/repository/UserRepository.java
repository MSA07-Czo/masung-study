package com.czo.masung.user.repository;

import java.util.List;
import java.util.Optional;

import com.czo.masung.user.model.vo.UserVO;
import com.czo.masung.page.PageRequestDTO;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository {
	public List<UserVO> getList(PageRequestDTO pageRequestDTO);
	public int getTotalCount(PageRequestDTO pageRequestDTO);
	public Optional<UserVO> getRead(String uid);
	public Optional<UserVO> getRead_uuid(String uuid);
	public int remove(String uid);
	public int  modify(UserVO member);
	public int  modify_uuid(UserVO member);
	public int  insert(UserVO member);
}
