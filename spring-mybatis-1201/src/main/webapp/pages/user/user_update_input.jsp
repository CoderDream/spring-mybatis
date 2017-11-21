<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>更新用户 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="${basePath}js/WdatePicker.js"></script>
<script type="text/javascript">
function submitForm(){
		//easyui的form上调用validate方法
		var valid = $("#updateForm").form("validate"); //实际form("validate")是调用用easyui的验证方法

		//如果都验证成功,提交表单
		if(valid){
			//检测用户名
			$("#updateForm").submit(); //表单提交
		}else{
			return false;
		}
	}
</script>
</head>
<body class="main_body" >
<div>
<form  id="updateForm" action="user/updateUser.do" method="post">
	
	<div class="question" style="margin-left: 60px;">
	   <div class="error invalid_error"><br/></div>
	   <div style="margin-top:10px; ">
	   	<fieldset style="width: 550px;">
	   		<legend>${updateUser.userName }用户信息</legend>
			   <table cellpadding="0" cellspacing="0" border="0px" width="550px">
				   	<tr>
				   		<td width="100px" align="right">用户名：</td>
				   		<td>
				   		<input name="id" value="${updateUser.id }" type="hidden"/>
				   		${updateUser.userName }
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right"><font color="red"><b>*</b></font>新密码：</td>
				   		<td><input type="password" id="passWord" name="passWord" 
				   		   class="easyui-validatebox" required="required" validtype="safepass"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right"><font color="red"><b>*</b></font>确认新密码：</td>
				   		<td><input type="password"  id="passWord2" name="passWord2" 
				   		    class="easyui-validatebox" required="true" validType="equalsTo['#passWord']"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">性别：</td>
				   		<td>
				   			<input type="radio" name="gender" value="男"/>男
				   			<input type="radio" name="gender" value="女"/>女
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">出生日期：</td>
				   		<td>
				   			<fmt:formatDate var="fmtBirthday" value="${updateUser.birthday }" pattern="yyyy-MM-dd"/>
				   			<input type="text" id="birthday" name="mybirthday" 
				   				value="${fmtBirthday }" onclick="WdatePicker({skin:'ext',readOnly:true})" 
				   				title="请选择出生日期" />
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">身份证号：</td>
				   		<td><input name="idCardNo" value="${updateUser.idCardNo}" maxlength="18"
				   			 class="easyui-validatebox" required="true" validType="idcard"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">手机：</td>
				   		<td><input name="mobile" value="${updateUser.mobile}"
				   				class="easyui-validatebox" data-options="required:true,validType:'mobile'"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">QQ：</td>
				   		<td><input name="qq" value="${updateUser.qq}"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">email：</td>
				   		<td><input name="email" value="${updateUser.email}"
				   			class="easyui-validatebox" required="true" validType="email"/></td>
				   	</tr>
				   	<tr>
				   		<td align="right">籍贯：</td>
				   		<td><input name="nationPlace" value="${updateUser.nationPlace}" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">专业：</td>
				   		<td><input name="marjor" value="${updateUser.marjor}" /></td>
				   	</tr>
				   	<tr>
				   		<td align="right">最高学历：</td>
				   		<td>
				   			<select name="eduBackground">
				   				<optgroup label="--请选择--"></optgroup>
				   				<option value="本科">本科</option>
				   				<option value="硕士">硕士</option>
				   				<option value="博士">博士</option>
				   				<option value="专科">专科</option>
				   			</select>
				   		</td>
				   	</tr>
				   	<tr>
				   		<td align="right">院校：</td>
				   		<td><input name="graduteSchool" value="${updateUser.graduteSchool}" /></td>
				   	</tr>												
				   	<tr id="emptyRow" style="height: 10px;">
				   		<td colspan="2" align="center"><br/>
				   			<input type="submit" value="保存"  onclick="submitForm()" class="button_b"/>
				   			<input type="button" value="关闭" class="button_b" onclick="closeDialog();"/>
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
