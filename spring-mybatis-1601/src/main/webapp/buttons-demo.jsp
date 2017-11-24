<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
  
    <title>各种按钮样式</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<link rel="stylesheet" href="css/buttons/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/buttons/buttons.css"/>
	<script type="text/javascript" src="js/buttons.js"></script>
  </head>
  
  <body>
  	<center><h1>各种按钮样式</h1></center>
  
    <a href="#" class="button button-rounded button-flat-primary">press me</a>
	<a href="#" class="button button-pill button-flat-primary">press me</a>
	<a href="#" class="button button-flat-primary">press me</a>
	<a href="#" class="button button-circle button-flat-primary">press me</a><br>
	
	<hr size="4">
	
	<a href="#" class="button button-pill">press me</a>
	<a href="#" class="button button-pill button-primary">press me</a>
	<a href="#" class="button button-pill button-action">press me</a>
	<a href="#" class="button button-pill button-highlight">press me</a>
	<a href="#" class="button button-pill button-caution">press me</a>
	<a href="#" class="button button-pill button-royal">press me</a>
	
	<hr size="4">
	
	<input type="submit" value="press me" class="button button-pill button-primary"/>
	<button class="button button-pill button-primary">press me</button>
	<!-- DISABLED BUTTONS -->
	<input  disabled type="submit"  value="press me" class="button button-pill button-primary"/>
	<button disabled class="button  button-pill button-primary">press me</button>
	<a href="#" class="button disabled button-pill button-primary">press me</a>
	
	<hr size="4">
	
	<a href="#" class="button button-rounded button-flat-primary button-large">press me</a>
	<a href="#" class="button button-rounded button-flat-primary">press me</a>
	<a href="#" class="button button-rounded button-flat-primary button-small">press me</a>
	<a href="#" class="button button-rounded button-flat-primary button-tiny">press me</a>
	
	<hr size="4">
	
	<a href="#" class="button button-pill button-tiny">press me</a>
	<a href="#" class="button button-pill button-primary button-tiny">press me</a>
	<a href="#" class="button button-pill button-highlight button-tiny">press me</a>
	<a href="#" class="button button-pill button-action button-tiny">press me</a>
	<a href="#" class="button button-pill button-caution button-tiny">press me</a>
	<a href="#" class="button button-pill button-royal button-tiny">press me</a>
	
  </body>
</html>
