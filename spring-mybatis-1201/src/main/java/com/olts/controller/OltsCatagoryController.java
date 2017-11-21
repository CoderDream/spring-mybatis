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
@RequestMapping("/secure")
public class OltsCatagoryController {
	
	@Resource
	private IOltsCatagoryService oltsCatagoryService;
	
	
	
	
	@RequestMapping("/list.do")
	public String list(ModelMap modelMap){
		List<OltsCatagory> list=oltsCatagoryService.findListForCatagory();
		modelMap.addAttribute("CatagoryList", list);
		return "pages/catagory/catagory_input"; 
	}
	
	@RequestMapping("/addCatagory.do")
	public String addCatagory(OltsCatagory catagory,ModelMap modelMap){
		oltsCatagoryService.saveCatagory(catagory);
		return "redirect:/secure/list.do";
	}
	
	@RequestMapping("/delete.do")
	public String deleteCatagory(OltsCatagory catagory,ModelMap modelMap){
		oltsCatagoryService.deleteCatagory(catagory.getId());
		return "redirect:/secure/list.do";
	}
	
	@RequestMapping("/update.do")
	public String updateCatagory(OltsCatagory catagory,ModelMap modelMap){
		oltsCatagoryService.updateCatagory(catagory);
		return "redirect:/secure/list.do";
	}
	
	@RequestMapping("/search.do")
	public void searchCatagory(OltsCatagory catagory,ModelMap modelMap){
		OltsCatagory o=oltsCatagoryService.findById(catagory.getId());
		modelMap.addAttribute("catagory", o);
	}
	//知识点===============================================
	@RequestMapping("/listforquest.do")
	public String listforquest(ModelMap modelMap){
		List<OltsCatagory> list=oltsCatagoryService.findListForCatagory();
		modelMap.addAttribute("CatagoryList", list);
		return "pages/catagory/questCatagory_input"; 
	} 
}
