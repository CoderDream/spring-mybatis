package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.CoursesMapper;
import com.olts.service.ICoursesService;
import com.olts.vo.Courses;

@Service("coursesService")
public class CoursesServiceImpl implements ICoursesService{

	@Resource
	private CoursesMapper coursesMapper;

	/**
	 * 查询所有课程
	 */
	@Override
	public List<Courses> selectAllCourses() {
		return coursesMapper.selectAllCourses();
	}
}
