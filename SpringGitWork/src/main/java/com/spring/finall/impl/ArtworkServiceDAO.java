package com.spring.finall.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;
import com.spring.finall.user.ArtWorkCommentVO;
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

	public int updateArtWorkStatus(String content, int userCode, int currentDraftArtWorkId) {

		Map<String, Object> map = new HashMap<>();
		map.put("content", content);
		map.put("userCode", userCode);
		map.put("id", currentDraftArtWorkId);

		int affectedRow = mybatis.delete("ArtworkMapper.updateArtWorkStatus", map);

		return affectedRow;
	}

	public Map<String, Object> getArtWorkList(int offset) {

		int limit = 11; // 데이터를 11개로 가져와서 10개만 표시

		Map<String, Object> map = new HashMap<>();
		map.put("offset", offset);
		map.put("limit", limit);
		map.put("hasNext", false); // 기본값은 다음 페이지 없음

		// 데이터 리스트를 DB에서 가져옴 (최대 11개 항목)
		List<Map<String, Object>> artWorkList = mybatis.selectList("ArtworkMapper.getArtWorkList", map);

		// 만약 artWorkList의 크기가 11개라면, 10개만 사용하고 11번째는 "다음 페이지" 존재 여부 판단
		if (artWorkList.size() > 10) {
			artWorkList = artWorkList.subList(0, 10); // 10개까지만 실제로 사용
			map.put("hasNext", true); // 11번째 항목이 존재하면 다음 페이지가 있다는 의미
		}

		map.put("artWorkList", artWorkList); // 실제로 사용되는 10개 항목만 map에 추가
		return map;
	}

	public Map<String, Object> getArtWorkDetail(int artWorkId) {
		// DB에서 상세 정보 조회
		Map<String, Object> artWorDetail = mybatis.selectOne("ArtworkMapper.getArtWorkDetail", artWorkId);

		// 이미지 URL 경로 수정
		return toPublicFileURL(artWorDetail);
	}

	public Map<String, Object> toPublicFileURL(Map<String, Object> artWorDetail) {
		// 바꿀 대상 문자열
		String target = "/api/users/get-draft-image";
		String replacement = "/api/guest/get-artwork-image";

		// 복사본 Map 생성 (원본을 직접 수정하고 싶지 않을 경우)
		Map<String, Object> modifiedDetail = new HashMap<>(artWorDetail);

		// 대상 key 예시 - 실제 사용하는 key 이름에 따라 수정
		String[] targetKeys = { "content", "description", "html" };

		for (String key : targetKeys) {
			Object value = modifiedDetail.get(key);
			if (value instanceof String) {
				String str = (String) value;
				// 문자열 치환
				String replaced = str.replace(target, replacement);
				// 수정된 문자열 다시 넣기
				modifiedDetail.put(key, replaced);
			}
		}

		return modifiedDetail;
	}

	// 기본값으로 int limit,int offset 는 각각 10 0 으로 오고 있음
	public List<Map<String, Object>> getMoreWorkComments(int work_id, int limit, int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("work_id", work_id);

		List<Map<String, Object>> flatCommentList = getCommentsWithChildren(work_id, limit, offset);
		// List<Map<String, Object>>
		// flatCommentList=mybatis.selectList("getMoreWorkComments", params);

		List<Map<String, Object>> trreCommentList = buildCommentTree(flatCommentList);

		return trreCommentList;
	}

	// 최상위 부모 와 자식들을 역시 평탄화하여 리턴
	public List<Map<String, Object>> getCommentsWithChildren(int artworkId, int limit, int offset) {
		// 1. 최상위 댓글 페이징 조회
		Map<String, Object> params = new HashMap<>();
		params.put("artworkId", artworkId);
		params.put("limit", limit);
		params.put("offset", offset);

		// 최상위 댓글(부모)만 조회
		List<Map<String, Object>> parents = mybatis.selectList("ArtworkMapper.flatTopCommentPagedParents", params);

		List<Map<String, Object>> allComments = new ArrayList<>(parents);

		// 부모 댓글 ID 목록 추출
		List<Integer> parentIds = new ArrayList<>();
		for (Map<String, Object> comment : parents) {
			parentIds.add((Integer) comment.get("artwork_comment_id"));
		}

		// 2. 자식 댓글 반복 조회
		while (!parentIds.isEmpty()) {
			// 자식 댓글 조회 파라미터
			Map<String, Object> childParams = new HashMap<>();
			childParams.put("parentIds", parentIds);

			// 자식 댓글 리스트 조회 (IN 절에 List자료형 parentIds 리스트로 전달)
			List<Map<String, Object>> children = mybatis.selectList("ArtworkMapper.flatToSelectChildrenByParentIds",
					parentIds);

			if (children.isEmpty()) {
				break;
			}

			allComments.addAll(children);

			// 다음 반복을 위한 부모 ID 리스트를 빈값으로 초기화
			parentIds.clear();
			for (Map<String, Object> child : children) {
				// 다음 반복을 위한 다음 부모 ID 갱신
				parentIds.add((Integer) child.get("artwork_comment_id"));
			}
		}

		return allComments;
	}

	public List<Map<String, Object>> buildCommentTree(List<Map<String, Object>> flatComments) {
		List<Map<String, Object>> roots = new ArrayList<>();
		Map<Integer, Map<String, Object>> commentMap = new HashMap<>();

		// 1. 먼저 comment_id 기준으로 맵핑하고 children 초기화
		for (Map<String, Object> comment : flatComments) {
			comment.put("children", new ArrayList<Map<String, Object>>());
			Integer id = (Integer) comment.get("artwork_comment_id");
			commentMap.put(id, comment);
		}

		// 2. 각 댓글의 부모를 찾아 children에 넣거나, root로 분류
		for (Map<String, Object> comment : flatComments) {
			Integer parentId = (Integer) comment.get("parent_comment_id");

			if (parentId == null) {
				// 최상위 댓글은 roots 에 추가
				roots.add(comment);
			} else {
				Map<String, Object> parent = commentMap.get(parentId);
				if (parent != null) {
					List<Map<String, Object>> children = (List<Map<String, Object>>) parent.get("children");
					children.add(comment);
				} else {
					// 부모가 없을 경우 (데이터 누락 등) → root로 처리 (fallback)
					roots.add(comment);
				}
			}
		}

		return roots;
	}

	public int createArtworkComment(ArtWorkCommentVO arworkCommentVO) {

		int affectedRow = mybatis.insert("ArtworkMapper.createArtworkComment", arworkCommentVO);

		return affectedRow;

	}

	public int applyToComment(ArtWorkCommentVO arworkCommentVO) {

		int affectedRow = mybatis.insert("ArtworkMapper.applyToComment", arworkCommentVO);

		return arworkCommentVO.getArtworkCommentId();

	}

	public Map<String, Object> searchyArtWork(ArtworkVO artWorkVO) {

		artWorkVO.setLimit(artWorkVO.getLimit() + 1);

		Map<String, Object> searchData = new HashMap<>();

		List<Map<String, Object>> searchyList = mybatis.selectList("ArtworkMapper.searchyArtWork", artWorkVO);

		searchData.put("endFlag", true);
		if (searchyList.size() > 10) {
			List<Map<String, Object>> findSearchList = searchyList.subList(0, 10);
			searchData.put("endFlag", false);
			searchData.put("searchyList", findSearchList);
		} else {
			searchData.put("searchyList", searchyList);

		}

		return searchData;

	}

	public int searchyCntAll(ArtworkVO artWorkVO) {

		return mybatis.selectOne("ArtworkMapper.searchyCntAll", artWorkVO);
	}

	public Map<String, Object> getArtWorkCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {
		Map<String, Object> params = new HashMap<>();
		params.put("startOfWeek", startOfWeek);
		params.put("endOfWeek", endOfWeek);
		List<Map<String, Object>> list = mybatis.selectList("ArtworkMapper.getArtWorkCountByTodayAndWeek", params);

		int todayCount = 0;
		int weekCount = 0;

		LocalDate today = LocalDate.now();

		for (Map<String, Object> m : list) {
			Object obj = m.get("created_at");
			LocalDate orderDate;

			if (obj instanceof java.sql.Timestamp) {
				orderDate = ((java.sql.Timestamp) obj).toLocalDateTime().toLocalDate();
			} else if (obj instanceof java.sql.Date) {
				orderDate = ((java.sql.Date) obj).toLocalDate();
			} else if (obj instanceof java.util.Date) { // 혹시 java.util.Date
				orderDate = ((java.util.Date) obj).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			} else {
				throw new IllegalArgumentException("Unsupported date type: " + obj.getClass());
			}

			if (orderDate.isEqual(today)) {
				todayCount++;
			}

			if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(endOfWeek)) {
				weekCount++;
			}
		}

		Map<String, Object> result = new HashMap<>();
		result.put("todayArtWork", todayCount);
		result.put("weekArtWork", weekCount);

		return result;
	}
}
