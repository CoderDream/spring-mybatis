package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.vo.Courses;

@Repository
public interface CoursesMapper {

	/**
	 * 查询所有课程
	 * @return
	 */
	public List<Courses> selectAllCourses();
}
