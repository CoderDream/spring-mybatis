<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>学生信息列表 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="js/easyui/easyui.validatebox-ext.js"></script>
<script type="text/javascript" src="${basePath}js/WdatePicker.js"></script>
<script type="text/javascript">
//会话框
function toUpdate(idCardNo){
	var left = (document.body.clientWidth-700)/2;
	var top = (document.body.clientHeight-450)/2;
	$("#dialog").css({"top":top, "left":left});
	$("#dialog").dialog({
		title: '编辑用户',    
	    width: 700,    
	    height: 460,    
	    closed: false,
	    cache: false,    
	    href: '/olts/user/findByIdCard.do?idCardNo='+idCardNo,    
	    modal: true  
	});
}
//会话框
function closeDialog(){
	$("#dialog").dialog("close"); 
}

//全部删除
function deleteAllByCheckbox(){
	var idCardNos=[];
	$("input[type='checkbox']").each(function(){
		if($(this).prop("checked")==true){
			idCardNos.push($(this).val());
		}
	});
	
	location.href="user/deleteUserByIdCard2.do?idCardNos="+idCardNos;
	
}


//全选
function checkAll(check){
	$("input[type='checkbox']").prop("checked",check);
}
</script>
</head>
<body class="main_body">

 <table border="0" width="100%">
  <tr>
  	<td width="10px"></td>
  	<td style="border: 1px solid gray;" align="center">
  		<form action="user/findAll.do" method="post">
  			用户名：<input name="userName"/>
  			专业：<input name="marjor"/>
  			<input type="submit" value="查询" class="button_b" />
  		</form>
  		<c:if test="${num!=null }">
  			<h3 style="color:red;">检测到有${num}条记录已经存在，不再重复插入</h3>
  		</c:if>
  			<h3 style="color:red;">检测到有${num}条记录已经存在，不再重复插入</h3>
  		<h3 align="center">用户列表</h3>
  		<div class="listDiv" style="padding-left:0px;width: 100%;">
		  	<table class="data_list" border="0" cellpadding="1" cellspacing="1" width="100%">
	  			<tr class="data_list_thead">
		  			<th width="20px" align="center">序号</th>
		  			<th width="50px" >学号</th>
		  			<th width="50px" >姓名</th>
		  			<th width="50px" >性别</th>
		  			<th width="100px">身份证号</th>
		  			<th width="40px" align="center">最高学历</th>
		  			<th width="100px" align="center">院校</th>
		  			<th width="60px" align="center">专业</th>
		  			<th width="50px" align="center">手机号码</th>
		  			<th width="70px" align="center">操作</th>
		  			
		  		</tr>
			  	<c:forEach var="u" items="${userList }" varStatus="stat">
			  		<tr>
			  			<td align="center">
			  			<input type="checkbox" id="${u.idCardNo }" name="${u.idCardNo }" value="${u.idCardNo }" class="checkboxs"/>
			  			${stat.count }</td>
			  			<td align="center" class="student">${u.stuNo }</td>
			  			<td align="center" >${u.userName }</td>
			  			<td align="center" >${u.gender }</td>
			  			<td align="center">${u.idCardNo }</td>
			  			<td align="center">${u.eduBackground }</td>
			  			<td align="center">${u.graduteSchool }</td>
			  			<td align="center">${u.marjor }</td>
			  			<td align="center">${u.mobile }</td>
			  			<td align="center">
			  			<img onclick="toUpdate('${u.idCardNo }')" src="images/table/bt_edit.gif" 
			  				alt="update" title="编辑" style="cursor: pointer;"/>
			  			&nbsp;&nbsp;
			  			<a href="user/deleteUserByIdCard.do?idCardNo=${u.idCardNo }">
			  			<img src="images/table/bt_del.gif" alt="delete" title="删除"/>
			  			</a>
			  			</td>
			  		</tr>
			  	</c:forEach>
			  	
			  	<tr>
			  		<td colspan="10">&nbsp;</td>
			  	</tr>
			  	<tr>
					<td colspan="10" style="padding-left: 10px;">
						<input type="checkbox" id="checkAll" onclick="checkAll(this.checked)"  class="chk-box"/>全选
						&nbsp;&nbsp;&nbsp;
						<button id="batch_del_btn" onclick="deleteAllByCheckbox()">批量删除</button>&nbsp;
						<font color="red" size="2">(删除后不可恢复)</font>
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
  <div id="dialog"></div>
  
</body>
</html>
