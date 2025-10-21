package com.spring.finall.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface ArtworkService {

public	List<Map<String, Object>> findDraftByUserCode(int user_code);

public int insertDraftArtwork(int user_code);

public Map<String,Object> artWorkDraftUploadImage( int userCode,MultipartFile file);

public Map<String,Object> deleteArtWorkDraftImage(	int currentDraftArtWorkId, String fordName , String fileName );


public Map<String,Object> completeDraftArtWork( String content , int userCode );

public int currentDraftArtWorkId(int userCode);


	
}
