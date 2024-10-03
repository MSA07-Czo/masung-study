package com.czo.masung.board.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import com.czo.masung.board.model.vo.BoardVO;
import com.czo.masung.board.model.vo.CommentVO;
import com.czo.masung.page.CommentPageRequestDTO;
import com.czo.masung.page.PageRequestDTO;

@Repository
public interface BoardRepository {

	List<BoardVO> getList(PageRequestDTO pageRequestDTO);
	List<BoardVO> getTopGoodList(PageRequestDTO pageRequestDTO);
	List<BoardVO> getTopViewList(PageRequestDTO pageRequestDTO);
	int getTotalCount(PageRequestDTO pageRequestDTO);

	Optional<BoardVO> getRead(int board_number);
	int remove(int board_number);
	int modify(BoardVO board);
	int register(BoardVO board);
	int saveViewCount(BoardVO board);
	//댓글 CRUD
	List<CommentVO> getComment(CommentPageRequestDTO commentPageRequestDTO);
	int getCommentTotalCount(CommentPageRequestDTO commentPageRequestDTO);
	int registerComment(CommentVO comment);
}