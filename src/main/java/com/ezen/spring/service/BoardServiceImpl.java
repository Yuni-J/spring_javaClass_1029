package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.dao.BoardDAO;
import com.ezen.spring.dao.FileDAO;
import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.FileVO;
import com.ezen.spring.domain.PagingVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardDAO bdao;
	private final FileDAO fdao;

//	@Override
//	public int insert(BoardVO bvo) {
//		// TODO Auto-generated method stub
//		return bdao.insert(bvo);
//	}
	@Transactional  //순차처리
	@Override
	public int insert(BoardDTO bdto) {
		// bvo + file
		// bvo 먼저 insert하고 난 후 bno를 DB에서 빼와야 함. -> fvo를 DB에 저장
		int isOk = bdao.insert(bdto.getBvo());
		if(bdto.getFlist() == null) { //첨부파일이 없는 경우
			return isOk;
		}
		// 첨부파일이 있는 케이스
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			//bno setting
			long bno = bdao.getOneBno();   //가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isOk *= fdao.insertFile(fvo);
			}
		}
		bdao.hasFileUpdate(bdao.getOneBno(), bdto.getFlist().size());
		return isOk;
	}
	
	@Override
	public int removeFile(String uuid) {
		long bno = fdao.getBnoToUuid(uuid);
		int isOk = fdao.removeFile(uuid);
		if(isOk > 0) {
			bdao.hasFileUpdate(bno, -1);
		}
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getList(pgvo);
	}

//	@Override
//	public BoardVO getDetail(int bno) {
//		// TODO Auto-generated method stub
//		return bdao.getDetail(bno);
//	}
	@Override
	public BoardDTO getDetail(int bno) {
		//  bdao > bvo / fdao > fvo 묶어서 BoardDTO 로 리턴
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getList(bno);
		
		BoardDTO bdto = new BoardDTO(bvo, flist);
		
		return bdto;
	}

//	@Override
//	public int update(BoardVO bvo) {
//		// TODO Auto-generated method stub
//		return bdao.update(bvo);
//	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return bdao.delete(bno);
	}

	@Override
	public int getTotal(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotal(pgvo);
	}

//	@Override
//	public int removeFile(String uuid) {
//		// TODO Auto-generated method stub
//		return fdao.removeFile(uuid);
//	}

	@Transactional
	@Override
	public int update(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		int isOk = bdao.update(boardDTO.getBvo());
		if(boardDTO.getFlist() == null) {
			return isOk;
		}
		if(isOk > 0 && boardDTO.getFlist().size() > 0) {
			for(FileVO fvo : boardDTO.getFlist()) {
				fvo.setBno(boardDTO.getBvo().getBno());
				isOk *= fdao.insertFile(fvo);
			}
		}
		bdao.hasFileUpdate(bdao.getOneBno(), boardDTO.getFlist().size());
		return isOk;
	}

	@Override
	public int readCount(int bno) {
		// TODO Auto-generated method stub
		return bdao.readCount(bno);
	}

	@Override
	public int increCmtCount(CommentVO cvo) {
		// TODO Auto-generated method stub
		return bdao.increCmtCount(cvo);
	}

	@Override
	public int decreCmtCount(long bno) {
		// TODO Auto-generated method stub
		return bdao.decreCmtCount(bno);
	}

	@Override
	public int syncCommentCount(long bno) {
	   return bdao.syncCmtCount(bno);
	}
}
