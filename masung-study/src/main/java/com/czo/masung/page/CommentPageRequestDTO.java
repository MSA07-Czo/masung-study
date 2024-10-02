package com.czo.masung.page;

import javax.validation.constraints.Min;
import javax.validation.constraints.Positive;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentPageRequestDTO {
	@Min(value = 1)
	@Positive
	private int page = 1;
	
	private int size = 50;
	private int board_number;
	
	public int getSkip() {
        return (page - 1) * size;
    }
	
	public String getParam(int page) {
        StringBuilder builder = new StringBuilder();
        builder.append("page=" + page);
        builder.append("&size=" + size);
        
        return builder.toString();
	}
}
