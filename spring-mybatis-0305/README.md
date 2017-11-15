
 示例0305：@ModelAttribute 注解的使用
----------


框架版本
----------
maven, spring 4.3.9

核心代码
----------
代码1：web.xml

```xml
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
	<!-- 编码过滤器 -->
	<filter>
		<filter-name>characterEncodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>characterEncodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<!-- 欢迎页面 -->
	<welcome-file-list>
		<welcome-file>index.jsp</welcome-file>
	</welcome-file-list>
</web-app>
```

代码2：springmvc-config.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd     
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.2.xsd">

	<!-- 可以访问web.xml配置的默认页(welcome-file) -->
	<mvc:default-servlet-handler />

	<!-- spring可以自动去扫描base-pack下面的包或者子包下面的java文件， 如果扫描到有Spring的相关注解的类，则把这些类注册为Spring的bean -->
	<context:component-scan base-package="org.fkit.controller" />

	<!-- 视图解析器 -->
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
```

代码3：FormController.java

```java
@Controller
public class FormController {

	// 该方法映射的请求为http://localhost:8088/spring-mybatis-0305/{formName}
	@RequestMapping(value = "/{formName}")
	public String loginForm(@PathVariable String formName) {
		// 动态跳转页面
		return formName;
	}

}
```

代码4：ModelAttribute1Controller.java

 ```java
@Controller
public class ModelAttribute1Controller {

	// 使用@ModelAttribute注释的value属性，来指定model属性的名称,model属性对象就是方法的返回值
	@ModelAttribute("loginname")
	public String userModel1(@RequestParam("loginname") String loginname) {
		return loginname;
	}

	@RequestMapping(value = "/login1")
	public String login1() {
		return "result1";
	}
	
}
```

代码5：ModelAttribute2Controller.java
```Java
@Controller
public class ModelAttribute2Controller {

	// model属性名称和model属性对象由model.addAttribute()实现，前提是要在方法中加入一个Model类型的参数。
	// 注意：当URL或者post中不包含对应的参数时，程序会抛出异常。
	@ModelAttribute
	public void userModel2(@RequestParam("loginname") String loginname,
			@RequestParam("password") String password, Model model) {
		model.addAttribute("loginname", loginname);
		model.addAttribute("password", password);
	}

	@RequestMapping(value = "/login2")
	public String login2() {
		return "result2";
	}

}
```

代码6：ModelAttribute3Controller.java

```java
@Controller
public class ModelAttribute3Controller {

	// 静态List<User>集合，此处代替数据库用来保存注册的用户信息
	private static List<User> userList;

	// UserController类的构造器，初始化List<User>集合
	public ModelAttribute3Controller() {
		super();
		userList = new ArrayList<User>();
		User user1 = new User("test", "123456", "测试用户");
		User user2 = new User("admin", "123456", "管理员");
		// 存储User用户，用于模拟数据库数据
		userList.add(user1);
		userList.add(user2);
	}

	// 根据登录名和密码查询用户，用户存在返回包含用户信息的User对象，不存在返回null
	public User find(String loginname, String password) {
		for (User user : userList) {
			if (user.getLoginname().equals(loginname)
					&& user.getPassword().equals(password)) {
				return user;
			}
		}
		return null;
	}

	// model属性的名称没有指定，它由返回类型隐含表示，如这个方法返回User类型，那么这个model属性的名称是user。
	// 这个例子中model属性名称由返回对象类型隐含表示，model属性对象就是方法的返回值。它不需要指定特定的参数。
	@ModelAttribute
	public User userModel3(@RequestParam("loginname") String loginname,
			@RequestParam("password") String password) {
		return find(loginname, password);
	}

	@RequestMapping(value = "/login3")
	public String login3() {
		return "result3";
	}

}
```

代码7：ModelAttribute4Controller.java

```java
@Controller
public class ModelAttribute4Controller {

	// 这时这个方法的返回值并不是表示一个视图名称，而是model属性的值，视图名称是@RequestMapping的value值。
	// Model属性名称由@ModelAttribute(value=””)指定，相当于在request中封装了username（key）=admin（value）。
	@RequestMapping(value = "/login4")
	@ModelAttribute(value = "username")
	public String login4() {
		return "admin";
	}

}
```

代码8：ModelAttribute5Controller.java

```java
@Controller
public class ModelAttribute5Controller {

	// model属性名称就是value值即“user”，model属性对象就是方法的返回值
	@ModelAttribute("user")
	public User userModel5(@RequestParam("loginname") String loginname,
			@RequestParam("password") String password) {
		User user = new User();
		user.setLoginname(loginname);
		user.setPassword(password);
		return user;
	}

	// @ModelAttribute("user") User user注释方法参数，参数user的值来源于userModel5()方法中的model属性。
	@RequestMapping(value = "/login5")
	public String login5(@ModelAttribute("user") User user) {
		user.setUsername("管理员");
		return "result5";
	}
}
```

代码9：spring-mybatis-0305\src\main\webapp\index.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute的不同用法</h3>
	<a href="loginForm1">测试@ModelAttribute(value="")注释返回具体类的方法 </a>
	<br>
	<br>
	<a href="loginForm2">测试@ModelAttribute注释void返回值的方法</a>
	<br>
	<br>
	<a href="loginForm3">测试@ModelAttribute注释返回具体类的方法</a>
	<br>
	<br>
	<a href="loginForm4">测试@ModelAttribute和@RequestMapping同时注释一个方法 </a>
	<br>
	<br>
	<a href="loginForm5">测试@ModelAttribute注释一个方法的参数 </a>
	<br>
	<br>
</body>
	</html>
```

代码10：spring-mybatis-0305\src\main\webapp\WEB-INF\content\login4.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute和@RequestMapping同时注释一个方法</title>
</head>
<body>
	访问request作用范围域中的username对象：${requestScope.username }
	<br>
	<br>
</body>
</html>
```

代码11：spring-mybatis-0305\src\main\webapp\WEB-INF\content\loginForm1.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute(value="")注释返回具体类的方法</h3>
	<form action="login1" method="post">
		<table>
			<tr>
				<td><label>登录名: </label></td>
				<td><input type="text" id="loginname" name="loginname"></td>
			</tr>
			<tr>
				<td><input id="submit" type="submit" value="登录"></td>
			</tr>
		</table>
	</form>
</body>
</html>
jsp

代码12：spring-mybatis-0305\src\main\webapp\WEB-INF\content\result1.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute(value="")注释返回具体类的方法</title>
</head>
<body>
	访问request作用范围域中的loginname对象：${requestScope.loginname }
	<br>
	<br>
</body>
</html>
```

代码13：spring-mybatis-0305\src\main\webapp\WEB-INF\content\loginForm2.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute注释void返回值的方法</h3>
	<form action="login2" method="post">
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
```


代码14：spring-mybatis-0305\src\main\webapp\WEB-INF\content\result2.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute注释void返回值的方法</title>
</head>
<body>
	访问request作用范围域中的loginname对象：${requestScope.loginname }
	<br> 访问request作用范围域中的password对象：${requestScope.password }
	<br>
	<br>
</body>
</html>
```

代码15：spring-mybatis-0305\src\main\webapp\WEB-INF\content\loginForm3.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute注释返回具体类的方法</h3>
	<form action="login3" method="post">
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
```

代码16：spring-mybatis-0305\src\main\webapp\WEB-INF\content\result3.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute注释返回具体类的方法</title>
</head>
<body>
	访问request作用范围域中的user对象：${requestScope.user.username }
	<br>
	<br>
</body>
</html>
```

代码17：spring-mybatis-0305\src\main\webapp\WEB-INF\content\loginForm4.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute和@RequestMapping同时注释一个方法</h3>
	<form action="login4" method="post">
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
```

代码18：spring-mybatis-0305\src\main\webapp\WEB-INF\content\loginForm5.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute</title>
</head>
<body>
	<h3>测试@ModelAttribute注释一个方法的参数</h3>
	<form action="login5" method="post">
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
```

代码19：spring-mybatis-0305\src\main\webapp\WEB-INF\content\result5.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute注释一个方法的参数</title>
</head>
<body>
	访问request作用范围域中的user对象：${requestScope.user.username }
	<br>
	<br>
</body>
</html>
```

访问截图1
----------

[http://localhost:8088/spring-mybatis-0305/](http://localhost:8088/spring-mybatis-0305)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030501.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030502.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030503.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030504.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030505.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030506.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030507.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030508.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030509.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030510.png)

![](https://github.com/CoderDream/spring-mybatis/blob/master/spring-mybatis-0305/snapshot/snap030511.png)


  

