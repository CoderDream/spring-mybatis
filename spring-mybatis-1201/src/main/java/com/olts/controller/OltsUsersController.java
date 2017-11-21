package com.olts.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
//import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.olts.service.IOltsUsersService;
import com.olts.vo.OltsUsers;



@Controller
@RequestMapping("/user")
@SessionAttributes({"user"})
public class OltsUsersController {
	
	@Resource
	private IOltsUsersService oltsUsersService;
	
	
	
	/**
	 * 登陆
	 * @param oltsUsers
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/login.do")
	public String login(OltsUsers oltsUsers, ModelMap modelMap,
				HttpSession session,String  validCode){
		//获取生成的验证码
		String code=(String) session.getAttribute("code");
		
		OltsUsers user = oltsUsersService.selectForLogin(oltsUsers);
		if(user!=null&&validCode.equalsIgnoreCase(code)){
			modelMap.addAttribute("user", user);
			return "pages/main"; 
		}
		return "index";
	}
	
	/**
	 * 查看用户列表
	 * @return
	 */
	@RequestMapping("/findAll.do")
	public String findAll(OltsUsers user,HttpServletRequest request){
		if(user.getUserName()==null||user.getUserName()==""){
			user.setUserName(null);
		}
		if(user.getMarjor()==null||user.getMarjor()==""){
			user.setMarjor(null);
		}
		List<OltsUsers> userList= oltsUsersService.findAll(user);
		if(userList!=null){
			request.setAttribute("userList", userList);
			String num= (String) request.getAttribute("num");
			request.setAttribute("num", num);
			
			return "pages/user/user_list";
		}
		return "pages/main";
	}

	/**
	 * 按身份证查看用户信息，更新时用
	 * @return
	 */
	@RequestMapping("/findByIdCard.do")
	public String findByIdCard(String idCardNo,HttpServletRequest request){
		OltsUsers u= oltsUsersService.findByIdCard(idCardNo);
		request.setAttribute("updateUser", u);
		return "pages/user/user_update_input";
	}
	
	/**
	 * 更新用户信息，更新时用
	 * @return
	 */
	@RequestMapping("/updateUser.do")
	public String updateUser(OltsUsers user,String mybirthday,ModelMap modelMap){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isNotEmpty(mybirthday)){
			try {
				Date birthday= sdf.parse(mybirthday);
				user.setBirthday(birthday);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("\n================"+user);
		oltsUsersService.updateUser(user);
		return "redirect:/user/findAll.do";
	}
	 
	/**
	 * 按身份证号删除用户
	 * @return
	 */
	@RequestMapping("/deleteUserByIdCard.do")
	public String deleteUserByIdCard(String idCardNo){
		oltsUsersService.deleteUserByIdCard(idCardNo);
		return "redirect:/user/findAll.do";
	}
	
	/**
	 * 按身份证号删除用户2
	 * @return
	 */
	@RequestMapping("/deleteUserByIdCard2.do")
	public String deleteUserByIdCard2(String[] idCardNos,ModelMap modelMap){
		
		System.out.println("=========="+idCardNos.length);
		for (String s : idCardNos) {
			oltsUsersService.deleteUserByIdCard(s);
		}
		return "redirect:/user/findAll.do";
	}
	
	/**
	 * 退出系统
	 * @return
	 */
	@RequestMapping("/logout.do")
	public String logout(HttpSession session){
		session.removeAttribute("user");
		return "redirect:/index.jsp";
	}
	
	
}
