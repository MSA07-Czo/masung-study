package com.czo.masung.board.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
	private int       board_number;
	private String    user_id;
	private String    user_name;
	private String    board_title;
	private String    board_content;
	private int       board_viewcnt;
	private LocalDate board_reg_date;
	private LocalDate board_last_updated;
	private int       parent_board_number;
	private int       board_category_number;
	private String    board_category_name;

	public BoardVO(String board_title) {
		this.board_number = 0;
		this.board_title = board_title;
	}
}