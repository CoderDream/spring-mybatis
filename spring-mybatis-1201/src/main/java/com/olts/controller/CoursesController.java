package com.olts.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olts.service.ICoursesService;
import com.olts.vo.Courses;

@Controller
@RequestMapping("/courses")
public class CoursesController {

	@Resource
	private ICoursesService  coursesService;
	
	
	/**
	 * 查询所有课程
	 * @return
	 */
	@RequestMapping("/selectAllCourses.do")
	public @ResponseBody List<Courses> selectAllCourses(ModelMap modelMap){
		List<Courses> coursesList = coursesService.selectAllCourses();
		modelMap.addAttribute("coursesList", coursesList);
		return coursesList;
		
	}
	
}
