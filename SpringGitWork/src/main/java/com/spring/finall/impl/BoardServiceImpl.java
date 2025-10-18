package com.spring.finall.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.BoardVO;
import com.spring.finall.service.BoardService;

@Service("board")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAObatis boardDAO;
	
	
	
	@Override
	public List<BoardVO> getBoard(BoardVO vo, Integer startpage) {
		return boardDAO.getBoard(vo,startpage);
		
	}
	
	@Override
	public List<BoardVO> geteachbtnBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		return boardDAO.geteachbtnBoard(vo);
	}
	
	@Override
	public List<BoardVO> getnextBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		return  boardDAO.getnextBoard(vo);
	}

	@Override
	public List<BoardVO> getbackBoard(BoardVO vo){
		return  boardDAO.getbackBoard(vo);
	};
	
	@Override
	public List<BoardVO> getboardsearch(BoardVO vo,HttpServletRequest req){
		
		return  boardDAO.getboardsearch(vo,req);
		
	};
	
	
	
	
	
	
	
	public int insertBoard(BoardVO vo) {
	 return	boardDAO.insertBoard(vo);
		
	}
	
	public BoardVO getOneViewBoard(BoardVO vo) {
		
		return boardDAO.getOneViewBoard(vo);
	}
	
	

	@Override
	public BoardVO showBoard(BoardVO vo) {
		
		return boardDAO.showBoard(vo);
	}
	
	public int updateCntBoard(BoardVO vo) {
	 return	boardDAO.updateCntBoard(vo);
	}

	

	

}
