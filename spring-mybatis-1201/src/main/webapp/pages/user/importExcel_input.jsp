<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>导入Excel学生信息</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="${basePath}js/WdatePicker.js"></script>  
<script type="text/javascript">


</script>

</head>
<body class="main_body">
<div class="button_bar">
	&nbsp;&nbsp;&nbsp;
</div>
<div>
<form id="importForm" action="file/upload.do" method="post" enctype="multipart/form-data">
	<div class="question" style="margin-left: 80px;">
	   <div class="quest_body">
		   	<label style="font-size: 13px;">教学过程记录表：<font color="red"><b>*</b></font></label>
		   <span style="margin-left:10px;">
		   		<input type="file" name="file"/>
			   	<input type="submit" id="importButton" value="导入" class="button_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
			   	<input type="reset" value="重置" class="button_d"/>
		   </span>
	   </div>
	  
	   <div id="explainDiv">
	   	<br />
		     说明：Excel格式如下图所示：<br/>
		     导入的学生信息在《教学过程记录表.xls》文件的第一个工作表 “list” 中。<br/>
		     学生信息必须从第2行开始，姓名必在第2列，身份证号在第3列，身份证号不能出现重复。<br/>
		  <img src="images/stu_excel_format.jpg" width="830"/>
	   </div>
	</div>
</form>
<a href="file/dowload.do">把数据库的表导出到Excel表</a>
</div>
</body>
</html>
