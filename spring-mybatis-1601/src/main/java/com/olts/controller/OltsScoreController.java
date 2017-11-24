package com.olts.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.olts.service.IOltsScoreService;
import com.olts.vo.Examination;
import com.olts.vo.OltsScore;
import com.olts.vo.OltsUsers;




@Controller
@RequestMapping("/score")
public class OltsScoreController {
	@Resource
	private IOltsScoreService oltsScoreService;
	
	@RequestMapping("/selectAll.do")
	public String selectScoreAll(ModelMap modelMap, Examination e,HttpServletRequest request){
		String examNo=request.getParameter("examNo");
		if (examNo!=null ||examNo==""){
			e.setExamNo(examNo);
		}
		System.out.println("==================="+e.getExamNo());
		
		modelMap.addAttribute("examNo", e.getExamNo());
		
		List<OltsScore> list= oltsScoreService.selectScoreAll(e.getExamNo());
		
		modelMap.addAttribute("scoreList", list);
		
		return "pages/examination/export_score_list";
	}
	
	
	@RequestMapping("/delete")
	public String deleteScore(OltsScore o,ModelMap modelMap){
		oltsScoreService.deleteScore(o.getId());
		return "redirect:/score/selectAll.do";
	}
	
	
	@RequestMapping("/update.do")
	public String updatescore(HttpServletRequest request){
		
		OltsScore sc=new OltsScore();
		
		String sco=request.getParameter("sco");
		Double score=Double.parseDouble(sco);
		String userIds=request.getParameter("userIds");
		Integer userId=	Integer.parseInt(userIds);
		String examNo=request.getParameter("exam");
		
		sc.setScore(score);  
		sc.setUserId(userId);
		sc.setExamNo(examNo);
		
		System.out.println(score);
		System.out.println("-------------------"+userIds);
	//	System.out.println("-------------------------------------------------"+examNo);
		//System.out.println(e.getScore());
		oltsScoreService.updateScore(sc);
		return "pages/examination/export_score_list";
	}
}
