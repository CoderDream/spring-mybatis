package zhaojin.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import zhaojin.service.StudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private StudentService studentService;
	
	@RequestMapping(params="method=allPapers")
	public ModelAndView allPapers(){
		ModelAndView view = new ModelAndView();
		view.setViewName("studentPages/Paper");
		return view;
	}
	@RequestMapping(params="method=goTest")
	public ModelAndView goTest(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		request.setAttribute("goTest","2");
		view.setViewName("studentPages/Paper");
		return view;
	}
	
	@RequestMapping(params="method=enterTestPage")
	public ModelAndView enterTestPage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		request.setAttribute("paperId",request.getParameter("paperId"));
		request.setAttribute("validateTime",request.getParameter("time"));
		request.setAttribute("trueName",request.getParameter("trueName"));
		try {
			request.setAttribute("paperName",URLDecoder.decode(request.getParameter("paperName"),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		view.setViewName("studentPages/testPage");
		return view;
	}
	@RequestMapping(params="method=gotoExamDonePage")
	public ModelAndView gotoExamDonePage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		view.setViewName("studentPages/examDonePage");
		return view;
	}
	@RequestMapping(params="method=gotoWrongQuestionsPage")
	public ModelAndView gotoWrongQuestionsPage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		view.setViewName("studentPages/wrongQuestionsPage");
		return view;
	}
	@RequestMapping(params="method=getTestInfo")
	@ResponseBody
	public String getTestInfo(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
		Map<String,Object> p = new HashMap<String,Object>();
		p.put("paperId", request.getParameter("paperId"));
		List<Map<String, Object>> questionInfoByPaperId = studentService.getQuestionInfoByPaperId(p);
		for(int i = 0;i<questionInfoByPaperId.size();i++){
			p.put("questId",questionInfoByPaperId.get(i).get("questID"));
			List<Map<String, Object>> questionDetailInfoByQuestId = studentService.getQuestionDetailInfoByQuestId(p);
			for(Map<String, Object> k : questionDetailInfoByQuestId){
				questionInfoByPaperId.get(i).put((String) k.get("optionNo"),k.get("optionContent")==null?"-":k.get("optionContent"));
			}
			returnList.add(questionInfoByPaperId.get(i));
		}
		return g.toJson(returnList);
	}
	
	@RequestMapping(params="method=maskPaper")
	@ResponseBody
	public String maskPaper(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> param = new HashMap<String,Object>();
		String jsonArr = request.getParameter("rr"); 
		Object attribute = request.getSession().getAttribute("optID");
		String parameter = request.getParameter("paperId");
		param.put("optID", attribute);
		param.put("paperId", parameter);
		
		JSONArray fromObject = JSONArray.fromObject(jsonArr);
		int totalScore = 0;
		for(int i = 0;i<fromObject.size();i++){
			JSONObject jo = JSONObject.fromObject(fromObject.get(i));
			String answer = jo.getString("answer");
			String myAnswer = jo.getString("easyLevel");
			if(!answer.equals(myAnswer)){
				param.put("questId", jo.getString("questID"));
				param.put("myAnswer", myAnswer);
				param.put("answer", answer);
				param.put("score", jo.getString("score"));
				studentService.insertIntoStudscoredetail(param);
			}else{
				totalScore += Integer.parseInt(jo.getString("score"));
			}		
		}
		param.put("totalScore", totalScore);
		studentService.insertIntoStudscore(param);
		Gson g = new Gson();
		return g.toJson("ok");
	}
	@RequestMapping(params="method=getStudentScoreInfo")
	@ResponseBody
	public Map<String,Object> getStudentScoreInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> returnMap = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("optID", request.getSession().getAttribute("optID"));
		if(request.getParameter("paperName") != null && !"".equals(request.getParameter("paperName"))){
			try {
				param.put("paperName", "'%"+URLDecoder.decode(request.getParameter("paperName"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(request.getParameter("byUser") != null && !"".equals(request.getParameter("byUser"))){
			try {
				param.put("byUser", "'%"+URLDecoder.decode(request.getParameter("byUser"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//分页
		Integer questionCount = studentService.getDoneExamCount(param);
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		if(questionCount != 0){
		int maxPages = questionCount.intValue()%Integer.parseInt(rows) == 0?questionCount.intValue()/Integer.parseInt(rows):questionCount.intValue()/Integer.parseInt(rows)+1 ;
		if(Integer.parseInt(page) < 1){
			param.put("startrum", "1");
			param.put("size", Integer.parseInt(rows));
		}else
		if(Integer.parseInt(page)>=maxPages){
			param.put("startrum", (maxPages-1)*Integer.parseInt(rows));
			param.put("size", Integer.parseInt(rows));
		}else{
			param.put("startrum", (Integer.parseInt(page)-1)*Integer.parseInt(rows));
			param.put("size", Integer.parseInt(rows));
		}
		}
		List<Map<String, Object>> examDoneInfo = studentService.getExamDoneInfo(param);
		returnMap.put("total", questionCount.intValue());
		returnMap.put("rows", examDoneInfo);
		return returnMap;
	}
	
	@RequestMapping(params="method=getStudentWrongQuestInfo")
	@ResponseBody
	public Map<String,Object> getStudentWrongQuestInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> returnMap = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("optID", request.getSession().getAttribute("optID"));
		if(request.getParameter("paperName") != null && !"".equals(request.getParameter("paperName"))){
			try {
				param.put("paperName", "'%"+URLDecoder.decode(request.getParameter("paperName"),"utf-8")+"%'");
				param.put("doSerach", "111");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(request.getParameter("mainContent") != null && !"".equals(request.getParameter("mainContent"))){
			try {
				param.put("mainContent", "'%"+URLDecoder.decode(request.getParameter("mainContent"),"utf-8")+"%'");
				param.put("doSerach", "111");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//分页
		Integer questionCount = studentService.getWrongQuestCount(param);
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		if(questionCount != 0){
		int maxPages = questionCount.intValue()%Integer.parseInt(rows) == 0?questionCount.intValue()/Integer.parseInt(rows):questionCount.intValue()/Integer.parseInt(rows)+1 ;
		if(Integer.parseInt(page) < 1){
			param.put("startrum", "1");
			param.put("size", Integer.parseInt(rows));
		}else
		if(Integer.parseInt(page)>=maxPages){
			param.put("startrum", (maxPages-1)*Integer.parseInt(rows));
			param.put("size", Integer.parseInt(rows));
		}else{
			param.put("startrum", (Integer.parseInt(page)-1)*Integer.parseInt(rows));
			param.put("size", Integer.parseInt(rows));
		}
		}
		List<Map<String, Object>> examDoneInfo = studentService.getWrongQuestInfo(param);
		Map<String,Object> p = new HashMap<String,Object>();
		for(int i = 0;i<examDoneInfo.size();i++){
			if("none".equals(examDoneInfo.get(i).get("myAnswer"))){
				examDoneInfo.get(i).put("myAnswer","空");
			}
			p.put("paperDetailID", examDoneInfo.get(i).get("paperDetailID"));
			examDoneInfo.get(i).putAll(studentService.getPaperInfoAndQuestInfoByPaperdetailID(p));
		}
		//{paperName=thrid卷子, optID=110, paperID=4, fullScore=34, score=3, answer=B, paperTime=2017-02-03 18:13:13.0, available=2017-06-27 09:16:41.0, validateTime=1, easyLevel=简单, byUser=3434, questID=7, myAnswer=none, paperDetailID=37, mainContent=tttttttttttttttt, studscoreDetailID=25}
		returnMap.put("total", questionCount.intValue());
		returnMap.put("rows", examDoneInfo);
		return returnMap;
	}
}
