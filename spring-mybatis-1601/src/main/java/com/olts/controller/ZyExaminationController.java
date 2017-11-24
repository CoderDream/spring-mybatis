package com.olts.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;


import com.olts.service.IZyExaminationService;
import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.OltsUsers;

/**
 * @author 曾杨
 *
 */
@Controller
@RequestMapping("/examination")
@SessionAttributes("exam")
public class ZyExaminationController {
	
	@Resource
	IZyExaminationService zyExaminationService;
	
	
	/**
	 * 判断试卷是否存在
	 * @param examination
	 * @return
	 */
	@RequestMapping("query.do")
	public @ResponseBody String selectExaminationByPrimaryKey(Examination examination){
		Examination exam = zyExaminationService.selectExaminationByPrimaryKey(examination.getExamNo());
		if(exam!=null)
			return "true";
		return "false";
	}
	
	/**
	 * 查询所有可以考试的考卷
	 * @return
	 */
	@RequestMapping("searchExamination.do")
	public String searchAllByValidFlad(Examination examination,ModelMap modelMap){
		List<Examination> examList = zyExaminationService.selectExaminationByValidFlag();
		modelMap.addAttribute("examList", examList);
		return "/examination/examination_input";
	}
	
	/**
	 * 查询考卷
	 * @param examination
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("queryDetail.do")
	public String queryDetail(Examination examination,ModelMap modelMap){
		Examination exam = zyExaminationService.selectExaminationByPrimaryKey(examination.getExamNo());
		modelMap.addAttribute("exam", exam);
		return "/examination/examination";
	}

	/**
	 * 查询所有可以阅卷的考卷
	 * @return
	 */
	@RequestMapping("searchExamByFlag.do")
	public String searchAllByFlag(Examination examination,ModelMap modelMap){
		List<Examination> examList = zyExaminationService.selectExaminationByValidFlag();
		modelMap.addAttribute("examList", examList);
		return "pages/examination/csp_answer_input";
	}
	
	/**
	 * 查找所有该考卷的答案
	 * @param examination
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("searchUserAnswerByExamNo.do")
	public String searchAnswerByExamNo(Examination examination,ModelMap modelMap){
		
		List<OltsUsers> userAnswerList =zyExaminationService.selectUserAnswertByExamNo(examination.getExamNo());
		
		modelMap.addAttribute("userList", userAnswerList);
		
		modelMap.addAttribute("exam", examination);
		
		return "pages/examination/csp_answer_list";
	}
}
