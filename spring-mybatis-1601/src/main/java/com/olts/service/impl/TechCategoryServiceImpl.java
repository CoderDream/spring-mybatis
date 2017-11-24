package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.CoursesMapper;
import com.olts.mapper.TechCategoryMapper;
import com.olts.service.ICoursesService;
import com.olts.service.ITechCategoryService;
import com.olts.vo.TechCategory;

@Service("techCategoryService")
public class TechCategoryServiceImpl implements ITechCategoryService{

	@Resource
	private TechCategoryMapper techCategoryMapper;

	/**
	 * 查询某一课程的知识点
	 */
	@Override
	public List<TechCategory> selectAllCategory(Integer courseId) {
		return techCategoryMapper.selectAllCategory(courseId);
	}

	/**
	 * 根据ID查询知识点
	 */
	@Override
	public TechCategory selectCategoryById(Integer id) {
		return techCategoryMapper.selectCategoryById(id);
	}
}
