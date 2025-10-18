package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.ReviewVO;

@Repository
public class OneDayClassDAObatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	
	public OneDayClassVO getOneOneDayClass(OneDayClassVO vo) {

		if(vo.getOnedayclass_num()==null) {
			vo.setOnedayclass_num(0);
		}
		
		
		return mybatis.selectOne("OneDayClassVO.getOneOneDayClass", vo);

	}
	
	
	
	public List<OneDayClassVO> selectOneDayClass(OneDayClassVO vo) {

		return mybatis.selectList("OneDayClassVO.selectOneDayClass", vo);

	}
	
	
	public List<OneDayClassVO> selectDayClassList(OneDayClassVO vo) {
		
		return mybatis.selectList("OneDayClassVO.selectDayClassList", vo);

	}
	
	
	

	public HashMap<String, Object> getReview(OneDayClassVO ovo) {
    HashMap<String, Object> map = new HashMap<>();
    int pageSize = 4;

    // 클라이언트가 보낸 offset (nextpage), 없으면 0으로 초기화
    int currentNextpage = ovo.getNextpage() == null ? 0 : ovo.getNextpage();

    // 원데이 클래스 기본 정보 조회
    OneDayClassVO onedayInfo = mybatis.selectOne("OneDayClassVO.selectOneDayClass", ovo);

    
    
    
    
    // 리뷰 목록 조회 (offset = currentNextpage, limit = pageSize)
    List<OneDayClassVO> list = mybatis.selectList("OneDayClassVO.getReview", Map.of(
        "onedayclass_name", ovo.getOnedayclass_name(),
        "nextpage", currentNextpage
    ));
    
    //imagelocallpath1
    
    List<String> candiImageList =onedayInfo.getCandiImageList();

    // 리뷰가 없으면 빈 상태 리턴
    if (list.isEmpty()) {
        map.put("onedayclass", onedayInfo);
        map.put("candiImageList", candiImageList);
        map.put("joinToReview", null);
        map.put("isEmpty", true);
        return map;
    }

    List<ReviewVO> reviewVo = list.get(0).getReivewvo();

    // 마지막 페이지 판단: 가져온 리뷰 개수가 pageSize보다 작으면 마지막 페이지
    boolean endPageFlag = reviewVo.size() < pageSize;

    // 다음 nextpage 계산 (더 이상 데이터 없으면 currentNextpage 유지)
    int nextNextpage = endPageFlag ? currentNextpage : currentNextpage + pageSize;

    // 상태 세팅
    OneDayClassVO firstEntry = list.get(0);
    firstEntry.setEndPageFlag(endPageFlag);
    firstEntry.setNextpage(nextNextpage);

    // 리뷰 리스트를 Object 리스트로 변환
    List<Object> joinToReview = ovo.toList(firstEntry, reviewVo.size());

    // 결과 맵에 담기
    map.put("onedayclass", onedayInfo);
    map.put("joinToReview", joinToReview);
    map.put("candiImageList", candiImageList);
    map.put("endPageFlag", endPageFlag);
    map.put("nextpage", nextNextpage);
    map.put("isEmpty", false);
    return map;
}

	
	
	
	public HashMap<String, Object> getReview2(OneDayClassVO ovo) {
	    // 기존 getReview 호출
	    HashMap<String, Object> fullMap = getReview(ovo);

	    // 리뷰만 다시 호출 (만약 리뷰만 별도 쿼리로 새로 조회하고 싶으면 여기서 구현)
	    int pageSize = 4;
	    int currentNextpage = ovo.getNextpage() == null ? 0 : ovo.getNextpage();

	    List<OneDayClassVO> list = mybatis.selectList("OneDayClassVO.getReview", Map.of(
	        "onedayclass_name", ovo.getOnedayclass_name(),
	        "nextpage", currentNextpage
	    ));

	    if (list.isEmpty()) {
	        // 리뷰 없으면 기존 결과에서 onedayclass 정보만 담아서 리턴
	        HashMap<String, Object> map = new HashMap<>();
	        map.put("onedayclass", fullMap.get("onedayclass"));
	        map.put("joinToReview", null);
	        map.put("isEmpty", "isEmpty");
	        return map;
	    }

	    List<ReviewVO> reviewVo = list.get(0).getReivewvo();

	    boolean endPageFlag = reviewVo.size() < pageSize;
	    int nextNextpage = endPageFlag ? currentNextpage : currentNextpage + pageSize;

	    OneDayClassVO firstEntry = list.get(0);
	    firstEntry.setEndPageFlag(endPageFlag);
	    firstEntry.setNextpage(nextNextpage);

	    List<Object> joinToReview = ovo.toList(firstEntry, reviewVo.size());

	    HashMap<String, Object> map = new HashMap<>();
	    map.put("onedayclass", fullMap.get("onedayclass")); // 원데이 클래스 정보 유지
	    map.put("joinToReview", joinToReview);
	    map.put("endPageFlag", endPageFlag);
	    map.put("nextpage", nextNextpage);

	    return map;
	}

}
