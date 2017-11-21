<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>批量删除用户</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css"/>
<link rel="stylesheet" type="text/css" href="css/screen.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css"/>
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="js/easyui/easyui-dialog.js"></script>
<script type="text/javascript" src="${basePath}js/WdatePicker.js"></script>
<script type="text/javascript" src="script/common.js"></script>

<script type="text/javascript">


</script>

</head>
<body class="main_body">
 <table border="0" width="97%">
  <tr>
  	<td width="20px"></td>
  	<td style="border: 1px solid gray;" align="center">
  		<h3 align="center">学员列表</h3>
  		<div class="listDiv" style="padding-left:0px;">
		  	<table class="data_list" border="0" cellpadding="1" cellspacing="1" width="100%">
	  			<tr class="data_list_thead">
		  			<th width="20px" align="center">序号</th>
		  			<th width="50px" >姓名</th>
		  			<th width="90px" align="center">身份证号码</th>
		  			<th width="100px" align="center">专业</th>
		  			<th width="50px" align="center">最高学历</th>
		  			<th width="70px" align="center">手机号码</th>
		  			<th width="70px" align="center">QQ号码</th>
		  			<th width="50px" align="center">操作</th>
		  		</tr>
		 	 <s:if test="#attr.users!=null">
			  	<s:iterator value="#attr.users" status="stat">
			  		<tr id="tr_<s:property value="id"/>">
			  			<td align="center">
			  				<input name="userIds" type="checkbox" class="chk-box" value="<s:property value="id"/>"/> &nbsp;&nbsp;
			  				<s:property value="#stat.count"/></td>
			  			<td align="center" class="student">
			  				<label><s:property value="userName"/></label>
			  			</td>
			  			<td align="center" class="text_number"><s:property value="idCardNo"/></td>
			  			<td align="center"><s:property value="marjor"/></td>
			  			<td align="center"><s:property value="educationBackground"/></td>
			  			<td align="center" class="text_number"><s:property value="mobile"/></td>
			  			<td align="center" class="text_number"><s:property value="qq"/></td>
			  			<td align="center">
			  				<!-- <img src="${contextPath}/images/table/bt_del.gif" title="删除" />&nbsp;&nbsp; -->
			  				<a href="javascript:return false;"><img src="${contextPath}/images/table/bt_edit.gif" alt="更新" onclick="toUpdate(<s:property value="id"/>);" style="cursor:hand;" title="更新"/></a>
			  			</td>
			  		</tr>
			  	</s:iterator>
			</s:if>
				<tr>
					<td colspan="9" style="padding-left: 10px;">
						<input type="checkbox" name="checkAll" onclick="checkAll(this,'userIds')"  class="chk-box"/>全选
						&nbsp;&nbsp;&nbsp;
						<button id="batch_del_btn">批量删除</button>&nbsp;<font color="red" size="2">(删除后不可恢复)</font>
					</td>
				</tr>
			</table>
			<br />
	  </div>
  	</td>
  	<td width="10px" ></td>
  </tr>
 </table>
<jsp:include page="../even_odd.jsp"></jsp:include>
<script type="text/javascript">
$(".data_list tr:last").unbind("mouseover");
$(".data_list tr:last").unbind("mouseout");
</script>
<div id="dialog" title="更新用户" style="display: none;"></div>

</body>
</html>
