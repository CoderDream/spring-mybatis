<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}">
    <title>考卷维护 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link type="text/css" rel="stylesheet" href="js/prettify/prettify-custom.css"/>
<link rel="stylesheet" href="css/buttons/font-awesome.min.css"/>
<link rel="stylesheet" href="css/buttons/buttons.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/screen.css"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="js/prettify/prettify.js"></script>
<script type="text/javascript" src="js/buttons.js"></script>
<script type="text/javascript" src="script/common.js"></script>

<script type="text/javascript">
 
$(function(){
	$("#selExamNoBtn").click(function(){
		$(this).toggleClass(function(){
			if($(this).val()=="选择"){
				$("#examNoListDiv").css({display:"block"});
				$(this).val("隐藏");
			}else{
				$("#examNoListDiv").css({display:"none"});
				$(this).val("选择");
			}
		});
	});
});
//把radio的值填入文本框
function writeToBlank(id){
	var examNo = $(id).val();
	$("#examNo").val(examNo);
}
//清空文本框
function resetValue(){
	$("#examNo").empty();
}
//执行ajax查询考卷状态
$(function(){
	$("#examBtn").click(function(){
		$("#tips").empty();
		var data = $("#examNo").val();
		if($.trim(data).length==0){
			$("#examNo")[0].focus();
			$("#tips").append("请输入考卷编号！");
		}
		else{
			$.get("examination/query.do",{examNo:data},function(result){
				if(result=="false"){
					$("#tips").append("考卷不存在，请重新输入考卷编号！");
				}else{
					location.href="exam/selectExam.do?flag=1&examNo="+data;
				}
			},"text");
		}
	});
});
</script>

</head>
<body class="main_body">
<div class="button_bar">
	&nbsp;&nbsp;&nbsp;
</div>
<div>
<form id="examForm" name="examForm" method="post">
	<%-- 1:调整试卷、完成出卷；0：考试 --%>
	<input type="hidden" name="doFlag" value="1" id="examForm_doFlag"/>
	<div class="question">
	   <div class="quest_body">
		   	<label style="font-size: 13px;"><font color="red"><b>*</b></font><font style="font-weight: bolder;">考卷编号</font></label>
		   	<input id="examNo" name="examNo"   maxlength="14" title="请输入或选择编号"></input>
		   	<span id="tips" style="color:red;font-size:14px; font-style: italic;"></span>
		   	<input id="selExamNoBtn" type="button" value="选择" onclick="selectExamNo();" style="font-size: 11px;"/>

		   	<label class="error"></label>
		   	<font color="red"><b>(注：考点拼音简称2-6个大写字母+YYMMDD+1-2位班级号码，如北京大学1班PU12110101)</b></font></font>
	   </div>
	   <!-- 显示试卷编号列表 -->
  		<div id="examNoListDiv" style="display:none;margin-left:50px;">
  			<ul class="listSelectItem">
  			<c:forEach var="list" items="${requestScope.examList }" varStatus="statu">
  					<li style="font-size: 12px;">
  						<input type="radio" name="examMessage" value="${list.examNo }" onclick="writeToBlank(this)"/>
 						${list.examNo } 
  						<fmt:formatDate value="${list.examDate }" pattern="yyyy年MM月dd日"/>
  					</li>
  				</c:forEach>
  			</ul>
  		</div>
	   <div style="margin-left:70px;margin-top: 10px;">
		   	<input type="button" id="examBtn" value="维护" class="button_b"></input>&nbsp;&nbsp;&nbsp;&nbsp;
		   	<input type="button" id="examBtn" onclick="exportToWord();" class="button_b" style="padding-right:2px;" value="导出试卷  "/>&nbsp;&nbsp;&nbsp;&nbsp;
		   	<input type="reset" value="重置" class="button_h"></input>
	   </div>
	</div>
</form>
</div>
</body>
</html>
