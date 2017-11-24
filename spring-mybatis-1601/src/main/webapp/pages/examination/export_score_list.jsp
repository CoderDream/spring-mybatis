<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>查看学生成绩 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript">
function doDelete(id){
	 $.messager.confirm("确认删除", "您真的要删除该项？", function(r){
		if (r){
			$.ajax({
				type : "POST",
				url : encodeURI("score/delete.do"),
				data : "id="+id,
				success : function(msg){
				  $("#row"+id).remove();
				 showMsgOnRightBottom("操作提示","删除成功！", 3000, "success");
				}
			});
		}
	});
}
function find(id){
	 $.messager.confirm("确认", "您真的要刷新", function(r){
		if (r){
			$.ajax({
				type : "POST",
				url : encodeURI("score/selectAll.do"),
				data : "examNo="+id,
				//success : function(msg){
				
				// showMsgOnRightBottom("操作提示","刷新成功！", 3000, "success");
				//}
			});
		}
	});
}
</script>

</head>
<body class="main_body">
   <div class="button_bar">
		<button class="button_b_b button_bar_btnText" onclick="find('${examNo }');">刷新</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </div>
 <table border="0" width="100%">
  <tr>
  	<td width="10px"></td>
  	<td style="border: 1px solid gray;" align="center">
  		<h2 align="center">考试成绩&nbsp;&nbsp;<font color="red">(试卷编号：${examNo })</font></h2>
  		
  		<div class="listDiv" style="padding-left:0px;">
  		<table class="data_list" border="0" cellpadding="1" cellspacing="1" width="100%">
		  			<tr class="data_list_thead">
			  			<th width="30px" align="center">序号</th>
			  			<th width="80px" >姓名</th>
			  			<th width="50px">成绩</th>
			  			<th width="40px" align="center">性别</th>
			  			<th width="160px" align="center">在读/毕业院校</th>
			  			<th width="160px" align="center">专业</th>
			  			<th width="60px" align="center">最高学历</th>
			  			<th width="50px" align="center">操作</th>
			  		</tr>
			  <c:if test="${scoreList!=null }">
		 	 	<c:forEach var="it" items="${scoreList }" varStatus="stat">
			  	<tr id="row">
			  			<td align="center">${it.id}</td>
			  			<td align="center" class="student">${it.user.userName }</td>
			  			<td align="center" }>
			  				${it.score }
			  			</td>
			  			<td align="center">${it.user.gender }</td>
			  			<td align="center">${it.user.graduteSchool }</td>
			  			<td align="center">${it.user.marjor }</td>
			  			<td align="center">${it.user.eduBackground }</td>
			  			<td align="center">
			  				<a href="javascript:void(0);" >
			  					<img title="删除" src="images/table/bt_del.gif" onclick="doDelete('${it.id}')" alt="删除" />
			  				</a>
			  			</td>
			  		</tr>
			  	
	  	 	 </c:forEach>
	  	 	 </c:if>
			</table>
			<br/>
		 <c:if test="${scoreList!=null && scoreList.size()>0 }">
			<div>
			  	<form id="importForm" action="writer/excl.do" method="post" 
			  		enctype="multipart/form-data">
			  		<input type="hidden" name="examNo" value="${examNo }"/>
			  		
			  		<div class="quest_body">
					   	<label style="font-size: 13px;">教学过程记录表：<font color="red"><b>*</b></font></label>
					   	
					   	
				  		<input type="submit" class="button_b_b button_bar_btnText" value="导出成绩" />
				    </div>
			  	</form>
			</div>
			<div id="explainDiv" style="text-align:left;margin-left:10px;">
			   
			   	<img src="images/score_excel_fmt.jpg" width="820"/>
		   </div>
	  	  </c:if>
	  	<br/>
	  </div>
  	</td>
  	<td width="10px" ></td>
  </tr>
 </table>
 <jsp:include page="../even_odd.jsp"></jsp:include>
</body>
</html>
