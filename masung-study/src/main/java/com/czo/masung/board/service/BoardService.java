package com.czo.masung.board.service;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.czo.masung.board.model.dto.BoardDTO;
import com.czo.masung.board.model.dto.BoardFileDTO;
import com.czo.masung.board.model.vo.BoardFileVO;
import com.czo.masung.board.model.dto.CommentDTO;
import com.czo.masung.board.model.vo.BoardVO;
import com.czo.masung.board.repository.BoardFileRepository;
import com.czo.masung.board.model.vo.CommentVO;
import com.czo.masung.board.repository.BoardRepository;
import com.czo.masung.page.CommentPageRequestDTO;
import com.czo.masung.page.CommentPageResponseDTO;
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
	private final BoardFileRepository boardFileRepository;

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
		BoardDTO boardDTO = board != null ? mapperUtil.map(board, BoardDTO.class) : null;
		if (boardDTO != null) {
			boardDTO.setBoardFileDTOList(
				boardFileRepository.getList(board_number)
					.stream()
					.map(boardFileVO -> mapperUtil.map(boardFileVO, BoardFileDTO.class))
					.collect(Collectors.toList())
			);
		}
		
		return boardDTO;
	}

	public int remove(int board_number) {
		return boardRepository.remove(board_number);
	}

	public int modify(final BoardVO newBoard) {
		return boardRepository.modify(newBoard);  
	}

	public int register(final BoardVO newBoard) {
		final int result = boardRepository.register(newBoard);
		try {
			for (MultipartFile file : newBoard.getFile()) {
		 		System.out.println(file.getSize());
				if (file.getSize() != 0) {
		 			//유일한 파일명 생성 
		 			String filename = UUID.randomUUID().toString();
		 			
					//첨부파일 저장 
					OutputStream os = new FileOutputStream("/Users/user/" + filename); 
					file.getInputStream().transferTo(os);
					os.close();
					
		 			BoardFileVO boardFileVO = new BoardFileVO();
		 			
		 			boardFileVO.setBoard_number((int)newBoard.getBoard_number());
		 			boardFileVO.setFile_originalname(file.getOriginalFilename());
		 			boardFileVO.setFile_realname(filename);
		 			boardFileVO.setFile_content_type(file.getContentType());
		 			boardFileVO.setFile_size((int)file.getSize());
		 			
		 			boardFileRepository.insert(boardFileVO);
		 			System.out.println("파일 저장 성공");
		 		}
	 		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
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
	
	public BoardFileDTO getBoardFile(int file_number) {
		BoardFileVO boardFile = boardFileRepository.getRead(file_number).orElse(null);
		return boardFile != null ? mapperUtil.map(boardFile, BoardFileDTO.class) : null;
	}
	//댓글 CRUD
	public CommentPageResponseDTO<CommentDTO> getComment(CommentPageRequestDTO commentPageRequestDTO) {
		List<CommentDTO> list = boardRepository.getComment(commentPageRequestDTO)
				.stream()
				.map(commentVO -> mapperUtil
						.map(commentVO, CommentDTO.class))
				.collect(Collectors.toList());

		return new CommentPageResponseDTO<CommentDTO>(commentPageRequestDTO, list, boardRepository.getCommentTotalCount(commentPageRequestDTO));
	}

	public int registerComment(CommentVO comment) {
		final int comment_number = boardRepository.registerComment(comment);
		return comment_number;
	}
}