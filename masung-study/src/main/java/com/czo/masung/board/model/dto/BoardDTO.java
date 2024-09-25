package com.czo.masung.board.model.dto;

import java.time.LocalDate;

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

	@NotBlank
	@Size(min = 2)
	private String    board_title;
	private String    board_content;
	private int       board_viewcnt;
	private LocalDate board_reg_date;
	private LocalDate board_last_updated;
	private int       parent_board_number;
	private int       board_category_nunber;

	public BoardDTO(String board_title) {
		this.board_number = 0;
		this.board_title = board_title;
	}
}