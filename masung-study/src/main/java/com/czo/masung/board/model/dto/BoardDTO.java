package com.czo.masung.board.model.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {
	private int board_number;

	@NotBlank
	private String user_id;
	private String user_name;

	@NotBlank
	@Size(min = 2)
	private String    board_title;
	private String    board_content;
	private int       board_viewcnt;
	private String    board_reg_date;
	private String    board_last_updated;
	private int       parent_board_number;
	private int       board_category_number;
	private String    board_category_name;

	public BoardDTO(String board_title) {
		this.board_number = 0;
		this.board_title = board_title;
	}
}