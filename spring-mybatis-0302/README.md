
 示例0302：Model、ModelMap和ModelAndView的使用
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

代码3：FormController.java

	@Controller
	public class FormController {
	
		@RequestMapping(value = "/{formName}")
		public String loginForm(@PathVariable String formName) {
			// 动态跳转页面
			return formName;
		}
	
	}

代码4：User1Controller.java

	@Controller
	public class User1Controller {
	
		private static final Log logger = LogFactory.getLog(User1Controller.class);
	
		/**
		 *  @ModelAttribute 修饰的方法会先于login调用，该方法用于接收前台jsp页面传入的参数
		 */
		@ModelAttribute
		public void userModel(String loginname, String password, Model model) {
			logger.info("userModel");
			// 创建User对象存储jsp页面传入的参数
			User user = new User();
			user.setLoginname(loginname);
			user.setPassword(password);
			// 将User对象添加到Model当中
			model.addAttribute("user", user);
		}
	
		@RequestMapping(value = "/login1")
		public String login(Model model) {
			logger.info("login");
			// 从Model当中取出之前存入的名为user的对象
			User user = (User) model.asMap().get("user");
			System.out.println(user);
			// 设置user对象的username属性
			user.setUsername("测试");
			return "result1";
		}
	
	}


代码5：User2Controller.java

	
	@Controller
	public class User2Controller {
		private static final Log logger = LogFactory.getLog(User2Controller.class);
	
		@ModelAttribute
		public void userMode2(String loginname, String password,
				ModelMap modelMap) {
			logger.info("userMode2");
			// 创建User对象存储jsp页面传入的参数
			User user = new User();
			user.setLoginname(loginname);
			user.setPassword(password);
			// 将User对象添加到ModelMap当中
			modelMap.addAttribute("user", user);
		}
	
		@RequestMapping(value = "/login2")
		public String login2(ModelMap modelMap) {
			logger.info("login2");
			// 从ModelMap当中取出之前存入的名为user的对象
			User user = (User) modelMap.get("user");
			System.out.println(user);
			// 设置user对象的username属性
			user.setUsername("测试");
			return "result2";
		}
	
	}

代码6：User3Controller.java

	@Controller
	public class User3Controller {
		private static final Log logger = LogFactory.getLog(User3Controller.class);
	
		@ModelAttribute
		public void userMode3(String loginname, String password,
				ModelAndView modelAndView) {
			logger.info("userMode3");
			User user = new User();
			user.setLoginname(loginname);
			user.setPassword(password);
			// 将User对象添加到ModelAndView的Model当中
			modelAndView.addObject("user", user);
		}
	
		@RequestMapping(value = "/login3")
		public ModelAndView login3(ModelAndView mv) {
			logger.info("login3");
			// 从ModelAndView的Model当中取出之前存入的名为user的对象
			User user = (User) mv.getModel().get("user");
			System.out.println(user);
			// 设置user对象的username属性
			user.setUsername("测试");
			// 设置返回的视图名称
			mv.setViewName("result3");
			return mv;
		}
	
	}

代码8：spring-mybatis-0302\src\main\webapp\index.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>测试@ModelAttribute</title>
	</head>
	<body>
		<h3>测试@ModelAttribute的不同用法</h3>
		<a href="loginForm1">测试Model</a>
		<br>
		<br>
		<a href="loginForm2">测试ModelMap</a>
		<br>
		<br>
		<a href="loginForm3">测试ModelAndView</a>
		<br>
		<br>
	</body>
	</html>


代码9：spring-mybatis-0302\src\main\webapp\WEB-INF\content\loginForm1.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>测试Model</title>
	</head>
	<body>
		<h3>测试Model</h3>
		<form action="login1" method="post">
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

代码10：spring-mybatis-0302\src\main\webapp\WEB-INF\content\result1.jsp

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>测试@ModelAttribute(value="")注释返回具体类的方法</title>
	</head>
	<body>
		访问request作用范围域中的model对象：${requestScope.user.loginname }
		<br> 访问request作用范围域中的model对象：${requestScope.user.password }
		<br> 访问request作用范围域中的model对象：${requestScope.user.username }
	</body>
	</html>

访问截图
----------

[http://localhost:8088/spring-mybatis-0302/index.jsp](http://localhost:8088/spring-mybatis-0302/index.jsp)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030201.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030202.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030203.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030204.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030205.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030206.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0302/snapshot/snap030207.png)






