package com.spring.finall.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.InsertCategoryRequestDTO;
import com.spring.finall.reqDto.getCateGoryListDTO.GetCateGoryListDTO;


@Repository
public class CategoryServiceDAO {

    @Autowired
    private SqlSessionTemplate mybatis;

    /**
     * 상위 카테고리 + 하위 카테고리 + 속성 insert
     */
    public int insertCategoryWithChildrenAndAttributes(InsertCategoryRequestDTO dto) {
        // 1. 상위 카테고리 insert
    	// 1. 상위 카테고리 insert
        mybatis.insert("CategoryMapper.insertCategory", dto);

        // ⭐ 여기서 PK 꺼내야 함
        int parentPk = dto.getCategoryId();

        // 2. 하위 카테고리 insert
        insertChildCategories(parentPk, dto.getChildren());

        // 3. 속성 insert(아직 리퀘스트 디티오 없음)
       // insertCategoryAttributes(parentPk, dto.getAttributes());

        return parentPk;
    }

    /**
     * 하위 카테고리 insert 전용
     */
    private void insertChildCategories(int parentPk, List<String> children) {
        if(children == null || children.isEmpty()) return;

        for(String childName : children) {
            Map<String, Object> params = new HashMap<>();
            params.put("parent_id", parentPk);
            params.put("name", childName);
            params.put("sort_order", 0);
            params.put("is_active", true);

            mybatis.insert("CategoryMapper.insertChildrenCategory", params);
        }
    }

    /**
     * 카테고리 속성 insert 전용
     */
//    private void insertCategoryAttributes(int parentPk, List<InsertCategoryAttributeDTO> attributes) {
//        if(attributes == null || attributes.isEmpty()) return;
//
//        for(InsertCategoryAttributeDTO attr : attributes) {
//            Map<String, Object> params = new HashMap<>();
//            params.put("category_id", parentPk);
//            params.put("name", attr.getName());
//            params.put("input_type", attr.getInputType());
//            params.put("options", attr.getOptions());
//            params.put("is_required", attr.isRequired());
//
//            mybatis.insert("CategoryMapper.insertCategoryAttribute", params);
//        }
//    }
    
    
    public List<GetCateGoryListDTO> getCategoryList() {
		// TODO Auto-generated method stub
		return   mybatis.selectList("CategoryMapper.getCategoryList");
	}
	
}
