
package com.czo.masung.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
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
	
	public boolean isEqualPwd(String pwd) {
		return this.user_pwd.equals(pwd);
	}
	
}
