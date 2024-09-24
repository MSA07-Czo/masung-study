package com.czo.masung.board.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.repository.BoardRepository;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.util.MapperUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {
	//private static ModelMapper mapper = MapperUtil.INSTANCE.getMapper();
	private final MapperUtil mapperUtil;
	private final BoardRepository boardRepository;

	public PageResponseDTO<BoardDTO> getList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> list = boardRepository.getList(pageRequestDTO).stream().map(todo -> mapperUtil.map(todo, TodoDTO.class)).collect(Collectors.toList());
		
		return new PageResponseDTO<BoardDTO>(pageRequestDTO, list, boardRepository.getTotalCount(pageRequestDTO));
	}
	
	public BoardDTO getRead(long id) {
		BoardVO todo = boardRepository.getRead(id).orElse(null);
		return todo != null ? mapperUtil.map(todo, BoardDTO.class) : null; 
	}

	public int remove(long id) {
		return boardRepository.remove(id);
	}
	
	public int modify(final BoardVO newTodo) {
		return boardRepository.modify(newTodo);  
	}
	
	public int insert(final BoardVO newTodo) {
		return boardRepository.insert(newTodo);
	}

}
