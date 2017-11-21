<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>单选题 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
<script type="text/javascript">
$(function(){

});
</script>

</head>
<body class="main_body">
<div class="button_bar">
	<button class="button_b_b button_bar_btnText" onclick="to('${basePath}secure/forward.action?target=radioList');">查询选题</button> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div>
<form id="radioForm" action="" method="post">
	
	<div class="question" style="margin-left: 160px;">
	   <div class="error invalid_error"><span></span><br/></div>
	   <div class="quest_body" style="margin-top:-5px;">
		   	<label><font color="red"><b>*&nbsp;</b></font></label><br/>
		   	<textarea name="question" rows="12" cols="78"/>
	   </div>
	   <div style="margin-top:10px; margin-left:5px;">
		  	<div>
		  		<div style="float:left;">
		  			<label><font color="red"><b>*&nbsp;</b></font></label><br/>
				  	<select  size="7" style="width:290px;"></select>
				   	<select size="7" style="width:290px;"></select>
				  	<br/><br/>
		  		</div>
		  		<div style="float:left;">
			  		<label><font color="red"><b>*&nbsp;</b></font></label><br/>
			  	  	<select size="7" style="width:290px;color:black;"></select>
				  	<select  size="7" style="width:290px;color:black;"></select>
				  	<div id="techMsg" class="custome_error"></div>
				  	<br/>
		  		</div>
		  </div>
		  <div style="clear:both;border: 0px solid red;"><
			   <table id="optionTbl" cellpadding="0" cellspacing="0" border="0px">
				   	<tr>
				   		<th width="18px">选项</th>
				   		<th>内容</th>
				   		<th width="30px">正确答案</th>
				   		<th rowspan="5" valign="middle">
				   			<div id="correctMsg" class="custome_error"></div>
				   		</th>
				   	</tr>
				   	<tr>
				   		<td><font color="red"><b>*</b></font>A.</td>
				   		<td><textarea id="optionA" name="selectOption.optionA" cols="65"/></td>
				   		<td><input type="radio" name="correct" value="A" /></td>
				   	</tr>
				   	<tr>
				   		<td><font color="red"><b>*</b></font>B.</td>
				   		<td><textarea id="optionB" name="selectOption.optionB" cols="65"/></td>
				   		<td><input type="radio" name="correct" value="B" /></td>
				   	</tr>
				   	<tr>
				   		<td><font color="red"><b>*</b></font>C.</td>
					   <td><textarea id="optionC" name="selectOption.optionC" cols="65"/></td>
					   <td><input type="radio" name="correct" value="C" /></td>
				   	</tr>
				   	<tr>
				   		<td><font color="red"><b>*</b></font>D.</td>
					   <td><textarea id="optionD" name="selectOption.optionD" cols="65"/></td>
					   <td><input type="radio" name="correct" value="D" />&nbsp;&nbsp;</td>
				   	</tr>
				   	<tr id="emptyRow" style="height: 10px;"><td colspan="4"></td></tr>
			   </table>
		   </div>
	   </div>
	   <div style="margin-left:250px;width:300px;">
		   	<input type="submit" value="保存" class="button_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
		   	<input type="reset" value="重置" class="button_h"/>
	   </div>
	</div>
</form>
</div>
</body>
</html>
