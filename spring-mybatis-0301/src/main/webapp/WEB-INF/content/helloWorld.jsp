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