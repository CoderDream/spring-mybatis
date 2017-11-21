<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}">
    <title>判断题 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<script type="text/javascript">


</script>
</head>
<body class="main_body">
<div class="button_bar">
	<button class="button_b_b button_bar_btnText" onclick="to('${basePath}secure/forward.action?target=trueOrFalseList');">查询选题</button> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>

<form id="trueOrFalseForm" action="secure/trueOrFalseQuestion!%{flag==null?\"add\":\"update\"}.action" method="post">
	<s:hidden name="id" />
	<input type="hidden" name="catagoryId" value='<s:property value="questCatagory.catagory.id"/>'/>
	<s:hidden name="questType" value="3"></s:hidden>
	<!-- 添加操作标识 -->
	<s:hidden name="flag" value="1"></s:hidden>
	
  	<div style="margin-left:150px;">
  		<div class="error invalid_error"><span></span><br/></div>
  		<div style="float:left; margin-right: 2px;">
  			<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.catagory"/></label><label id="catagoryMsg" class="catagoryMsg"></label><br/>
		  	<s:if test="#request.catagorys!=null && #request.catagorys.size()>0">
		  		<s:select id="catagory" name="questCatagory.catagory.id" list="#request.catagorys" listKey="id" 
		  			listValue="catagory" value="%{questCatagory.catagory.id}" size="7" cssStyle="width:290px;"></s:select>
		  	</s:if>
		  	<s:else>
		   		<select id="catagory" name="questCatagory.catagory.id" size="7" style="width:290px;"></select>
		  	</s:else>
		  	<br/><br/>
  		</div>
  		<div style="float:left;margin-right: 5px;">
	  		<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.questCatagory"/></label><label id="questCtgrError" class="catagoryMsg"></label><br/>
	  		 <s:if test="questCtgrys!=null && questCtgrys.size()>0">
		  	  	<s:select id="questCatagory" name="questCatagory.id" list="questCtgrys" listKey="id" listValue="techCatagory" 
		  	  			value="%{questCatagory.id}" size="7" cssStyle="width:290px;color:black;"></s:select>
		  	  </s:if>
		  	  <s:else>
		  			<select id="questCatagory" name="questCatagory.id" size="7" style="width:290px;color:black;"></select>
		  	  </s:else>
		  	<br/>
  		</div>
  	</div>
  	<br/>
   <table style="margin-left:150px;" width="750px;" cellpadding="0" cellspacing="0">
	   	<tr>
	   		<th width="400">内容</th>
	   		<th align="left">正确答案</th>
	   	</tr>
	   	<tr>
	   		<td><s:textarea name="question" cols="65" rows="3"/></td>
	   		<td>
	   			<div style="float:left;">
		   			<input type="radio" name="correct" value="T" <s:property value="(correct!=null && correct.contains(\"T\")) ? \"checked='checked'\" : \"\""/> />对<br />
		   			<input type="radio" name="correct" value="F" <s:property value="(correct!=null && correct.contains(\"F\")) ? \"checked='checked'\" : \"\""/> />错
		   			<label id="tfMsg" class="catagoryMsg"></label>
	   			</div>
	   		</td>
	   	</tr>
	   	<tr style="height: 50px;">
	   		<td colspan="2" style="padding-left:225px;">
	   			<s:submit value="保存" cssClass="button_b"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
	   			<s:reset value="重置" cssClass="button_h"></s:reset>
	   		</td>
	   	</tr>
   </table>
		
</form>
</body>
</html>
