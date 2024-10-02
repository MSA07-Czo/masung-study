package com.czo.masung.page;

import java.util.List;

import lombok.Data;

@Data
public class CommentPageResponseDTO<E> {
	private int page;
	private int size = 50;
	private int total;
	
	//페이지 시작 번호 
	private int begin; 
	private int end; 
	
	//이전 다음 버튼 출력 여부 
	private boolean prev;
	private boolean next;
	
	private List<E> list;
	
	public CommentPageResponseDTO(CommentPageRequestDTO commentPageRequestDTO, List<E> list, int total) {
		this.page  = commentPageRequestDTO.getPage();
		this.size  = commentPageRequestDTO.getSize();
		this.total = total;
		this.list  = list;
		
		this.end   = (int) Math.ceil(page/10.0) * 10;
		this.begin = end - 9;
		
		//최종 페이지 값 보정 
		int last = (int) Math.ceil(total / (float)size);
		this.end = last < this.end ? last : this.end;
	
		this.prev = this.begin > 1;
		this.next = total > this.end * this.size; 
	}
}
