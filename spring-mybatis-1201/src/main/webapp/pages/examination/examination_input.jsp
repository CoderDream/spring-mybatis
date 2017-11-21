<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}">
    <title>开始考试 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
	$("#examButton").click(function(){
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
					location.href="exam/selectExam.do?flag=2&examNo="+data;
				}
			},"text");
		}
	});
});
$(function(){
	$("#overButton").click(function(){
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
					
					$.get("exam/endExam.do",{examNo:data},function(result){
						if(result=="true"){
							$("#endEx").append("考试结束，所有未提交的试卷无效！");
						}
					},"text");
				}
			},"text");
		}
	});
});


</script>

</head>
<body class="main_body" oncontextmenu="return false">
<div class="button_bar">
	&nbsp;&nbsp;&nbsp;
</div>
<div>
<form id="examForm"  method="post">
	<div class="question">
	   <div class="quest_body">
	   		<label id="msg" class="error" style="margin-left:50px;"> 	<span id="endEx" style="color:red;font-size:14px; font-style: italic;"></span></label><br/><br/>
		   	<label style="font-size: 13px;"><font color="red"><b>*</b></font><font style="font-weight: bolder;">考卷编号</font>
		   	<input id="examNo" name="examNo" maxlength="14" value="${exam.ExamNo}" title="请输入或选择编号"/>
		   	<span id="tips" style="color:red;font-size:14px; font-style: italic;"></span>
		   	<input id="selExamNoBtn" type="button" value="选择" onclick="selectExamNo();"  style="font-size: 11px;"/><!-- selectExamNo(); -->

		   	<label class="error"></label>
		   	<font color="red"><b>(注：考点拼音简称2-6个大写字母+YYMMDD+1-2位班级号码，如北京大学1班PU12110101)</b></font>
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
		   	<input type="button" id="examButton" value="考试" class="button_b">&nbsp;&nbsp;&nbsp;&nbsp;
		  <c:if test="${user!=null && user.userType==1}">  
		   
		   <input type="button" id="overButton" value="结束考试" class="button_b_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
		  </c:if>
		   	<input type="reset" value="重置" class="button_h">
	   </div>
	</div>
</form>
</div>
</body>
</html>
