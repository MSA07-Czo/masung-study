package com.czo.masung.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
	private int    comment_number;
	private int    board_number;
	private String user_id;
	private String user_name;
	private String comment_content;
	private String comment_reg_date;
	private String comment_last_updated;
	
	public CommentDTO(String user_id) {
		this.comment_number = 0;
		this.user_id = user_id;
	}
}