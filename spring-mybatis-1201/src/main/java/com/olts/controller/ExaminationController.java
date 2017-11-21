 package com.olts.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.olts.service.IExaminatonService;
import com.olts.service.IFspAnswerService;
import com.olts.service.IFspQuestionsService;
import com.olts.service.IOltsScoreService;
import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.FspQuestions;
import com.olts.vo.OltsScore;
import com.olts.vo.OltsUsers;
import com.olts.vo.SmdQuestions;


@Controller
@RequestMapping("/exam")
@SessionAttributes({"examList"})
public class ExaminationController {
	
	@Resource
	private IExaminatonService examinatonService;

	@Resource
	private IOltsScoreService iOltsScoreService;
	
	@Resource
	private IFspAnswerService fspAnswerService;
	
	
	@RequestMapping("/selectAll.do")
	public String selectExamintion(Examination examination,ModelMap modelMap,String flag){
		List<Examination> examList=examinatonService.select();
		modelMap.addAttribute("examList", examList);
		if(flag.equals("1")){
			return "pages/examination/examination_input";
		}
		if(flag.equals("2")){
			return "pages/examination/exam_manage_input";
		}
		if(flag.equals("5")){
			return "pages/question/shortAnswer_list";
		}
		if(flag.equals("6")){
			return "pages/question/program_list";
		}
		return "pages/examination/export_score_input";
		
	}
	
	@RequestMapping("/selectAll2.do")
	public @ResponseBody List<Examination> selectExamintion2(Examination examination,ModelMap modelMap){
		List<Examination> examList=examinatonService.select();
		modelMap.addAttribute("examList", examList);
		return examList;
		
	}

	@RequestMapping("/selectExam.do")
	public String selectExam(Examination ex ,ModelMap modelMap,String flag){
		Examination exam=examinatonService.selectExam(ex.getExamNo());
		if(exam!=null){
			System.out.println(exam);
			
			String singleId=exam.getSingleId();
			List<SmdQuestions> singlist=null;
			if(singleId!=null){
				singlist=examinatonService.selectSmdQuestion(singleId);
			}
			
			String multpleId=exam.getMultpleId();
			List<SmdQuestions> multlist=null;
			if(multpleId!=null){
				multlist=examinatonService.selectSmdQuestion(multpleId);
			}
			
			String trueFalseId=exam.getTrueFalseId();
			List<SmdQuestions> tflist=null;
			if(trueFalseId!=null){
				tflist=examinatonService.selectSmdQuestion(trueFalseId);
			}
			
			String simpleAnwserId=exam.getSimpleAnwserId();
			List<FspQuestions> simlist=null;
			if(simpleAnwserId!=null){
			simlist=examinatonService.selectFspQuestion(simpleAnwserId);
			}
			
			String programId=exam.getProgramId();
			List<FspQuestions> prolist=null;
			if(programId!=null){
			prolist=examinatonService.selectFspQuestion(programId);
			}
			modelMap.addAttribute("singlist",singlist);
			modelMap.addAttribute("multlist",multlist);
			modelMap.addAttribute("tflist",tflist);
			modelMap.addAttribute("simlist",simlist);
			modelMap.addAttribute("prolist",prolist);
			modelMap.addAttribute("exam",exam);
			if(flag.equals("1")){
				return "pages/examination/examination";
			}
			if(flag.equals("2")){
				return "pages/examination/exam_saveAsWord";
			}
		}
		if(flag.equals("1")){
			return "pages/examination/exam_manager_input";
		}
		if(flag.equals("2")){
			return "pages/examination/exam_input";
		}
		return null;
	}
	@RequestMapping("/removeQuestion.do")
	public String removeQuestion(String examNo,String id,String questionType){
		Examination exam=examinatonService.selectExam(examNo);
		if(questionType.equals("1")){
			String singleId=exam.getSingleId();
			singleId=singleId.replaceAll(id, "");
			System.out.println(singleId+"单选");
			exam.setSingleId(singleId);
		}
		if(questionType.equals("2")){
			String multpleId=exam.getMultpleId();
			multpleId=multpleId.replaceAll(id, "");
			System.out.println(multpleId+"多选");
			exam.setMultpleId(multpleId);
		}
		if(questionType.equals("3")){
			String trueFalseId=exam.getTrueFalseId();
			trueFalseId=trueFalseId.replaceAll(id, "");
			System.out.println(trueFalseId+"判断");
			exam.setTrueFalseId(trueFalseId);
		}
		if(questionType.equals("5")){
			String simpleAnwserId=exam.getSimpleAnwserId();
			simpleAnwserId=simpleAnwserId.replaceAll(id, "");
			System.out.println(simpleAnwserId+"简答");
			exam.setSimpleAnwserId(simpleAnwserId);
		}
		if(questionType.equals("6")){
			String programId=exam.getProgramId();
			programId=programId.replaceAll(id, "");
			System.out.println(programId+"编程");
			exam.setProgramId(programId);
		}
		this.examinatonService.updateExamination(exam);
		return "redirect:/exam/selectExam.do?examNo="+examNo+"&flag=1";
	}
	//完成出卷
	
	@RequestMapping("/completingExamination.do")
	public String completingExamination(String examNo,ModelMap modelMap){
		Examination exam=examinatonService.selectExam(examNo);
		exam.setValidFlag(1);
		this.examinatonService.updateExamination(exam);
		modelMap.addAttribute("exam",exam);
		return "pages/examination/completing_exam";
	}

	@RequestMapping("/endExam.do")
	public @ResponseBody String endExam(String examNo,ModelMap modelMap){
		Examination exam=examinatonService.selectExam(examNo);
		exam.setValidFlag(0);
		this.examinatonService.updateExamination(exam);
		System.out.println("------------------------------------");
		return "true";
	}
	@RequestMapping("/saveAnswer.do")
	public String saveAnswer(String key[],String answer[],String userId,String examNo,ModelMap modelMap){
		int sing=0;
		int mult=0;
		int tf=0;
		List<String> singanswer=new ArrayList<String>();
		List<String> multanswer=new ArrayList<String>();
		List<String> tfanswer=new ArrayList<String>();
		List<String> simanswer=new ArrayList<String>();
		List<String> proanswer=new ArrayList<String>();
	
		
		Examination exam=examinatonService.selectExam(examNo);
		for(int i=0;i<key.length;i++){
			System.out.println("题号:"+key[i]+"答案："+answer[i]);
			
			if(key[i].contains("radio")){
				String singid=key[i].substring(5);
				SmdQuestions smd=this.examinatonService.selectSmdQuestionById(singid);
				singanswer.add(answer[i]);
				System.out.println(smd);
				if(answer[i].equals(smd.getCorrect())){
					sing++;
				}	
			}
			if(key[i].contains("multiple")){
				String singid=key[i].substring(8);
				SmdQuestions smd=this.examinatonService.selectSmdQuestionById(singid);
				multanswer.add(answer[i]);
				System.out.println(smd);
				if(answer[i].equals(smd.getCorrect())){
					mult++;
				}	
			}
			if(key[i].contains("tf")){
				String singid=key[i].substring(2);
				SmdQuestions smd=this.examinatonService.selectSmdQuestionById(singid);
				tfanswer.add(answer[i]);
				System.out.println(smd);
				if(answer[i].equals(smd.getCorrect())){
					tf++;
				}	
			}
			if(key[i].contains("sim")){
				String singid=key[i].substring(3);
				FspQuestions fsp=this.examinatonService.selectFspQuestionById(singid);
				simanswer.add(answer[i]);			
			}
			if(key[i].contains("pro")){
				String singid=key[i].substring(3);
				FspQuestions fsp=this.examinatonService.selectFspQuestionById(singid);
				proanswer.add(answer[i]);
			}
			
			//简答题
			if(key[i].contains("sim")){
				String singid=key[i].substring(3);
				
				FspQuestions fsp=this.examinatonService.selectFspQuestionById(singid);
				
				FspAnswer fspAnswer=new FspAnswer();
				OltsUsers user=new OltsUsers();
				user.setId(Integer.parseInt(userId));
				
				fspAnswer.setAnswer(answer[i]);
				fspAnswer.setFsp(fsp);
				fspAnswer.setUser(user);
				fspAnswer.setExam(exam);
				
				//IFspAnswerService fspAnswerService = null;
				fspAnswerService.insertAnswer(fspAnswer);
			}
			
			//编程题
			if(key[i].contains("pro")){
				String singid=key[i].substring(3);
				FspQuestions fsp=this.examinatonService.selectFspQuestionById(singid);	
				FspAnswer fspAnswer=new FspAnswer();
				OltsUsers user=new OltsUsers();
				user.setId(Integer.parseInt(userId));
				
				fspAnswer.setAnswer(answer[i]);
				fspAnswer.setFsp(fsp);
				fspAnswer.setUser(user);
				fspAnswer.setExam(exam);
				
				//IFspAnswerService fspAnswerService = null;
				fspAnswerService.insertAnswer(fspAnswer);
			}
			
		}
		System.out.println("单选"+sing+"duoxuan"+mult+"判断"+tf);
		double score=0;
		score=sing*2+mult*4+tf*1;
		
		//封装score
		OltsScore e=new OltsScore();
		e.setUserId(Integer.parseInt(userId));
		e.setExamNo(examNo);
		e.setScore(score);
		System.out.println(e+"zzzzzzzzzzzzzzzzzzz");
		iOltsScoreService.insertScore(e);
		
		System.out.println("得分："+score);	
		String singleId=exam.getSingleId();
		List<SmdQuestions> singlist=null;
		if(singleId!=null){
			singlist=examinatonService.selectSmdQuestion(singleId);
		}
		
		String multpleId=exam.getMultpleId();
		List<SmdQuestions> multlist=null;
		if(multpleId!=null){
			multlist=examinatonService.selectSmdQuestion(multpleId);
		}
		
		String trueFalseId=exam.getTrueFalseId();
		List<SmdQuestions> tflist=null;
		if(trueFalseId!=null){
			tflist=examinatonService.selectSmdQuestion(trueFalseId);
		}
		
		String simpleAnwserId=exam.getSimpleAnwserId();
		List<FspQuestions> simlist=null;
		if(simpleAnwserId!=null){
		simlist=examinatonService.selectFspQuestion(simpleAnwserId);
		}
		
		String programId=exam.getProgramId();
		List<FspQuestions> prolist=null;
		if(programId!=null){
		prolist=examinatonService.selectFspQuestion(programId);
		}
		modelMap.addAttribute("score",score);
		modelMap.addAttribute("sing",sing);
		modelMap.addAttribute("mult",mult);
		modelMap.addAttribute("tf",tf);
		modelMap.addAttribute("singlist",singlist);
		modelMap.addAttribute("multlist",multlist);
		modelMap.addAttribute("tflist",tflist);
		modelMap.addAttribute("simlist",simlist);
		modelMap.addAttribute("prolist",prolist);
		modelMap.addAttribute("exam",exam);
		modelMap.addAttribute("singanswer",singanswer);
		modelMap.addAttribute("multanswer",multanswer);
		modelMap.addAttribute("tfanswer",tfanswer);
		modelMap.addAttribute("simanswer",simanswer);
		modelMap.addAttribute("proanswer",proanswer);
		System.out.println("-----------------------------");
		return "pages/examination/examination_over";
	}



	/**
	 * 将试题插入考卷
	 * @param programIds
	 * @param examNo
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/updateExamination.do")
	public @ResponseBody List updateExamination(String idCards[],String type,Examination ex,ModelMap modelMap){
		String s1 = "";  //要添加的试题题号字符串
		String s2;  //原试题题号+要添加的试题题号
		//String s3="";  //原考卷已存在的试题
		List s3 = new ArrayList();
		boolean f = false;  //要添加的题号是否存在
		
		Pattern p = Pattern.compile("[0-9\\.]+");

	
		Examination exam=examinatonService.selectExam(ex.getExamNo());
		for (String s : idCards) {
			s1=s1+s+",";
		}
		if("5".equals(type)){
			String simpleAnwserId = exam.getSimpleAnwserId(); //得到考卷中的简答题编号字符串
			if(simpleAnwserId==null){
				s2=s1;
				exam.setSimpleAnwserId(s2);
			}else{
				Matcher sim = p.matcher(simpleAnwserId);  //取出简答题题号
				 while(sim.find()){  //循环考卷中的简答题题号
					 for (String s : idCards) {  //循环要添加的题号
						 if(sim.group().equals(s)){
							 s3.add(s);
							 f = true;
						 }
					}
				 }
				 //s4 = s3;
				/* if(s4.length()>=1){
					 s4=s4.substring(0,s4.length()-1);
				 }*/
				 if(f==true){
					 return s3;
				 }else{
					s2=simpleAnwserId+s1;
					exam.setSimpleAnwserId(s2);
				 }
			}
			
			 
		}
		if("6".equals(type)){
			String programId = exam.getProgramId();
			if(programId==null){
				s2=s1;
				exam.setProgramId(s2);
			}else{
				Matcher sim = p.matcher(programId);  //取出简答题题号
				 while(sim.find()){  //循环考卷中的简答题题号
					 for (String s : idCards) {  //循环要添加的题号
						 if(sim.group().equals(s)){
							// s3=s3+s+",";
							 s3.add(s);
							 f = true;
						 }
					}
				 }
				 /*s4 = s3;
				 if(s4.length()>=1){
					 s4=s4.substring(0,s4.length()-1);
				 }*/
				 if(f==true){
					 return s3;
				 }else{
					s2=programId+s1;
					exam.setProgramId(s2);
				 }
			}
		}
		examinatonService.updateExamination(exam);
		return s3;
		
	}
}
