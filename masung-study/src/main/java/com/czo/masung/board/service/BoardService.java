package com.czo.masung.board.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.model.vo.BoardVO;
import com.czo.masung.board.repository.BoardRepository;
import com.czo.masung.page.PageRequestDTO;
import com.czo.masung.page.PageResponseDTO;
import com.czo.masung.util.MapperUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {
	private final MapperUtil mapperUtil;
	private final BoardRepository boardRepository;

	public PageResponseDTO<BoardDTO> getList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> list = boardRepository.getList(pageRequestDTO)
				.stream()
				.map(boardVO -> mapperUtil
						.map(boardVO, BoardDTO.class))
				.collect(Collectors.toList());

		return new PageResponseDTO<BoardDTO>(pageRequestDTO, list, boardRepository.getTotalCount(pageRequestDTO));
	}

	public BoardDTO getRead(int board_number) {
		BoardVO board = boardRepository.getRead(board_number).orElse(null);

		return board != null ? mapperUtil.map(board, BoardDTO.class) : null;
	}

	public int remove(int board_number) {
		return boardRepository.remove(board_number);
	}

	public int modify(final BoardVO newBoard) {
		return boardRepository.modify(newBoard);  
	}

	public int register(final BoardVO newBoard) {
		return boardRepository.register(newBoard);
	}

	public PageResponseDTO<BoardDTO> getTopGoodList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> list = boardRepository.getTopGoodList(pageRequestDTO)
				.stream()
				.map(boardVO -> mapperUtil
						.map(boardVO, BoardDTO.class))
				.collect(Collectors.toList());

		return new PageResponseDTO<BoardDTO>(pageRequestDTO, list, boardRepository.getTotalCount(pageRequestDTO));
	}

	public PageResponseDTO<BoardDTO> getTopViewList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> list = boardRepository.getTopViewList(pageRequestDTO)
				.stream()
				.map(boardVO -> mapperUtil
						.map(boardVO, BoardDTO.class))
				.collect(Collectors.toList());

		return new PageResponseDTO<BoardDTO>(pageRequestDTO, list, boardRepository.getTotalCount(pageRequestDTO));
	}
	@Transactional
	public int increaseViewcnt(int board_number) {
		BoardVO board = boardRepository.getRead(board_number).orElse(null);
		board.setBoard_viewcnt(board.getBoard_viewcnt() +1);
		boardRepository.saveViewCount(board);
		
		return board.getBoard_viewcnt();
	}
}