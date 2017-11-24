<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>出卷完成 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<script type="text/javascript">
 

</script>
<style type="text/css">
p{
	font-size: 17px;
	font-weight: bold;
	font-style: italic;
	margin-left:-17px;
}
</style>
</head>
<body class="main_body">

 <table border="0" width="100%">
  <tr>
  	<td width="5px"></td>
  	<td style="border: 1px solid gray;">
  		<br /><br />
  		<h1 align="center">试卷已完成现在可以考试了！&nbsp;&nbsp;<font color="red">(试卷编号：${exam.examNo })</font></h1>
	  	<br /><br />
  		<a href="exam/selectExam.do?flag=2&examNo=${exam.examNo}" 
  			style="font-size:15px;font-weight: bold;color:red;margin-left:200px;">开始考试</a>
	  	<br /><br />
  	</td>
  	<td width="10px" ></td>
  </tr>
 </table>

</body>
</html>
