package com.czo.masung.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardFileDTO {
	private int file_number;
	private int board_number;
	private String file_originalname;
	private String file_realname;
	private String file_content_type;
	private int file_size;
	private String file_reg_date;
}
