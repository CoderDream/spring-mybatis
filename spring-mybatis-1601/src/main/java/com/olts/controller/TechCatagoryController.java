package com.olts.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.connector.Request;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.olts.commons.StringUtil;
import com.olts.service.IOltsCatagoryService;
import com.olts.service.IOltsUsersService;
import com.olts.service.ITechCatagoryService;
import com.olts.vo.OltsCatagory;
import com.olts.vo.OltsUsers;
import com.olts.vo.TechCatagory;



@Controller
@RequestMapping("/tech")
public class TechCatagoryController {
	
	@Resource
	private ITechCatagoryService techCatagoryService;
	
	@RequestMapping("/search.do")
	public String searchTech(OltsCatagory catagory,ModelMap modelMap){
		List<TechCatagory> techList=techCatagoryService.listForTech(catagory);
		modelMap.addAttribute("techList", techList);
		return "forward:/secure/listforquest.do";
	}
	
	@RequestMapping("/addTech.do")
	public String addTech(TechCatagory tech){
		int row=techCatagoryService.saveTech(tech);
		return "forward:/secure/listforquest.do";
	}
	
	@RequestMapping("/delete.do")
	public String deleteTech(TechCatagory tech){
		int row=techCatagoryService.deleteTech(tech);
		return "forward:/secure/listforquest.do";
	}
	
	@RequestMapping("/update.do")
	public String updateTech(TechCatagory tech){
		int row=techCatagoryService.updateTech(tech);
		return "forward:/secure/listforquest.do";
	}
}
