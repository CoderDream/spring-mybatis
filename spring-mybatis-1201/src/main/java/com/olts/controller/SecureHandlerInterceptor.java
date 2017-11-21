package com.olts.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.olts.vo.OltsUsers;
//用HandlerInterceptor接口要实现三个方法，继承HandlerInterceptorAdapter只实现一个方法
public class SecureHandlerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		OltsUsers user = (OltsUsers) request.getSession().getAttribute("user");
		
		if (user==null) { //未登录
			
			System.out.println("======>>>>未登录\n");
			
			response.sendRedirect(request.getContextPath()+"/index.jsp");
			return false;
		}
		
		return true;
	}

	
}
