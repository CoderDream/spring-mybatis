# 第一个Spring MVC应用


版本
----------

maven, spring 4.3.9



核心代码
----------

代码1：web.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns="http://xmlns.jcp.org/xml/ns/javaee"
		xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
		http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
		id="WebApp_ID" version="3.1">
		<!-- 定义Spring MVC的前端控制器 -->
		<servlet>
			<servlet-name>springmvc</servlet-name>
			<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
			<init-param>
				<param-name>contextConfigLocation</param-name>
				<param-value>/WEB-INF/springmvc-config.xml</param-value>
			</init-param>
			<load-on-startup>1</load-on-startup>
		</servlet>
		<!-- 让Spring MVC的前端控制器拦截所有请求 -->
		<servlet-mapping>
			<servlet-name>springmvc</servlet-name>
			<url-pattern>/</url-pattern>
		</servlet-mapping>
	</web-app>

代码2：springmvc-config.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://www.springframework.org/schema/beans
	        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd">
	
		<!-- 配置Handle，映射"/hello"请求 -->
		<bean name="/hello" class="org.fkit.controller.HelloController" />
	
		<!-- 处理映射器将bean的name作为url进行查找，需要在配置Handle时指定name（即url） -->
		<bean class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping" />
	
		<!-- SimpleControllerHandlerAdapter是一个处理器适配器，所有处理适配器都要实现 HandlerAdapter接口 -->
		<bean class="org.springframework.web.servlet.mvc.SimpleControllerHandlerAdapter" />
	
		<!-- 视图解析器 -->
		<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" />
	
	</beans>

代码3：HelloController.java

	package org.fkit.controller;
	
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	
	import org.apache.commons.logging.Log;
	import org.apache.commons.logging.LogFactory;
	import org.springframework.web.servlet.ModelAndView;
	import org.springframework.web.servlet.mvc.Controller;
	
	/**   
	 * @Description: 
	 * <br>网站：<a href="http://www.fkit.org">疯狂Java</a> 
	 * @author 肖文吉	36750064@qq.com   
	 * @version V1.0   
	 */
	
	/**
	 * HelloController是一个实现Controller接口的控制器, 可以处理一个单一的请求动作
	 */
	public class HelloController implements Controller {
		private static final Log logger = LogFactory.getLog(HelloController.class);
	
		/**
		 * handleRequest是Controller接口必须实现的方法。
		 * 该方法的参数是对应请求的HttpServletRequest和HttpServletResponse。
		 * 该方法必须返回一个包含视图路径或视图路径和模型的ModelAndView对象。
		 */
		@Override
		public ModelAndView handleRequest(HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			logger.info("handleRequest 被调用");
			// 创建准备返回的ModelAndView对象，该对象通常包含了返回视图的路径、模型的名称以及模型对象
			ModelAndView mv = new ModelAndView();
			// 添加模型数据 可以是任意的POJO对象
			mv.addObject("message", "Hello World!");
			// 设置逻辑视图名，视图解析器会根据该名字解析到具体的视图页面
			mv.setViewName("/WEB-INF/content/welcome.jsp");
			// 返回ModelAndView对象。
			return mv;
		}
	
	}

代码4：spring-mybatis-0201\src\main\webapp\WEB-INF\content\welcome.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>欢迎页面</title>
	</head>
	<body>
		<!-- 页面可以访问Controller传递传递出来的message -->
		${requestScope.message}
	</body>
	</html>


访问
----------

[http://localhost:8088/spring-mybatis-0201/hello](http://localhost:8088/spring-mybatis-0201/hello)


![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0201/snapshot/hello.png)


控制台信息
----------


	
	0 [qtp1445758842-15] [INFO] - org.fkit.controller.HelloController 
	-org.fkit.controller.HelloController.handleRequest(HelloController.java:31) -handleRequest 被调用



