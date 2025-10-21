package com.spring.finall.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.ArtworkVO;

@Repository
public class ArtworkServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<Map<String, Object>> findDraftByUserCode(int userCode) {
		List<Map<String, Object>> rawList = mybatis.selectList("ArtworkMapper.findDraftByUserCode", userCode);

		Map<Integer, Map<String, Object>> artworkMap = new LinkedHashMap<>();

		for (Map<String, Object> row : rawList) {
			Integer artworkId = (Integer) row.get("id"); // 쿼리 결과 컬럼명에 맞게 수정 필요

			Map<String, Object> artworkGroup = artworkMap.get(artworkId);
			if (artworkGroup == null) {
				// artworks 데이터만 따로 추출
				Map<String, Object> artworksData = new HashMap<>();
				artworksData.put("id", row.get("id"));
				artworksData.put("user_code", row.get("user_code"));
				artworksData.put("title", row.get("title"));
				artworksData.put("content", row.get("content"));
				artworksData.put("is_draft", row.get("is_draft"));
				artworksData.put("created_at", row.get("created_at"));
				artworksData.put("updated_at", row.get("updated_at"));

				artworkGroup = new HashMap<>();
				artworkGroup.put("artworks", artworksData);
				artworkGroup.put("artwork_images", new ArrayList<Map<String, Object>>());

				artworkMap.put(artworkId, artworkGroup);
			}

			// 이미지 정보 추출 (null 체크)
			Integer imageId = (Integer) row.get("ai_id");
			if (imageId != null) {
				Map<String, Object> imageData = new HashMap<>();
				imageData.put("id", row.get("ai_id"));
				imageData.put("artwork_id", row.get("artwork_id"));
				imageData.put("file_url", row.get("file_url"));
				imageData.put("file_name", row.get("file_name"));
				imageData.put("uploaded_at", row.get("uploaded_at"));

				@SuppressWarnings("unchecked")
				List<Map<String, Object>> imageList = (List<Map<String, Object>>) artworkGroup.get("artwork_images");
				imageList.add(imageData);
			}
		}

		return new ArrayList<>(artworkMap.values());
	}

	public int getArtWorkId(int userCode) {
		ArtworkVO artwork = new ArtworkVO();
		artwork.setUserCode(userCode);

		mybatis.insert("ArtworkMapper.insertDraftArtwork", artwork);

		return artwork.getId();
	}

	public int currentDraftArtWorkId(int userCode) {

		int currentDraftArtWorkId = mybatis.selectOne("ArtworkMapper.currentDraftArtWorkId", userCode);

		return currentDraftArtWorkId;
	}

	public Map<String, Object> insertDraftArtworkImage(int currentDraftArtWorkId, String uploadDirName,
			String finalFileName) {

		Map<String, Object> map = new HashMap<>();

		map.put("currentDraftArtWorkId", currentDraftArtWorkId);
		map.put("uploadDir", uploadDirName);
		map.put("finalFileName", finalFileName);

		// insert 결과 반환 (영향 받은 row 수)
		int affectedRow = mybatis.insert("ArtworkMapper.insertDraftArtworkImage", map);

		if (affectedRow <= 0) {
			map.put("success", false);

		} else {
			map.put("success", true);
		}

		return map;
	}

	public int deleteArtWorkDraftImage(int currentDraftArtWorkId, String fordName, String fileName) {
		Map<String, Object> map = new HashMap<>();

		map.put("currentDraftArtWorkId", currentDraftArtWorkId);
		map.put("fordName", fordName);
		map.put("fileName", fileName);

		// insert 결과 반환 (영향 받은 row 수)
		int affectedRow = mybatis.delete("ArtworkMapper.deleteArtWorkDraftImage", map);

	

		return affectedRow;
	}

	public int updateArtWorkStatus(String content,int userCode) {

		
		Map<String, Object> map = new HashMap<>();
		map.put("content", content);
		map.put("userCode", userCode);
		
		int affectedRow = mybatis.delete("ArtworkMapper.updateArtWorkStatus", map);

		
		return affectedRow;
	}
	
	
	
	
	
}
