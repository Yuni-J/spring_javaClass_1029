package com.ezen.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;

public interface CommentDAO {

	int post(CommentVO cvo);

//	List<CommentVO> getList(long bno);

	int modify(CommentVO cvo);

	int delete(long cno);

	List<CommentVO> getList(@Param("bno") long bno, @Param("pgvo") PagingVO pgvo);
	// 두개 이상일 경우 @Param("변수명") 작성해줘야함 

	int getTotalCount(long bno);

}
