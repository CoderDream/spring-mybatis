package com.olts.service;

import java.util.List;

import com.olts.vo.TechCategory;


public interface ITechCategoryService {

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
