# 示例0202：基于注解的控制器


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
		xmlns:mvc="http://www.springframework.org/schema/mvc"
		xmlns:context="http://www.springframework.org/schema/context"
		xsi:schemaLocation="
	        http://www.springframework.org/schema/beans
	        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
	        http://www.springframework.org/schema/mvc
	        http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd     
	        http://www.springframework.org/schema/context
	        http://www.springframework.org/schema/context/spring-context-4.2.xsd">
	
		<!-- spring可以自动去扫描base-pack下面的包或者子包下面的java文件， 如果扫描到有Spring的相关注解的类，
			则把这些类注册为Spring的bean -->
		<context:component-scan base-package="org.fkit.controller" />
	
		<!-- 配置处理映射器 -->
		<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping" />
	
		<!-- 配置处理器适配器 -->
		<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter" />
	
		<!-- 视图解析器 -->
		<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" />
	
	</beans>

代码3：HelloController.java

	package org.fkit.controller;
	
	import org.apache.commons.logging.Log;
	import org.apache.commons.logging.LogFactory;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.servlet.ModelAndView;
	
	/**
	 * HelloController是一个基于注解的控制器, 可以同时处理多个请求动作，并且无须实现任何接口。
	 * org.springframework.stereotype.Controller注解用于指示该类是一个控制器
	 */
	@Controller
	public class HelloController {
	
		private static final Log logger = LogFactory.getLog(HelloController.class);
	
		/**
		 * org.springframework.web.bind.annotation.RequestMapping注解
		 * 用来映射请求的的URL和请求的方法等。本例用来映射"/hello" hello只是一个普通方法。
		 * 该方法返回一个包含视图路径或视图路径和模型的ModelAndView对象。
		 */
		@RequestMapping(value = "/hello")
		public ModelAndView hello() {
			logger.info("hello方法 被调用");
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

[http://localhost:8088/spring-mybatis-0201/hello](http://localhost:8088/spring-mybatis-0202/hello)


![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0202/snapshot/020201.png)


控制台信息
----------


	
	1 [qtp10001825-19] [INFO] - org.fkit.controller.HelloController 
	-org.fkit.controller.HelloController.hello(HelloController.java:25) -hello方法 被调用



