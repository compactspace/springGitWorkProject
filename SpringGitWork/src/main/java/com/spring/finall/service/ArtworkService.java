package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.user.ArtWorkCommentVO;
import com.spring.finall.user.ArtworkVO;

public interface ArtworkService {

public	List<Map<String, Object>> findDraftByUserCode(int user_code);

public int insertDraftArtwork(int user_code);

public Map<String,Object> artWorkDraftUploadImage( int userCode,MultipartFile file);

public Map<String,Object> deleteArtWorkDraftImage(	int currentDraftArtWorkId, String fordName , String fileName );


public Map<String,Object> completeDraftArtWork( String content , int userCode );

public int currentDraftArtWorkId(int userCode);


public Map<String, Object> getArtWorkList(int offset);

public  Map<String, Object> getArtWorkDetail(int artWorkId);


public int createArtworkComment(ArtWorkCommentVO arworkCommentVO);

public int applyToComment(ArtWorkCommentVO arworkCommentVO);

public	Map<String, Object> searchyArtWork(	ArtworkVO artWorkVO);

public int searchyCntAll(	ArtworkVO artWorkVO);

	
}
