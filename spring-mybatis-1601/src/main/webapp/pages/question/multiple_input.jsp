<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>单选题 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
<script type="text/javascript">


</script>

</head>
<body class="main_body">
<div class="button_bar">
	<button class="button_b_b button_bar_btnText" onclick="to('${basePath}secure/forward.action?target=multipleList');">查询选题</button> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div>
<s:form id="multipleForm" action="secure/multipleQuestion!%{flag==null?\"add\":\"update\"}.action" method="post">
	<s:hidden name="id" />
	<s:hidden name="questType" value="2"></s:hidden>
	<input type="hidden" name="catagoryId" value='<s:property value="questCatagory.catagory.id"/>' />
	<s:hidden name="questCatagory.id" ></s:hidden>
	<s:hidden name="selectOption.id" ></s:hidden>
	<!-- 添加操作标识 -->
	<s:hidden name="flag" value="1"></s:hidden>
	
	<div class="question"  style="margin-left: 160px;">
		<div class="error invalid_error"><span></span></div>
	   <div class="quest_body" style="margin-top:-5px;">
		   	<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.multiple.body"/></label><br/>
		   	<s:textarea name="question" rows="12" cols="78"></s:textarea>
	   </div>
	   <div style="margin-top:10px; margin-left:5px;">
		  	<div>
		  		<div style="float:left;">
		  			<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.catagory"/></label><label id="catagoryMsg" class="catagoryMsg"></label><br/>
			   		<s:if test="#request.catagorys!=null && #request.catagorys.size()>0">
				  		<s:select id="catagory" name="questCatagory.catagory.id" list="#request.catagorys" listKey="id" listValue="catagory" value="%{questCatagory.catagory.id}" 
				  			size="7" cssStyle="width:290px;"></s:select>
				  	</s:if>
				  	<s:else>
				   		<select id="catagory" name="questCatagory.catagory.id" size="7" style="width:290px;"></select>
				  	</s:else>
				  	<br/><br/>
		  		</div>
		  		<div style="float:left;">
			  		<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.questCatagory"/></label><label id="questCtgrError" class="catagoryMsg"></label><br/>
				  	<s:if test="questCtgrys!=null && questCtgrys.size()>0">
				  	  	<s:select id="questCatagory" name="techCatagory" list="questCtgrys" listKey="id" listValue="techCatagory" 
				  	  		value="%{questCatagory.id}" size="7" cssStyle="width:290px;color:black;"></s:select>
				   </s:if>
			  	   <s:else>
				  		<select id="questCatagory" name="techCatagory" size="7" style="width:290px;color:black;"></select>
			  	   </s:else>
				  	<br/>
		  		</div>
				<div style="clear:both;"><!-- float:left;margin-left: -292px; -->
				   <table id="optionTbl" cellpadding="0" cellspacing="0" border="0px">
					   	<tr>
					   		<th width="18px">选项</th>
					   		<th>内容</th>
					   		<th  width="30px">正确答案</th>
					   		<th rowspan="5" valign="middle">
					   			<div id="correctMsg" class="custome_error"></div>
					   		</th>
					   	</tr>
					   	<tr>
					   		<td><font color="red"><b>*</b></font>A.</td>
					   		<td><s:textarea id="optionA" name="selectOption.optionA" cols="65"/></td>
					   		<td><input type="checkbox" name="correct" value="A" class="chk-box" <s:property value="(correct!=null && correct.contains(\"A\"))?\"checked='checked'\":\"\""/> /></td>
					   	</tr>
					   	<tr>
					   		<td><font color="red"><b>*</b></font>B.</td>
					   		<td><s:textarea id="optionB" name="selectOption.optionB" cols="65" /></td>
					   		<td><input type="checkbox" name="correct" value="B" class="chk-box" <s:property value="(correct!=null && correct.contains(\"B\"))?\"checked='checked'\":\"\""/>/></td>
					   	</tr>
					   	<tr>
					   		<td><font color="red"><b>*</b></font>C.</td>
						   <td><s:textarea id="optionC" name="selectOption.optionC" cols="65" /></td>
						   <td><input type="checkbox" name="correct" value="C" class="chk-box" <s:property value="(correct!=null && correct.contains(\"C\"))?\"checked='checked'\":\"\""/>/></td>
					   	</tr>
					   	<tr>
					   		<td><font color="red"><b>*</b></font>D.</td>
						   <td><s:textarea id="optionD" name="selectOption.optionD" cols="65"/></td>
						   <td><input type="checkbox" name="correct" value="D" class="chk-box" <s:property value="(correct!=null && correct.contains(\"D\"))?\"checked='checked'\":\"\""/>/></td>
					   	</tr>
					   	<tr>
					   		<td>E.</td>
						   <td><s:textarea id="optionE" name="selectOption.optionE" cols="65" /></td>
						   <td><input type="checkbox" name="correct" value="E" class="chk-box" <s:property value="(correct!=null && correct.contains(\"E\"))?\"checked='checked'\":\"\""/>/></td>
					   	</tr>
					   	<tr id="emptyRow" style="height: 10px;"><td colspan="3"></td></tr>
				   </table>
			   </div>
		  	</div>
	   </div>
	   <div style="margin-left:250px;width:300px;">
		   	<s:submit value="保存" cssClass="button_b"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
		   	<s:reset value="重置" cssClass="button_h"></s:reset>
	   </div>
	</div>
</s:form>
</div>
</body>
</html>
