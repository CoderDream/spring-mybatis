<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试@ModelAttribute注释void返回值的方法</title>
</head>
<body>
	访问request作用范围域中的Model对象：${requestScope.user.loginname }
	<br> 访问request作用范围域中的Model对象：${requestScope.user.password }
	<br> 访问request作用范围域中的Model对象：${requestScope.user.username }
</body>
</html>