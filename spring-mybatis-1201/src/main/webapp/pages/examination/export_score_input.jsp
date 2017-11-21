<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>导出考生成绩</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" href="css/buttons/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/buttons/buttons.css"/>
	<script type="text/javascript" src="js/buttons.js"></script>
	<script type="text/javascript" src="js/jquery-1.9.0.js"></script>	
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
					location.href="score/selectAll.do?examNo="+data;
				}
			},"text");
		}
	});
});
</script>


</head>
<body class="main_body">
<div style="margin-left: 50px; margin-top: 50px;">
<form id="examForm" method="post">
	<div class="question">
	   <div class="quest_body">
		   	<label style="font-size: 13px;"><font color="red"><b>*</b></font>考卷编号</label>
		   	<input type="text" id="examNo" name="examNo" maxlength="14"title="请输入或选择编号"/>
		   	<span id="tips" style="color:red;font-size:12px; font-style: italic;"></span>
		   	<input id="selExamNoBtn" type="button" value="选择" onclick="selectExamNo();" style="font-size: 11px;"/>
		   	<label class="error"></label>
		   	<font color="red" style="font-size: 12px;">（注：考点拼音简称2~6个大写字母+YYMMDD+1~2位班级号，如北京大学1班：PU1211201）</font>
	   </div>
	   <!-- 显示试卷编号列表 -->
  		<div id="examNoListDiv" style="display:none;margin-left:50px;">
  			<ul class="listSelectItem" style="list-style: none;">
  				<c:forEach var="list" items="${requestScope.examList }" varStatus="statu">
  					<li style="font-size: 12px;">
  						${statu.count} <input type="radio" name="examMessage" value="${list.examNo }" onclick="writeToBlank(this)"/>
 						${list.examNo } 
  						<fmt:formatDate value="${list.examDate }" pattern="yyyy年MM月dd日"/>
  					</li>
  				</c:forEach>
  			</ul>
  		</div>
	   <div style="margin-left:70px;margin-top: 10px;">
		   <a id="examBtn" href="javascript:void(0)" class="button button-rounded button-flat-primary">改卷</a>&nbsp;&nbsp;&nbsp;&nbsp;
		   <input style="width:80px;height:32px;background-color: gray;list-style:circle;color:white;" type="reset" value="重置"/>
	   </div>
	</div>
</form>
</div>
</body>
</html>
