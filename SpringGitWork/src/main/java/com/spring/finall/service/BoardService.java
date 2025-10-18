package com.spring.finall.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.spring.finall.BoardVO;
public interface BoardService {
	
	public abstract List<BoardVO> getBoard(BoardVO vo, Integer startpage);
	
	public abstract List<BoardVO> geteachbtnBoard(BoardVO vo);
	
	public abstract List<BoardVO> getnextBoard(BoardVO vo);
	
	public abstract List<BoardVO> getbackBoard(BoardVO vo);
	
	public abstract List<BoardVO> getboardsearch(BoardVO vo,HttpServletRequest req);
	
	
	
	public abstract BoardVO showBoard(BoardVO vo);
	
	public abstract int insertBoard(BoardVO vo);
	
public  abstract BoardVO getOneViewBoard(BoardVO vo);
	
	
	
	
	public abstract int updateCntBoard(BoardVO vo);

}
