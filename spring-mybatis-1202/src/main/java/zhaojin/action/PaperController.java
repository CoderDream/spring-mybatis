package zhaojin.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import zhaojin.service.ManagerService;
import zhaojin.service.PaperService;

@Controller
@RequestMapping("/paper")
public class PaperController {
	@Autowired
	private PaperService paperService;
	@Autowired
	private ManagerService managerService;
	
	@RequestMapping(params = "method=getPaperInfo")
	@ResponseBody
	public Map<String,Object> getPaperInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> returnMap = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		
		
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
		}if(request.getParameter("studentPage") != null && !"".equals(request.getParameter("studentPage"))){
		if(request.getParameter("goTest") != null && !"".equals(request.getParameter("goTest"))){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date d = new Date();
			param.put("now2", sdf.format(d));
			param.put("optID", request.getSession().getAttribute("optID"));
		}else{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				Date d = new Date();
				param.put("now", sdf.format(d));
				param.put("optID", request.getSession().getAttribute("optID"));
			}}
		//分页
		Integer questionCount = paperService.getPaperCount(param);
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
		List<Map<String, Object>> questionInfo = paperService.getPaperInfo(param);
		returnMap.put("total", questionCount.intValue());
		returnMap.put("rows", questionInfo);
		return returnMap;
	}
	@RequestMapping(params="method=delPaper")
	@ResponseBody
	public String delPaper(HttpServletRequest request,HttpServletResponse response){
		Gson g = new Gson();
		try {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("paperId", request.getParameter("paperId"));
		
		List<Map<String, Object>> allpaperDetailIdByPaperId = paperService.getAllpaperDetailIdByPaperId(param);
		if(allpaperDetailIdByPaperId != null){
			for(Map<String, Object> k : allpaperDetailIdByPaperId){
				param.put("paperDetailID", k.get("paperDetailID"));
				paperService.delStudScoreDetailByPaperId(param);
			}
		}
		
		paperService.delPaperDetail(param);
		paperService.delPaper(param);
		return g.toJson("ok");
		}catch(Exception e) {
			return g.toJson(e.getMessage());
		}
	}
	@RequestMapping(params="method=enterPaperMaintainPage")
	public ModelAndView enterPaperMaintainPage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		request.setAttribute("paperId", request.getParameter("paperId"));
		view.setViewName("managerPages/paper/paperMaintain");
		return view;
	}
	@RequestMapping(params="method=enterAddPaperPage")
	public ModelAndView enterAddPaperPage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/paper/addPaper");
		return view;
	}
	
	@RequestMapping(params="method=getUpdatePaperInfo")
	@ResponseBody
	public List<Map<String,Object>> getUpdatePaperInfo(HttpServletRequest request,HttpServletResponse response){
		List<Map<String,Object>> returnList = new ArrayList<Map<String,Object>>();
		Map<String,Object> p = new HashMap<String,Object>();
		p.put("paperId", request.getParameter("paperId"));
		List<Map<String, Object>> questionInfo = paperService.getPaperInfo(p);
		p = new HashMap<String,Object>();
		p.put("name", "试卷名");
		p.put("value", questionInfo.get(0).get("paperName")==null?"-":questionInfo.get(0).get("paperName"));
		p.put("group",  "1");
		p.put("editor", "text");
		p.put("eName", "paperName");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "满分");
		p.put("value", questionInfo.get(0).get("fullScore"));
		p.put("group",  "1");
		p.put("editor", "text");
		p.put("eName", "fullScore");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "出卷时间");
		p.put("value", questionInfo.get(0).get("paperTime"));
		p.put("group",  "1");
		p.put("eName", "paperTime");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "做卷时间(小时)");
		p.put("value", questionInfo.get(0).get("validateTime"));
		p.put("group",  "1");
		p.put("editor", "text");
		p.put("eName", "validateTime");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "有效期");
		p.put("value", questionInfo.get(0).get("available"));
		p.put("group",  "1");
		p.put("eName", "available");
		returnList.add(p);
		p = new HashMap<String,Object>();
		p.put("name", "出卷人");
		p.put("value", questionInfo.get(0).get("byUser"));
		p.put("group",  "1");
		p.put("eName", "byUser");
		returnList.add(p);
		return returnList;
	}
	
	@RequestMapping(params = "method=getUpdatePaperDetailInfo")
	@ResponseBody
	public List<Map<String, Object>> getUpdatePaperDetailInfo(
			HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		Map<String, Object> p = new HashMap<String, Object>();
		if (request.getParameter("paperId") != null
				&& !"".equals(request.getParameter("paperId"))) {
			p.put("paperId", request.getParameter("paperId"));
			List<Map<String, Object>> paperDetailInfo = paperService
					.getPaperDetailInfo(p);
			for (Map<String, Object> k : paperDetailInfo) {
				p.put("questId", k.get("questID"));
				List<Map<String, Object>> questionInfo = managerService
						.getQuestionInfo(p);
				if (questionInfo != null) {
					returnList.add(questionInfo.get(0));
				}
			}
			return returnList;
		} else {
			return managerService.getQuestionInfo(p);
		}
	}
	@RequestMapping(params = "method=addPaperQuest")
	@ResponseBody
	public String addPaperQuest(HttpServletRequest request, HttpServletResponse response) {
			Gson g = new Gson();
			Map<String,Object> p = new HashMap<String,Object>();
			p.put("questId", request.getParameter("questId"));
			p.put("paperId", request.getParameter("paperId"));
			paperService.addPaperQuest(p);
			return g.toJson("ok");
	}
	@RequestMapping(params = "method=delPaperQuest")
	@ResponseBody
	public String delPaperQuest(HttpServletRequest request, HttpServletResponse response) {
			Gson g = new Gson();
			Map<String,Object> p = new HashMap<String,Object>();
			
			
			
			p.put("questId", request.getParameter("questId"));
			p.put("paperId", request.getParameter("paperId"));
			
			List<Map<String, Object>> allpaperDetailIdByPaperId = paperService.getAllpaperDetailIdByPaperId(p);
			if(allpaperDetailIdByPaperId.size() >= 1){
				for(Map<String, Object> k : allpaperDetailIdByPaperId){
					p.put("paperDetailID", k.get("paperDetailID"));
					paperService.delStudScoreDetailByPaperId(p);
				}
			}
			paperService.delPaperQuest(p);
			return g.toJson("ok");
	}
	@RequestMapping(params = "method=updatePaperInfo")
	@ResponseBody
	public String updatePaperInfo(HttpServletRequest request, HttpServletResponse response) {
			Gson g = new Gson();
			Map<String,Object> p = new HashMap<String,Object>();
			p.put("paperId", request.getParameter("paperId"));
			p.put("paperName", request.getParameter("paperName"));
			p.put("fullScore", request.getParameter("fullScore"));
			p.put("validateTime", request.getParameter("validateTime"));
			
			paperService.updatePaperInfo(p);
			return g.toJson("ok");
	}
	@RequestMapping(params = "method=addPaper")
	@ResponseBody
	public String addPaper(HttpServletRequest request, HttpServletResponse response) {
			Gson g = new Gson();
			Map<String,Object> p = new HashMap<String,Object>();
			p.put("paperName", ((String)request.getParameter("paperName")).equals("-")?null:request.getParameter("paperName"));
			p.put("fullScore", ((String)request.getParameter("fullScore")).equals("-")?null:request.getParameter("fullScore"));
			p.put("validateTime", ((String)request.getParameter("validateTime")).equals("-")?null:request.getParameter("validateTime"));
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			p.put("paperTime",df.format(new Date()));
			Calendar c = Calendar.getInstance();
			c.add(Calendar.MONTH, 2);
			p.put("available",df.format(c.getTime()));
			p.put("byUser", ((String)request.getParameter("byUser")).equals("-")?null:request.getParameter("byUser"));
			paperService.addPaper(p);
			int count = Integer.parseInt(((String)request.getParameter("questIdCount")));
			p = new HashMap<String,Object>();
			for(int i = 1;i<=count;i++){
				int id = Integer.parseInt(((String)request.getParameter("questId"+i)));
				p.put("questId", id);
				paperService.addPaperDetail(p);
			}
			return g.toJson("ok");
	}
}
