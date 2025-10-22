package com.spring.finall.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.WorkImgVO;
import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;

@Repository
public class WorkDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<WorkImgVO> getworkList(WorkImgVO vo) {
		// mybatis 객체에 접근해서 메소드 selectList 를 불러와서
		// 첫 매개변수에는 메퍼설정파일의 namespace="BoardDAO" 과 각 태그명들 을 매개변수로
		// 둘 매개변수에는 말그대로 vo

		vo.setNumfornextorback(numfornextorback(vo));
		return mybatis.selectList("WorkImgDAO.selectworkimg", vo);
	}

	public int numfornextorback(WorkImgVO vo) {

		return mybatis.selectOne("WorkImgDAO.numfornextorback", vo);
	}

	public List<WorkImgVO> graterthanonepage(WorkImgVO vo) {
		// mybatis 객체에 접근해서 메소드 selectList 를 불러와서
		// 첫 매개변수에는 메퍼설정파일의 namespace="BoardDAO" 과 각 태그명들 을 매개변수로
		// 둘 매개변수에는 말그대로 vo

		return mybatis.selectList("WorkImgDAO.graterthanonepage", vo);
	}

	public void insertImg(WorkImgVO vo) {

		mybatis.insert("WorkImgDAO.insertImg", vo);
	}

	public List<Map<String, Object>> getWorkReviews(int onedayclass_num) {

		return mybatis.selectList("getWorkReviews", onedayclass_num);
	}

	public Map<String, Object> getWorkDetail(int work_id) {

		return mybatis.selectOne("getWorkDetail", work_id);
	}

	
	//기본값으로  int limit,int offset 는 각각 10 0 으로 오고 있음
	public List<Map<String, Object>> getMoreWorkComments(int work_id, int limit,int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("work_id", work_id);

		List<Map<String, Object>> flatCommentList = getCommentsWithChildren(work_id, limit, offset);
		// List<Map<String, Object>>
		// flatCommentList=mybatis.selectList("getMoreWorkComments", params);

		List<Map<String, Object>> trreCommentList = buildCommentTree(flatCommentList);

		return trreCommentList;
	}

	public List<Map<String, Object>> buildCommentTree(List<Map<String, Object>> flatComments) {
		List<Map<String, Object>> roots = new ArrayList<>();
		Map<Integer, Map<String, Object>> commentMap = new HashMap<>();

		// 1. 먼저 comment_id 기준으로 맵핑하고 children 초기화
		for (Map<String, Object> comment : flatComments) {
			comment.put("children", new ArrayList<Map<String, Object>>());
			Integer id = (Integer) comment.get("comment_id");
			commentMap.put(id, comment);
		}

		// 2. 각 댓글의 부모를 찾아 children에 넣거나, root로 분류
		for (Map<String, Object> comment : flatComments) {
			Integer parentId = (Integer) comment.get("parent_id");

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

	public List<Map<String, Object>> getCommentsWithChildren(int workId, int limit, int offset) {
		// 1. 최상위 댓글 페이징 조회
		Map<String, Object> params = new HashMap<>();
		params.put("work_id", workId);
		params.put("limit", limit);
		params.put("offset", offset);

		// 최상위 댓글(부모)만 조회
		List<Map<String, Object>> parents = mybatis.selectList("selectPagedParents", params);

		List<Map<String, Object>> allComments = new ArrayList<>(parents);

		// 부모 댓글 ID 목록 추출
		List<Integer> parentIds = new ArrayList<>();
		for (Map<String, Object> comment : parents) {
			parentIds.add((Integer) comment.get("comment_id"));
		}

		// 2. 자식 댓글 반복 조회
		while (!parentIds.isEmpty()) {
			// 자식 댓글 조회 파라미터
			Map<String, Object> childParams = new HashMap<>();
			childParams.put("parentIds", parentIds);

			// 자식 댓글 리스트 조회 (IN 절에 List자료형  parentIds 리스트로 전달)
			List<Map<String, Object>> children = mybatis.selectList("selectChildrenByParentIds", parentIds);

			if (children.isEmpty()) {
				break;
			}

			allComments.addAll(children);

			// 다음 반복을 위한 부모 ID 리스트를 빈값으로 초기화
			parentIds.clear();
			
			for (Map<String, Object> child : children) {
				// 다음 반복을 위한  다음 부모 ID 갱신
				parentIds.add((Integer) child.get("comment_id"));
			}
		}

		return allComments;
	}

public Long writeWorkComment(WorkCommentDTO workCommentDTO,int userCode) {
		
		
	workCommentDTO.setUserCode(userCode);
	 workCommentDTO.setUserCode(userCode);
	    workCommentDTO.setCreatedAt(new Date());
	    workCommentDTO.setUpdatedAt(new Date());

	    if (workCommentDTO.getParentId() != null && workCommentDTO.getParentId() == 0) {
	        workCommentDTO.setParentId(null);
	    }

	    int result = mybatis.insert("writeWorkComment", workCommentDTO);
	    System.out.println("생성된 comment_id: " + workCommentDTO.getCommentId());  // 자동 채워진 키 출력
	    Long commentId = workCommentDTO.getCommentId();
	    return (commentId != null) ? commentId : 0L;
	}
	
}
