package zhaojin.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import zhaojin.service.LoginService;
import zhaojin.service.StudentService;

@Controller
@RequestMapping("/login")
public class LoginController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private StudentService studentService;

	@RequestMapping(params = "method=enterLoginPage")
	public ModelAndView enterLoginPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("index");
		org.aspectj.lang.annotation.Around a = null;
		org.springframework.http.converter.json.MappingJackson2HttpMessageConverter b = null;
		return view;
	}

	@RequestMapping(params = "method=enterStudentPage")
	public ModelAndView enterStudentPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("studentPages/student");
		return view;
	}

	@RequestMapping(params = "method=enterManagerPage")
	public ModelAndView enterManagerPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("managerPages/manager");
		return view;
	}

	@RequestMapping(params = "method=login")
	@ResponseBody
	public String login(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		Gson g = new Gson();
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("username", request.getParameter("username"));
		p.put("password", request.getParameter("password"));
		Map<String, Object> findInfoByUserName = loginService
				.findInfoByUserName(p);

		if (findInfoByUserName == null) {
			return g.toJson("0");
		}
		if (((String) findInfoByUserName.get("isAdmin")).equals("1")) {
			session.setAttribute("username", request.getParameter("username"));
			session.setAttribute("optID", request.getParameter("username"));
			return "1";
		} else {
			session.setAttribute("username", request.getParameter("username"));
			session.setAttribute("optID", request.getParameter("username"));
			return "2";
		}
	}

	@RequestMapping(params = "method=enterRegistPage")
	public ModelAndView enterRegistPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("regiest");
		return view;
	}

	@RequestMapping(params = "method=regist")
	@ResponseBody
	public String regist(HttpServletRequest request,
			HttpServletResponse response) {
		Gson g = new Gson();
		try {
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("username", request.getParameter("username"));
			p.put("realname", request.getParameter("realname"));
			p.put("cla", request.getParameter("cla"));
			p.put("tel", request.getParameter("tel"));
			p.put("num", request.getParameter("num"));
			Map<String, Object> findInfoByUserName = loginService
					.findInfoByUserName(p);
			if (findInfoByUserName != null)
				return g.toJson("no");
			else {
				p.put("password", request.getParameter("password"));
				loginService.regis(p);
				studentService.addStu(p);
				return g.toJson("ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return g.toJson("error");
		}
	}
}
