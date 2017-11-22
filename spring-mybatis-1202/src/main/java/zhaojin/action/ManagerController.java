package zhaojin.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import zhaojin.service.LoginService;
import zhaojin.service.ManagerService;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	@Autowired
	private ManagerService managerService;
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(params="method=enterTikuPage")
	public ModelAndView enterTikuPage(){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/question/Tiku");
		return view;
	}
	@RequestMapping(params="method=enterPaperPage")
	public ModelAndView enterPaperPage(){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/paper/Paper");
		return view;
	}
	@RequestMapping(params="method=enterStudentScorePage")
	public ModelAndView enterStudentScorePage(){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/StudentScore");
		return view;
	}
	@RequestMapping(params="method=enterAccountMaintainPage")
	public ModelAndView enterAcountMaintainPage(){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/AccountMaintain");
		return view;
	}
	@RequestMapping(params="method=getQuestionInfo")
	@ResponseBody
	public Map<String,Object> getQuestionInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> returnMap = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		
		
		if(request.getParameter("type") != null && !"".equals(request.getParameter("type"))){
			try {
				param.put("type", "'%"+URLDecoder.decode(request.getParameter("type"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(request.getParameter("mainContent") != null && !"".equals(request.getParameter("mainContent"))){
			try {
				param.put("mainContent", "'%"+URLDecoder.decode(request.getParameter("mainContent"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//分页
		Integer questionCount = managerService.getQuestionCount(param);
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
		List<Map<String, Object>> questionInfo = managerService.getQuestionInfo(param);
		returnMap.put("total", questionCount.intValue());
		returnMap.put("rows", questionInfo);
		return returnMap;
	}
	@RequestMapping(params="method=enterAddQuestionPage")
	public ModelAndView enterAddQuestionPage(){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/question/AddQuestion");
		return view;
	}
	@RequestMapping(params="method=addQuestion")
	@ResponseBody
	public String addQuestion(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		try{
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("type", request.getParameter("type"));
		param.put("mainContent", request.getParameter("mainContent"));
		param.put("easyLevel", request.getParameter("easyLevel"));
		param.put("answer", request.getParameter("answer"));
		param.put("score", request.getParameter("score"));
		managerService.addQuestion(param);
		param.put("optionNo", "A");
		param.put("optionContent", request.getParameter("A"));
		managerService.addQuestionDetail(param);
		param.put("optionNo", "B");
		param.put("optionContent", request.getParameter("B"));
		managerService.addQuestionDetail(param);
		param.put("optionNo", "C");
		param.put("optionContent", request.getParameter("C"));
		managerService.addQuestionDetail(param);
		param.put("optionNo", "D");
		param.put("optionContent", request.getParameter("D"));
		managerService.addQuestionDetail(param);
		return g.toJson("ok");}
		catch(Exception e) {return g.toJson("no");}
	}
	@RequestMapping(params="method=delQuestion")
	@ResponseBody
	public String delQuestion(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		try {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("qusid", request.getParameter("qusid"));
		List<Map<String, Object>> allpaperDetailIdByQusId = managerService.getAllpaperDetailIdByQusId(param);
		if(allpaperDetailIdByQusId != null){
			for(Map<String, Object> k : allpaperDetailIdByQusId){
				param.put("paperDetailID", k.get("paperDetailID"));
				managerService.delStudScoreDetail(param);
			}
		}
		managerService.delQuestionPaperDetail(param);
		managerService.delQuestionDetail(param);
		managerService.delQuestion(param);
		return g.toJson("ok");
		}catch(Exception e) {
			return g.toJson(e.getMessage());
		}
	}
	@RequestMapping(params="method=getUpdateQuestionInfo")
	@ResponseBody
	public List<Map<String,Object>> getUpdateQuestionInfo(HttpServletRequest request,HttpServletResponse response){
		List<Map<String,Object>> returnList = new ArrayList<Map<String,Object>>();
		Map<String,Object> p = new HashMap<String,Object>();
		p.put("questId", request.getParameter("questId"));
		List<Map<String, Object>> questionInfo = managerService.getQuestionInfo(p);
		List<Map<String, Object>> questionDetailInfo = managerService.getQuestionDetailInfo(p);
		p = new HashMap<String,Object>();
		p.put("name", "题型");
		p.put("value", questionInfo.get(0).get("type")==null?"-":questionInfo.get(0).get("type"));
		p.put("group",  "1");
		String parameter = request.getParameter("pageName");
		if(!"wrong".equals(parameter)){
			p.put("editor", "text");
		}
		p.put("eName", "type");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "题干");
		p.put("value", questionInfo.get(0).get("mainContent"));
		p.put("group",  "1");
		if(!"wrong".equals(parameter)){
			p.put("editor", "text");
		}
		p.put("eName", "mainContent");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "占分");
		p.put("value", questionInfo.get(0).get("score"));
		p.put("group",  "1");
		if(!"wrong".equals(parameter)){
			p.put("editor", "text");
		}
		p.put("eName", "score");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "难易程度");
		p.put("value", questionInfo.get(0).get("easyLevel"));
		p.put("group",  "1");
		if(!"wrong".equals(parameter)){
			p.put("editor", "text");
		}
		p.put("eName", "easyLevel");
		returnList.add(p);p = new HashMap<String,Object>();
		p.put("name", "答案");
		p.put("value", questionInfo.get(0).get("answer"));
		p.put("group",  "1");
		if(!"wrong".equals(parameter)){
			p.put("editor", "text");
		}
		p.put("eName", "answer");
		returnList.add(p);
		for(Map<String,Object> k : questionDetailInfo){
			p = new HashMap<String,Object>();
			if(((String)k.get("optionNo")).equals("A")){
				p.put("name", "选项A");
				p.put("eName", "A");
			}
			else if(((String)k.get("optionNo")).equals("B")){
				p.put("name", "选项B");
				p.put("eName", "B");
			}
			else if(((String)k.get("optionNo")).equals("C")){
				p.put("name", "选项C");
				p.put("eName", "C");
			}
			else{
				p.put("name", "选项D");
				p.put("eName", "D");
				}
			p.put("value", k.get("optionContent"));
			p.put("group",  "1");
			if(!"wrong".equals(parameter)){
				p.put("editor", "text");
			}
			returnList.add(p);
		}
		return returnList;
	}
	
	
	@RequestMapping(params="method=updateQuestion")
	@ResponseBody
	public String updateQuestion(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		try {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("questId", request.getParameter("questId"));
		param.put("type", request.getParameter("type"));
		param.put("mainContent", request.getParameter("mainContent"));
		param.put("score", request.getParameter("score"));
		param.put("easyLevel", request.getParameter("easyLevel"));
		param.put("answer", request.getParameter("answer"));
		managerService.updateQuestion(param);
		
		param = new HashMap<String,Object>();
		param.put("questId", request.getParameter("questId"));
		param.put("optionContent", request.getParameter("C"));
		param.put("optionNo", "C");
		managerService.updateQuestionDetail(param);
		param = new HashMap<String,Object>();
		param.put("questId", request.getParameter("questId"));
		param.put("optionContent", request.getParameter("A"));
		param.put("optionNo", "A");
		managerService.updateQuestionDetail(param);param = new HashMap<String,Object>();
		param.put("questId", request.getParameter("questId"));
		param.put("optionContent", request.getParameter("B"));
		param.put("optionNo", "B");
		managerService.updateQuestionDetail(param);param = new HashMap<String,Object>();
		param.put("questId", request.getParameter("questId"));
		param.put("optionContent", request.getParameter("D"));
		param.put("optionNo", "D");
		managerService.updateQuestionDetail(param);
		
		return g.toJson("ok");
		}catch(Exception e) {
			return g.toJson(e.getMessage());
		}
	}
	
	
	@RequestMapping(params="method=getAccountInfo")
	@ResponseBody
	public Map<String,Object> getAccountInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> returnMap = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		
		if(request.getParameter("optID") != null && !"".equals(request.getParameter("optID"))){
			try {
				param.put("optID", "'%"+URLDecoder.decode(request.getParameter("optID"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(request.getParameter("optName") != null && !"".equals(request.getParameter("optName"))){
			try {
				param.put("optName", "'%"+URLDecoder.decode(request.getParameter("optName"),"utf-8")+"%'");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//分页
		Integer questionCount = managerService.getAccountCount(param);
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
		List<Map<String, Object>> questionInfo = managerService.getAccountInfo(param);
		for(int i = 0;i<questionInfo.size();i++){
			questionInfo.get(i).put("oldOptID", questionInfo.get(i).get("optID"));
			if(((String)questionInfo.get(i).get("isAdmin")).equals("1")){
				questionInfo.get(i).put("isAdmin", "系统管理员");
			}else if(((String)questionInfo.get(i).get("isAdmin")).equals("0")){
				questionInfo.get(i).put("isAdmin", "学生");
			}else{
				questionInfo.get(i).put("isAdmin", "老师");
			}
		}
		returnMap.put("total", questionCount.intValue());
		returnMap.put("rows", questionInfo);
		return returnMap;
	}
	

	@RequestMapping(params="method=delAccount")
	@ResponseBody
	public String delAccount(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("optID", request.getParameter("optID"));
		managerService.delStudentInfo(param);
		managerService.delOperator(param);
		return g.toJson("ok");
	}
	@RequestMapping(params="method=getUpdateAccountInfo")
	@ResponseBody
	public List<Map<String,Object>> getUpdateAccountInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> param = new HashMap<String,Object>();
		try {
			param.put("optID",URLDecoder.decode(request.getParameter("optID"),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String, Object> updateAccountInfo = managerService.getUpdateAccountInfo(param);
		List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
		Map<String,Object> p = new HashMap<String, Object>();
		p.put("name", "账号");
		p.put("eName", "optID");
		p.put("value", updateAccountInfo.get("optID"));
		returnList.add(p);
		p = new HashMap<String, Object>();
		p.put("name", "密码");
		p.put("eName", "password");
		p.put("value", updateAccountInfo.get("password"));
		p.put("editor", "text");
		returnList.add(p);
		p = new HashMap<String, Object>();
		p.put("name", "姓名");
		p.put("eName", "optName");
		p.put("value", updateAccountInfo.get("optName"));
		p.put("editor", "text");
		returnList.add(p);
		p = new HashMap<String, Object>();
		p.put("name", "身份 1:管理员 0:学生 2:老师");
		p.put("eName", "isAdmin");
		p.put("value", updateAccountInfo.get("isAdmin"));
		p.put("editor", "text");
		returnList.add(p);
		if(((String)updateAccountInfo.get("isAdmin")).equals("0")){
			Map<String, Object> studentInfo = managerService.getStudentInfo(param);
			p = new HashMap<String, Object>();
			p.put("name", "电话");
			p.put("eName", "tel");
			p.put("value", studentInfo.get("tel"));
			p.put("editor", "text");
			returnList.add(p);
			p = new HashMap<String, Object>();
			p.put("name", "学号");
			p.put("eName", "num");
			p.put("value", studentInfo.get("num"));
			p.put("editor", "text");
			returnList.add(p);
			p = new HashMap<String, Object>();
			p.put("name", "班级");
			p.put("eName", "cla");
			p.put("value", studentInfo.get("cla"));
			p.put("editor", "text");
			returnList.add(p);
		}
		return returnList;
	}
	@RequestMapping(params="method=updateAccount")
	@ResponseBody
	public String updateAccount(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("optID", request.getParameter("optID"));
		param.put("optName", request.getParameter("optName"));
		param.put("password", request.getParameter("password"));
		param.put("isAdmin", request.getParameter("isAdmin"));
		param.put("oldOptID", request.getParameter("oldOptID"));
		Map<String, Object> findInfoByUserName = loginService.findInfoByUserName(param);
		if(findInfoByUserName != null){
			return g.toJson("no");
		}
		managerService.updateOperatorInfo(param);
		if(((String)request.getParameter("isAdmin")).equals("0")){
			param.put("cla", request.getParameter("cla"));
			param.put("num", request.getParameter("num"));
			param.put("tel", request.getParameter("tel"));
			managerService.updateStudentInfo(param);
		}
		return g.toJson("ok");
	}
	
	@RequestMapping(params="method=addAccount")
	@ResponseBody
	public String addAccount(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("optID", request.getParameter("username"));
		param.put("optName", request.getParameter("realname"));
		param.put("password", request.getParameter("password"));
		param.put("isAdmin", request.getParameter("isAdmin"));
		param.put("username", request.getParameter("username"));
		Map<String, Object> findInfoByUserName = loginService.findInfoByUserName(param);
		if(findInfoByUserName.size() >0){
			return g.toJson("no");
		}
		managerService.addAccount(param);
		param.put("cla", request.getParameter("cla"));
		param.put("tel", request.getParameter("tel"));
		param.put("num", request.getParameter("num"));
		managerService.addStudentInfo(param);
		return g.toJson("ok");
	}
}
