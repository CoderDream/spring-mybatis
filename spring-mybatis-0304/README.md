
 示例0304：@PathVariable、@RequestHeader 和 @CookieValue 的使用
----------


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

代码3：DataBindingController.java

	/**
	 * Controller注解用于指示该类是一个控制器，可以同时处理多个请求动作
	 */
	@Controller
	public class DataBindingController {
	
		// 静态的日志类LogFactory
		private static final Log logger = LogFactory
				.getLog(DataBindingController.class);
	
		// 测试@PathVariable注解
		// 该方法映射的请求为http://localhost:8088/spring-mybatis-0304/{userId}
		@RequestMapping(value = "/pathVariableTest/{userId}")
		public void pathVariableTest(@PathVariable Integer userId) {
			logger.info("通过@PathVariable获得数据： " + userId);
		}
	
		// 测试@RequestHeader注解
		// 该方法映射的请求为http://localhost:8088/spring-mybatis-0304/requestHeaderTest
		@RequestMapping(value = "/requestHeaderTest")
		public void requestHeaderTest(@RequestHeader("User-Agent") String userAgent,
				@RequestHeader(value = "Accept") String[] accepts) {
			logger.info("通过@requestHeaderTest获得数据： " + userAgent);
			for (String accept : accepts) {
				logger.info(accept);
			}
		}
	
		// 测试@CookieValue注解
		@RequestMapping(value = "/cookieValueTest")
		public void cookieValueTest(
				@CookieValue(value = "JSESSIONID", defaultValue = "") String sessionId) {
			logger.info("通过@requestHeaderTest获得数据： " + sessionId);
		}
	
	}

代码4：SessionAttributesController.java

	/**
	 * <pre>
	 * Controller注解用于指示该类是一个控制器，可以同时处理多个请求动作
	 * SessionAttributes将Model中的属性名为user的放入HttpSession对象当中
	 * </pre>
	 */
	@Controller
	@SessionAttributes("user")
	public class SessionAttributesController {
	
		// 静态的日志类LogFactory
		private static final Log logger = LogFactory
				.getLog(SessionAttributesController.class);
	
		// 该方法映射的请求为http://localhost:8088/spring-mybatis-0304/{formName}
		@RequestMapping(value = "/{formName}")
		public String loginForm(@PathVariable String formName) {
			logger.info("formName： " + formName);
			// 动态跳转页面
			return formName;
		}
	
		// 该方法映射的请求为http://localhost:8088/spring-mybatis-0304/login
		@RequestMapping(value = "/login")
		public String login(@RequestParam("loginname") String loginname,
				@RequestParam("password") String password, Model model) {
			logger.info("loginname： " + loginname + ",password： " + password);
			// 创建User对象，装载用户信息
			User user = new User();
			user.setLoginname(loginname);
			user.setPassword(password);
			user.setUsername("admin");
			// 将user对象添加到Model当中
			model.addAttribute("user", user);
			return "welcome";
		}
	
	}


代码5：spring-mybatis-0304\src\main\webapp\index.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>数据绑定测试</title>
	</head>
	<body>
		<h2>数据绑定测试</h2>
		<a href="pathVariableTest/1">测试@PathVariable注解</a>
		<br>
		<br>
		<a href="requestHeaderTest">测试@RequestHeader注解</a>
		<br>
		<br>
		<a href="cookieValueTest">测试@CookieValue注解</a>
		<br>
		<br>
	</body>
	</html>


代码6：spring-mybatis-0304\src\main\webapp\WEB-INF\content\loginForm.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>登录页面</title>
	</head>
	<body>
		<h3>测试@SessionAttributes注解</h3>
		<form action="login" method="post">
			<table>
				<tr>
					<td><label>登录名: </label></td>
					<td><input type="text" id="loginname" name="loginname"></td>
				</tr>
				<tr>
					<td><label>密码: </label></td>
					<td><input type="password" id="password" name="password"></td>
				</tr>
				<tr>
					<td><input id="submit" type="submit" value="登录"></td>
				</tr>
			</table>
		</form>
	</body>
	</html>


代码7：spring-mybatis-0304\src\main\webapp\WEB-INF\content\welcome.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>测试@SessionAttributes注解</title>
	</head>
	<body>
		访问request作用范围域中的user对象：${requestScope.user.username }
		<br> 访问session作用范围域中的user对象：${sessionScope.user.username }
		<br>
		<br>
	</body>
	</html>

访问截图1
----------

[http://localhost:8088/spring-mybatis-0304/index.jsp](http://localhost:8088/spring-mybatis-0304/index.jsp)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0304/snapshot/snap030401.png)

控制台信息
----------

	0 [qtp1677921169-15] [INFO] - org.fkit.controller.DataBindingController 
		-org.fkit.controller.DataBindingController.pathVariableTest(DataBindingController.java:25) 
		-通过@PathVariable获得数据： 1
	2462 [qtp1677921169-12] [INFO] - org.fkit.controller.DataBindingController 
		-org.fkit.controller.DataBindingController.requestHeaderTest(DataBindingController.java:33) 
		-通过@requestHeaderTest获得数据：
	 Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36
	2462 [qtp1677921169-12] [INFO] - org.fkit.controller.DataBindingController 
		-org.fkit.controller.DataBindingController.requestHeaderTest(DataBindingController.java:35) 
		-text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
	4553 [qtp1677921169-19] [INFO] - org.fkit.controller.DataBindingController 
		-org.fkit.controller.DataBindingController.cookieValueTest(DataBindingController.java:43) 
		-通过@requestHeaderTest获得数据： node0158rm9wjzcru7zo3ubdlyk7ff0.node0
  

访问截图2
----------

[http://localhost:8088/spring-mybatis-0304/loginForm](http://localhost:8088/spring-mybatis-0304/loginForm)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0304/snapshot/snap030402.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0304/snapshot/snap030403.png)



控制台信息
----------

	971224 [qtp1677921169-17] [INFO] - org.fkit.controller.SessionAttributesController 
		-org.fkit.controller.SessionAttributesController.loginForm(SessionAttributesController.java:30) 
		-formName： loginForm
	989957 [qtp1677921169-19] [INFO] - org.fkit.controller.SessionAttributesController 
		-org.fkit.controller.SessionAttributesController.login(SessionAttributesController.java:39) 
		-loginname： test,password： 123456
