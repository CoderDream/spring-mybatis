package com.olts.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.olts.commons.Page;
import com.olts.service.IFspQuestionsService;
import com.olts.service.ITechCategoryService;
import com.olts.vo.FspQuestions;
import com.olts.vo.TechCategory;

@Controller
@RequestMapping("/fsp")
public class FspQuestionsController {
	
	@Resource
	private IFspQuestionsService fspQuestionsService;
	@Resource
	private ITechCategoryService techCategoryService;
	
	

	/**
	 * 分页查询
	 * @param fspQuestions
	 * @param modelMap
	 * @param session
	 * @return
	 */
	@RequestMapping("/selectFspForPage.do")
	public String selectFspForPage(Integer flag,Integer pageNo,FspQuestions fspQuestions,ModelMap modelMap,HttpSession session){
		int count=0;
		if(fspQuestions.getQuestion()==null ||fspQuestions.getQuestion()==""){
			fspQuestions.setQuestion(null);
		}
		Page<FspQuestions> page=(Page<FspQuestions>)session.getAttribute("page");
		if (page==null || pageNo==null) {
			page = new Page<FspQuestions>();
			//设置每页显示的记录数
			page.setPageSize(Page.R5);
			page.setQueryObject(fspQuestions); //保存查询条件
			
			//统计记录数
			count = fspQuestionsService.selectFspCount(page);
			page.setTotalRow(count); //设置总记录数
		}else{
			page.setPageNo(pageNo); //点击分页链接时
		}
		List<FspQuestions> fspList = fspQuestionsService.selectFspForPage(page);
		modelMap.addAttribute("fspList", fspList);
		session.setAttribute("page", page);
		modelMap.addAttribute("count", count);
		if(flag==1){
			return "pages/question/shortAnswer_list";
		}
		if(flag==2){
			return "pages/question/program_list";
		}
		return null;
	}
	
	
	
	/**
	 * 按编号查询试题
	 * @param id
	 * @param techCateId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/selectFspById.do")
	public String selectFspById(FspQuestions fspQuestions, HttpServletRequest request){
		
		FspQuestions fsp = fspQuestionsService.selectFspById(fspQuestions);
		TechCategory category = techCategoryService.selectCategoryById(fsp.getTechCateId());
		request.setAttribute("fsp", fsp);
		request.setAttribute("category", category);
		return "pages/question/shortAnswer_input";
		
	}
	
	/**
	 * 按编号查询试题2
	 * @param id
	 * @param techCateId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/selectFspById2.do")
	public String selectFspById2(FspQuestions fspQuestions, HttpServletRequest request){
		
		FspQuestions fsp = fspQuestionsService.selectFspById(fspQuestions);
		TechCategory category = techCategoryService.selectCategoryById(fsp.getTechCateId());
		request.setAttribute("fsp", fsp);
		request.setAttribute("category", category);
		return "pages/question/program_input";
		
	}
	
	/**
	 * 更新试题
	 * @param fspQuestions
	 * @param modelMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/updateFsp.do")
	public String updateFsp(FspQuestions fspQuestions,Integer flag,ModelMap modelMap){
		fspQuestionsService.updateFsp(fspQuestions);
		if(flag==1){
			return "redirect:/pages/question/shortAnswer_list.jsp";
		}
		if(flag==2){
			return "redirect:/pages/question/program_list.jsp";
		}
		return null;
	}
	
	/**
	 * 删除试题
	 * @param fspQuestions
	 */
	@RequestMapping("/deleteFsp.do")
	public void deleteFsp(FspQuestions fspQuestions){
		fspQuestionsService.deleteFsp(fspQuestions);
	}
	
	/**
	 * 插入简答题
	 * @param fspQuestions
	 * @return
	 */
	@RequestMapping("/insertFsp.do")
	public String insertFsp(FspQuestions fspQuestions){
		
		fspQuestionsService.insertFsp(fspQuestions);
		return "pages/question/shortAnswer_list";
	}
	
	/**
	 * 插入编程题
	 * @param fspQuestions
	 * @return
	 */
	@RequestMapping("/insertFsp2.do")
	public String insertFsp2(FspQuestions fspQuestions){
		fspQuestionsService.insertFsp(fspQuestions);
		return "pages/question/program_list";
	}

}
