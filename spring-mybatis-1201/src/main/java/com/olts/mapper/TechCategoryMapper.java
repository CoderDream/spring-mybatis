package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.vo.TechCategory;

@Repository
public interface TechCategoryMapper {
	
	/**
	 * 查询某一课程的知识点
	 * @param courseId
	 * @return
	 */
	public List<TechCategory> selectAllCategory(Integer courseId); 
	
	/**
	 * 根据ID查询知识点
	 * @param id
	 * @return
	 */
	public TechCategory selectCategoryById(Integer id); 

}
