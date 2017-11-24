<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>单选题 </title>
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
<body class="main_body" >
<div>
<form id="userForm" action="secure/userInfo!update.action" method="post">
	<s:hidden name="id" value="%{#session.authUser.id}"/>
	<div class="question" style="margin-left: 160px;">
	   <div class="error invalid_error"><span></span><br/></div>
	   <div style="margin-top:10px; margin-left:50px;">
	   	<fieldset style="width: 560px;">
	   		<legend>用户信息</legend>
			   <table cellpadding="0" cellspacing="0" border="0px" width="560px">
				   	<tr>
				   		<td width="100px" align="right">用户名：</td>
				   		<td><s:textfield name="userName" value="%{#session.authUser.userName}" readonly="true"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right"><font color="red"><b>*</b></font>旧密码：</td>
				   		<td><s:password id="oldPassWord" name="oldPassWord" value="%{#session.authUser.passWord}"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right"><font color="red"><b>*</b></font>新密码：</td>
				   		<td><s:password id="passWord" name="passWord" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right"><font color="red"><b>*</b></font>确认密码：</td>
				   		<td><s:password  id="passWord2" name="passWord2" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">性别：</td>
				   		<td><%--<input name="gender" value='<s:property value="#session.authUser.gender"/>'/> --%>
				   			<s:radio name="gender" list="{'男','女'}" value="#session.authUser.gender"></s:radio>
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">出生日期：</td>
				   		<td>
				   			<s:date var="birth" name="#session.authUser.birthday" format="yyyy-MM-dd"/>
				   			<input type="text" id="birthday" name="birthday" 
				   				value='<s:property value="%{birth}"/>' onclick="WdatePicker({skin:'ext',readOnly:true})" 
				   				title="请选择出生日期" />(yyyy-MM-dd)
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">身份证号：</td>
				   		<td><s:textfield name="idCardNo" value="%{#session.authUser.idCardNo}" maxlength="18"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">手机：</td>
				   		<td><s:textfield name="mobile" value="%{#session.authUser.mobile}"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">QQ：</td>
				   		<td><s:textfield name="qq" value="%{#session.authUser.qq}" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">email：</td>
				   		<td><s:textfield name="email" value="%{#session.authUser.email}"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">籍贯：</td>
				   		<td><s:textfield name="nationPlace" value="%{#session.authUser.nationPlace}" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">专业：</td>
				   		<td><s:textfield name="marjor" value="%{#session.authUser.marjor}" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">最高学历：</td>
				   		<td><%--<s:textfield name="educationBackground" value="%{#session.authUser.educationBackground}" />  --%>
				   			<s:select name="educationBackground" list="{'本科','专科','硕士','博士'}" 
				   				value="%{#session.authUser.educationBackground}"
				   				headerKey="" headerValue="---请选择学历---"></s:select>
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">毕业院校：</td>
				   		<td><s:textfield name="graduateSchool" value="%{#session.authUser.graduateSchool}" /></td>
				   	</tr>
				   	<tr id="emptyRow" style="height: 10px;">
				   		<td colspan="2" align="center"><br/>
				   			<s:submit value="保存" cssClass="button_b"></s:submit>
				   			<div class="custome_error" style="display:block;">${msg}</div>
				   		</td>
				   	</tr>
			   </table>
			</fieldset>
	   </div>
	</div>
</form>
</div>
</body>
</html>
