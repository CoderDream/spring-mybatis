<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>知识点分类</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css" />
<link rel="stylesheet" type="text/css" href="css/screen.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript" src="script/jsonLoad.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript">
function findByCatagoryId(){
	var id=document.getElementById("id").value;
	to("tech/search.do?id="+id);
}
function doCanncel(cataId){
	var td = $("#row"+cataId + " td:nth-child(2)");
	var txtspan = td.children("span:first-child");
	txtspan.show();
	td.children("span:last-child").children("[type='text']").val(txtspan.text());
	td.children("span:last-child").hide();
	$("#button"+cataId).val("更新");
}
function doUpdate(el,cataId){
	var td = $("#row"+cataId + " td:nth-child(2)");
	var btnVal = $(el).val();
	var txtSpan = td.children("span:first-child");
	var inputSpan = td.children("span:last-child");
	if(btnVal=="更新"){
		txtSpan.hide();
		inputSpan.show();
		$(el).val("保存");
	}else{ //保存修改的值
		//获得输入框的值
		var v = td.children("span:last-child").children(":input").val();
		txtSpan.empty();
		txtSpan.text(v);
		txtSpan.show();
		inputSpan.hide();
		$(el).val("更新");
		//
		var _url = "tech/update.do";
		var myurl = encodeURI(_url);
		$.ajax({type : "POST",
			url : myurl,
			data : "id="+cataId+"&techCtgr="+v,
			success : function(result){
				if(result=="true"){
					showMsgOnRightBottom("操作提示","更新成功！", 3000,"success");
				}
			}
		});
	}
}
function doDelete(id){
	to("tech/delete.do?id="+id);
}
</script>
<style type="text/css">
.msg{
	color: red;
	font-style: italic;
	font-weight: normal;
}
.listData_btn{
	font-size: 11px;
	margin:0px;
}
</style>
</head>
<body class="main_body">

<form action="tech/addTech.do" method="post">
	<fieldset style="width: 480px;margin-left:130px;">
		<legend>新增知识点</legend>
	  	<div style="margin-left:110px;">
	  		<div class="error invalid_error" style="padding-top:5px;margin-left:-100px;"><span></span></div>
	  		<div style="float:left; margin-right: 5px;">
	  			<label>课程</label><label id="catagoryMsg" class="msg"></label><br/>
		   		<select size="10" style="width:200px" name="oltscatagory.id" id="id">
		   			<c:forEach var="catagory" items="${CatagoryList}">
		   				<option value="${catagory.id}">${catagory.courseName}</option>
		   			</c:forEach>
		   		</select>
			  	<br/><br/>
	  		</div>
	  	</div>
	    <table style="margin-left:110px;" width="583px;" cellpadding="0" cellspacing="0" border="0px">
		   	<tr>
		   		<th align="left"><label>知识点：<input type="text" name="techCtgr"/></label></th>
		   	</tr>
		   	<tr style="height: 50px;">
		   		<td align="left">
		   		  <span style="margin-left:30px;">
		   			<input type="submit" value="保存"/>&nbsp;&nbsp;&nbsp;&nbsp;
		   			<input type="button" value="查询" class="button_b" onclick="findByCatagoryId();"/>&nbsp;&nbsp;&nbsp;&nbsp;
		   			<input type="reset" value="重置"/>
		   		  </span>
		   		</td>
		   	</tr>
	   </table>
	</fieldset> 
</form>
	
<table class="table-border-1px" style="margin-left:130px;margin-top:10px;" width="500px">
  	<tr style="height: 25px; font-weight: bold;">
  		<th align="center" width="30px">序号</th>
  		<th align="center">知识点</th>
  		<th align="center" width="160px">操作</th>
  	</tr>

 <c:forEach var="tech" items="${techList}">
  	<tr id="row${tech.id}">
  		<td align="center">${stat.count}</td>
  		<td>
  			<span>${tech.techCtgr}</span>
  			<span class="update" style="display: none;">
  				<input type="text" value="${tech.techCtgr}" size="33" class="listData_input"/>
  				<input type="button" value="取消" onclick="doCanncel(${tech.id})" class="listData_btn"/>
  			</span>
  		</td>
  		<td align="center">
  			<input id="button${tech.id}" type="button" value="更新" class="listData_btn" 
  				onclick="doUpdate(this,${tech.id});"/>&nbsp;&nbsp;
  			<input type="button" value="删除" class="listData_btn" 
  				onclick="doDelete(${tech.id});"/>
  		</td>
  	</tr>
</c:forEach>
</table>
</body>
</html>
