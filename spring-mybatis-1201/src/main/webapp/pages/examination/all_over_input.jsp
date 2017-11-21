<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>结束本次考试 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
<script type="text/javascript">

</script>

</head>
<body>
<div class="button_bar">
	&nbsp;&nbsp;&nbsp;
</div>
<div>
<form id="overExamForm"  method="post">
	<div class="question">
	   <div class="quest_body">
		   	<label id="msg" class="error" style="margin-left:50px;"></label><br/><br/>
		   	<label style="font-size: 13px;"><font color="red"><b>*</b></font>???????</label>
		   	<input type="text" id="examNo" name="examNo"  maxlength="14" value="%{#session.ExamNo}" title="请输入或选择编号"/>
		   	<input id="selExamNoBtn" type="button" value="选择" onclick="selectExamNo();" style="font-size: 11px;"/>
		   	<font color="red">??????</font>
	   </div>
	   	<!-- 显示试卷编号列表 -->
  		<div id="examNoListDiv" style="display:none;margin-left:50px;">
  			<ul class="listSelectItem"></ul>
  		</div>
	   <div style="margin-left:70px;margin-top: 10px;">
		   	<input type="button" id="examButton" value="结束考试" class="button_b_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
		   	<input type="reset" value="重置" class="button_h_b"/>
	   </div>
	</div>
</form>
</div>
</body>
</html>
