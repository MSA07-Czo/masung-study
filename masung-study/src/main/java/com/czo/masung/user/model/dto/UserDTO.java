package com.czo.masung.user.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String user_email;
	private String user_phone;
	private String user_birth_date;
	private String user_gender;
	private String user_role;
	private String user_reg_date;
	private String user_recent_login;
	private String user_recent_logout;
	private String user_uuid;
	private boolean auto_login;
	
//	public UserDTO(String uid, String pwd, boolean auto_login) {
//		this(uid, pwd, "", "", auto_login);
//	}
//
//	public UserrDTO(String uid, String pwd, String name) {
//		this(uid, pwd, name, "", false);
//	}
	
}
