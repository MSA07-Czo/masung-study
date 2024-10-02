package com.czo.masung.board.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import com.czo.masung.board.model.vo.BoardFileVO;

@Repository
public interface BoardFileRepository {
	
	int insert(BoardFileVO todoFile);

	List<BoardFileVO> getList(long id);

	Optional<BoardFileVO> getRead(int file_id);
}
