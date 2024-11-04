package com.ezen.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(int bno);

	int update(BoardVO bvo);

	int delete(int bno);

	int getTotal(PagingVO pgvo);

	long getOneBno();

	int readCount(int bno);

	int increCmtCount(CommentVO cvo);

	int decreCmtCount(long bno);

	int syncCmtCount(long bno);

	void hasFileUpdate(@Param("bno") long oneBno, @Param("cnt") int size);
	
}
