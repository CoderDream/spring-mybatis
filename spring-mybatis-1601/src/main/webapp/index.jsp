<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="${basePath}">
    <title>"蓝桥怀"软件学院在线考试系统</title>
    <link rel="icon"  href="images/favicon.ico" type="image/x-icon" />
    <link rel="bookmark" href="images/favicon.ico" type="image/x-icon"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
 
 <link rel="stylesheet" type="text/css" href="css/style.css">
 <link rel="stylesheet" type="text/css" href="css/screen.css">
 
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="script/index.js"></script>
 
 <script type="text/javascript">
$(function(){
	
	detect();
});

 </script>
<style type="text/css">
.invalid{
	margin-left:-100px;
	color:red;
	font-size:12px;
	font-weight:normal;
}
.invalid-code{
	margin-left: 2px;
	font-style: italic;
}
</style>
  </head>
  
  <body background="images/login_bg.png">
  <div>
  	<div id="login_h"></div>
  	<div id="login_m" >
  	  <div style="width:600px;border: 0px solid red; margin-left:500px;">
  		<form id="loginForm" action="user/login.do" method="post">
  			<br/>
  			<ul >
  				<li>用户名：<input type="text" name="userName" /></li>
  				<li>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="password" name="passWord"/></li>
  				 <li>验证码：<input type="text" name="validCode" size="8" maxlength="4" />
  					<img id="validcode" src="code.do" width="91" height="35" style="margin-bottom:0px;" />
  					<a href="index.jsp">换一张</a>
  				</li>
  				
  			</ul>
  			<span style="padding-left:90px;">
  				<input type="submit" value="用户登录" class="button_r_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
  				<input type="reset" value="重置" class="button_g_b"/>
  			</span>
  			<br/>
  			<br/>
  		</form>
  	  </div>
  	</div>
  	<div id="login_f"></div>
  </div>
  </body>
</html>
