package com.olts.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olts.service.ITechCategoryService;
import com.olts.vo.TechCategory;

@Controller
@RequestMapping("/category")
public class TechCategoryController {

	@Resource
	private ITechCategoryService techCategoryService;
	
	/**
	 * 查询某一课程的知识点
	 * @param courseId
	 * @return
	 */
	@RequestMapping("/selectAllCategory.do")
	public @ResponseBody List<TechCategory> selectAllCategory(Integer courseId){
		List<TechCategory> categoryList = techCategoryService.selectAllCategory(courseId);
		return categoryList;
		
	}
}
