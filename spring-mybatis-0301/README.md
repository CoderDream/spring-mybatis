# 示例0301：@Controller注解的使用


框架版本
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
	
	    <!-- spring可以自动去扫描base-pack下面的包或者子包下面的java文件，
	    	如果扫描到有Spring的相关注解的类，则把这些类注册为Spring的bean -->
	    <context:component-scan base-package="org.fkit.controller"/>
	    
	    <!-- 视图解析器  -->
	     <bean id="viewResolver"
	          class="org.springframework.web.servlet.view.InternalResourceViewResolver"> 
	        <!-- 前缀 -->
	        <property name="prefix">
	            <value>/WEB-INF/content/</value>
	        </property>
	        <!-- 后缀 -->
	        <property name="suffix">
	            <value>.jsp</value>
	        </property>
	    </bean>
	
	</beans>

代码3：HelloController.java

	package org.fkit.controller;
	
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.RequestMapping;
	
	/**
	 *  HelloWorldController是一个基于注解的控制器,
	 *  可以同时处理多个请求动作，并且无须实现任何接口。
	 *  org.springframework.stereotype.Controller注解用于指示该类是一个控制器
	 */
	@Controller
	public class HelloWorldController{
		 
		 @RequestMapping("/helloWorld")
		 public String helloWorld(Model model) {
		     model.addAttribute("message", "Hello World!");
		     return "helloWorld";
		 }
	
	}


代码4：spring-mybatis-0301\src\main\webapp\WEB-INF\content\helloWorld.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>测试@Controller注解</title>
	</head>
	<body>
		<!-- 页面可以访问Controller传递传递出来的message -->
		${requestScope.message}
	</body>
	</html>


访问
----------

[http://localhost:8088/spring-mybatis-0301/helloWorld](http://localhost:8088/spring-mybatis-0301/helloWorld)


![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0301/snapshot/030101.png)






