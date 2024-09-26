package com.czo.masung.user.repository;

import java.util.List;
import java.util.Optional;

import com.czo.masung.user.model.vo.UserVO;
import com.czo.masung.page.PageRequestDTO;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository {
	public List<UserVO> getList(PageRequestDTO pageRequestDTO);
	public int getTotalCount(PageRequestDTO pageRequestDTO);
	public Optional<UserVO> getRead(String user_id);
	public Optional<UserVO> getRead_uuid(String user_uuid);
	public int remove(String user_id);
	public int  modify(UserVO user);
	public int  modify_uuid(UserVO user);
	public int  insert(UserVO user);
	public Optional<String> findId(@Param("user_name") String name, @Param("user_email") String email, @Param("user_phone") String phone);
	public Optional<String> findPwd(@Param("user_id") String id, @Param("user_name") String name, @Param("user_email") String email, @Param("user_phone") String phone, @Param("user_birth_date") String birth_date);
}
