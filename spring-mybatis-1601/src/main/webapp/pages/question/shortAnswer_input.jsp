﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>判断题 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript">

/* function updateFsp(){
	var valid = $("#shortAnwserForm").form("validate"); //实际form("validate")是调用用easyui的验证方法
	var data=$("#shortAnwserForm").serialize();
	if(valid){
		
		$.post("/fsp/updateFsp.do",data,function(r){
			if(r){
				showMsgBoxOnCenter("提示","更新成功！", 200,100,2000, "error");
				//location.href="fsp/selectFspForPage.do?flag=1&questionType=5";
				//window.setTimeout("window.location='/pages/question/shortAnswer_list.jsp'",2000);
			}
		});
	}
} */
$(function(){
	//初始化课程下拉列表
	$.get("courses/selectAllCourses.do",function(jsonList){
		var co = $("#a");
		
		$.each(jsonList, function(i,c){
			co.append("<option value='" +c.id+ "'>" + c.courseName + "</option>");
		});
		$("#a option").each(function(){
			if($(this).attr("value")==$("#c").attr("value")){
				$(this).attr({selected:"selected"});
				
				var id= $("#c").attr("value");
				var ca = $("#b");
				ca.empty();
				$.get("category/selectAllCategory.do",{"courseId": id}, function(jsonList){
					$.each(jsonList, function(i,category){
						ca.append("<option value='" +category.id+ "'>" + category.techCtgr + "</option>");
					});
					$("#b option").each(function(){
						if($(this).attr("value")==$("#tc").attr("value")){
							$(this).attr({selected:"selected"});
						}
					});
				},"json");
			}
		});
	},"json");
	
	$("#a").change(function(){
		var courses = $(this).val();
		
		var ca = $("#b");
		ca.empty();
		$.get("category/selectAllCategory.do",{"courseId": courses}, function(jsonList){
			$.each(jsonList, function(i,category){
				ca.append("<option value='" +category.id+ "'>" + category.techCtgr + "</option>");
			});
		},"json");
		
	});
	
});



</script>

</head>
<div class="button_bar">
	<button class="button_b_b button_bar_btnText" onclick="location.href='pages/question/shortAnswer_list.jsp'">查询选题</button> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>

<form id="shortAnwserForm" action="fsp/updateFsp.do?flag=1" method="post">
	<!-- 隐藏字段 -->
	<input type="hidden" name="id" value="${fsp.id }"/>
	<input type="hidden" name="questionType" value="${fsp.questionType }"/>
	<input type="hidden" name="pubdate" value="${fsp.pubdate }"/>
	<input type="hidden" name="descrpt" value="${fsp.descrpt }"/>
	<input type="hidden" id="c" value="${category.courseId}"/>
	<input type="hidden" id="tc" value="${fsp.techCateId}"/>
  	<div style="margin-left:150px;">
  		<div class="error invalid_error"><span></span></div>
  			<div style="float:left;">
		   		<label><font color="red"><b>*&nbsp;</b></font>课程：</label><label id="catagoryError" class="catagoryMsg"></label><br/>
			   		<select id="a" name="courses" size="7" style="width:290px;height: 120px;" ></select>
		   	</div>
		  	<div style="float:left; margin-left: 5px;">
			  	<label><font color="red"><b>*&nbsp;</b></font>知识点：</label><label id="questCtgrError" class="catagoryMsg"></label><br/>
				  	<select id="b" name="techCateId" size="7" style="width:290px;color:black;height: 120px;"></select>
		  	</div>
  	</div>
  	<div style="clear:both;border: 0px solid red;margin-left:150px;padding-top: 20px;">
      <table cellpadding="0" cellspacing="0" border="0px"  ><!-- style="margin-left:150px;" width="583px;" -->
	   	<tr>
	   		<th align="left"><font color="red"><b>*&nbsp;</b></font>简答题题干</th>
	   	</tr>
	   	<tr>
	   		<td><textarea name="question" cols="78" rows="3">${fsp.question }</textarea></td>
	   	</tr>
	   	<tr>
	   		<th align="left"><br/><font color="red"><b>*&nbsp;</b></font>标准答案</th>
	   	</tr>
	   	<tr>
	   		<td><textarea name="stdAnswer" cols="78" rows="5">${fsp.stdAnswer }</textarea></td>
	   	</tr>
	   	<tr style="height: 50px;">
	   		<td align="center">
	   			<input type="submit" value="保存" class="button_b" onclick=""/>&nbsp;&nbsp;&nbsp;&nbsp;
	   			<input type="reset" value="重置" class="button_h"/>
	   		</td>
	   	</tr>
     </table>
   </div>
</form>
</html>
