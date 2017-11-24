<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
application.setAttribute("basePath",basePath);
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="${basePath}">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>"蓝桥怀"软件学院在线考试系统</title>
    <link rel="shortcut icon"  href="images/favicon.ico" type="image/x-icon" />
    <link rel="bookmark" href="images/favicon.ico" type="image/x-icon"/>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
    <link rel="stylesheet" type="text/css" href="js/easyui/main.css"/>
    <link rel="Stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<style>
</style>
<script type="text/javascript">
var count = 0;
var timerId;

function fnTimer(){
	count++;
	//Date是js中标准的类
	var now = new Date();//得到当前时间
	var year = now.getFullYear();
	var month = now.getMonth()+1;
	var date = now.getDate();
	var week = now.getDay();
	var hour = now.getHours();
	var minute = now.getMinutes();
	var second = now.getSeconds();
	var h=hour+"AM";
	
	var str = "今天是：" + year + "年" + month + "月" + date + "日星期" +week+"&nbsp;&nbsp;";
	
	timer.innerHTML = str;
	
	
}

//写在函数外
timerId = setInterval(fnTimer,1000);

</script>


<%@include file="main-js.jsp" %>	
</head>
<body class="easyui-layout" oncontextmenu="return false" onload="fnTimer()">
	<div region="north" border="true" class="cs-north">
		<div class="cs-north-bg top-bg divTop">
			<span class="header-title">&nbsp;&nbsp;&nbsp;<img src="images/logo2.png" height="60px" valign="middle"/>在线考试系统</span>
			<span class="exit">
				${sessionScope.user.userName}&nbsp;&nbsp;<label id="timer" style="display:inline-block;"></lable>
				<a href="javascript:logout()" style="color:red;">退出系统</a>
			</span>
		</div>
	</div>
	<div region="west" border="true" split="true" title="导航 " class="cs-west">
		<div class="easyui-accordion" fit="true" border="false">
				<div title="考试管理" class="menu-bg">
				  <ul>
				  		<li><a href="javascript:void(0);" src="exam/selectAll.do?flag=1" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>考试</a></li>
			         <c:if test="${user!=null && user.userType==1}">
						<li><a href="javascript:void(0);" src="examination/searchExamByFlag.do" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>主观题阅卷</a></li>
					    <li><a href="javascript:void(0);" src="exam/selectAll.do?flag=3" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>查看成绩</a></li>
					    <li><a href="javascript:void(0);" src="exam/selectAll.do?flag=2" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>考卷维护</a></li>
			       </c:if>
				  </ul>
				</div>
			<c:if test="${user!=null && user.userType==1}">
				<div title="试题新增" class="menu-bg">
					<ul>
					  <li><a href="javascript:void(0);" src="pages/question/radio_input.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>新增单选题</a></li>
				      <li><a href="javascript:void(0);" src="pages/question/multiple_input.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>新增多选题</a></li>
				      <li><a href="javascript:void(0);" src="pages/question/trueOrFalse_input.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>新增判断题</a></li>
				     <!--  <li><a href="javascript:void(0);" src="pages/question/shortAnswer_add.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>新增简答题</a></li>
				      <li><a href="javascript:void(0);" src="pages/question/program_add.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>新增编程题</a></li> -->
				    </ul>
				</div>
				<div title="试题查询" class="menu-bg">
				  <ul>
					<li><a href="javascript:void(0);" src="pages/question/radio_list.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>单选题查询</a></li>
				    <li><a href="javascript:void(0);" src="pages/question/multiple_list.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>多选题查询</a></li>
				    <li><a href="javascript:void(0);" src="pages/question/trueOrFalse_list.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>判断题查询</a></li>
				    <li><a href="javascript:void(0);" src="exam/selectAll.do?flag=5" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>简答题查询</a></li>
				    <li><a href="javascript:void(0);" src="exam/selectAll.do?flag=6" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>编程题查询</a></li>
				  </ul>
				</div>
				<div title="分类管理" class="menu-bg">
				  <ul>
					<li><a href="javascript:void(0);" src="secure/list.do" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>课程名</a></li>
				    <li><a href="javascript:void(0);" src="secure/listforquest.do" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>知识点</a></li>
				  </ul>
				</div>
	        </c:if>
				<div title="用户管理" class="menu-bg">
				  <ul>
				<c:if test="${user!=null && user.userType==1}">
				    <li><a href="javascript:void(0);" src="pages/user/importExcel_input.jsp" class="cs-navi-tab" title="从excle文件中导入"><img src="images/icons/ns_doc.gif"/>批量导入用户</a></li>
	    			<li><a href="javascript:void(0);" src="secure/userInfo!findByType.action" class="cs-navi-tab" title="删除和修改"><img src="images/icons/ns_doc.gif"/>批量操作用户</a></li>
	    		</c:if>
				    <li><a href="javascript:void(0);" src="pages/user/user_input.jsp" class="cs-navi-tab"><img src="images/icons/ns_doc.gif"/>修改用户信息</a></li>
			 </ul>
				</div>
		</div>
	</div>
	<div id="mainPanle" region="center" border="true" border="false">
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
            <div title="Home" class="welcome">
				<div class="cs-home-remark">
					<img src="images/home.jpg" width="650" height="430" title="祝你考试成功" />
				</div>
			</div>
        </div>
	</div>
<!-- 
	<div region="south" border="false" id="south"><center>65538815@qq.com</center></div>
 -->
	<div id="mm" class="easyui-menu cs-tab-menu">
		<div id="mm-tabcloseother">关闭其他</div>
		<div id="mm-tabcloseall">关闭全部</div>
	</div>
</body>
</html>