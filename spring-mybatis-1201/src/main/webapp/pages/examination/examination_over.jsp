<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int i = 1;
%>
<%!
String getChineseNumber(int i){
	switch(i){
		case 1: return "一";
		case 2: return "二";
		case 3: return "三";
		case 4: return "四";
		case 5: return "五";
		case 6: return "六";
		default: return "";
	}	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>学生考试结束(得分) </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link type="text/css" rel="stylesheet" href="js/prettify/prettify-custom.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/screen.css"/>

<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/prettify/prettify.js"></script>
<script type="text/javascript" src="js/jquery.hotkeys.min.js"></script>
   
<script type="text/javascript">
$(function(){
    prettyPrint();
    

});

</script>   
<style type="text/css">
p{
	font-size: 17px;
	font-weight: bold;
	font-style: italic;
	margin-left:-17px;
}
</style>
</head>
<body class="main_body" >
<div>
<form id="examForm"  method="post">
	<div class="question" style="margin-left: 100px;">
	   <div class="quest_body" style="margin-left: 50px;margin-bottom: 10px;">
	   		<c:if test="invalidExam!=null">
	   			<h1 style="color:red;"></h1>
	   		</c:if>
		   	<label style="font-size:15px;">单选、多选、判断题得分：</label>
		   	<label style="font-size:20px;color:red;">${score }分</label>
		   	<!-- 
		   	<input type="button" value="退出" class="button_h_b" style="margin-left:10px;"/>
		   	 -->
	   </div>

	   <div>
	   	 <ul class="right-count">
	   		<li>单选题答对：${sing }&nbsp;题</li>
	   		<li>多选题答对：${mult }&nbsp;题</li>
	   		<li>判断题答对：${tf }&nbsp;题</li>
	   	 </ul>
	   </div>
	 
	</div>
</form>
</div>

 <table border="0" width="100%">
  <tr>
  	<td width="3px"></td>
  	<td style="border: 1px solid gray;">
  		<h2 align="center">试卷 预览&nbsp;&nbsp;<font color="red">(编号：${exam.examNo})</font></h2>
  		<!-- 列表 -->
  		<div class="listDiv" style="margin-left:17px;">
		<input type="hidden"  vlaue="${answ}" id="answ"/>
	  	<!-- 单选题部分 -->
	  <c:if test="${singlist!=null}">
	  		<p>(<%=getChineseNumber(i++) %>)&nbsp;
	  			单选题，每题2分，共${singlist.size()}题，共${singlist.size()*2 }分。</p>
		    <c:forEach var="sing" items="${singlist }" varStatus="stat">
		  	  <div id="radioDivmultlist" class="radio_list" style="width:100%;">
			  	<div class="radio_list_body" style="font-size:14px;">
		  			<label style="color: black;">&nbsp;${stat.count }.</label>
			  		<a id="questionBody" 
			  			href="javascript:showOptions('qo_${stat.count }');">${sing.question }</a>
			  	</div>
			  	<div id='qo_${stat.count }' class="radio_list_options" style="width:897px;">
				  	<ul style="padding-left: 20px;">
				  		<li>A</li>
				  		<li>B</li>
				  		<li>C</li>
				  		<li>D</li>
				  		<c:if test="E!=null">
					  		<li>E</li>
				  		</c:if>
				  	</ul>
				  	<label style="margin-left: 10px;">
				  		<font color="red">正确答案：${sing.correct }</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  		您的答案：
					<c:forEach var="sa" items="${singanswer }" varStatus="st">
					<c:if test="${stat.count==st.count }">
					${sa }
					</c:if>
					</c:forEach>
				  	</label>
				  	<br /><br />
			  	</div>
		  	</div>
		  	</c:forEach>
		  	</c:if>
		
		<!-- 多选题部分 -->
	  	<c:if test="${multlist!=null}">
	  		<p>(<%=getChineseNumber(i++) %>)&nbsp;
	  			多选题，每题4分，共${multlist.size()}题，共${multlist.size()*4 }分。</p>
		    <c:forEach var="mult" items="${multlist}" varStatus="stat">
		  	  <div id="multipleDiv${mult.id }" class="radio_list" style="width:100%;">
			  	<div class="radio_list_body" style="font-size:14px;">
		  			<label style="color: black;">&nbsp;${stat.count }.</label>
			  		<a id="questionBody" 
			  			href="javascript:showOptions('mqo_${stat.count }');">${mult.question }</a>
			  	</div>
			  	<div id='mqo_${stat.count }' class="radio_list_options" style="width:897px;">
				  	<ul style="padding-left: 20px;">
				  		<li>selectOption.optionA</li>
				  		<li>selectOption.optionB</li>
				  		<li>selectOption.optionC</li>
				  		<li>selectOption.optionD</li>
				  		<c:if test="selectOption.optionE!=null">
					  		<li>selectOption.optionE</li>
				  		</c:if>
				  	</ul>
				  	<label style="margin-left: 10px;">
				  		<font color="red">正确答案：答案：${mult.correct }</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  		您的答案：
				  		<c:forEach var="sa" items="${multanswer}" varStatus="stt">
					<c:if test="${stat.count==stt.count }">
					${sa }
					</c:if>
					</c:forEach>
				  	</label>
				  	<br /><br />
			  	</div>
		  	</div>
		  	</c:forEach>
		  	</c:if>
		
		 <!-- 判断题部分 -->
		<c:if test="${tflist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;
		  		判断题，每题1分，共${tflist.size()}题，共${tflist.size() }分。</p>
			   <c:forEach var="tf" items="${tflist}" varStatus="stat">
			  	<div id="tORfDiv${tf.id }" class="radio_list" style="width:100%;">
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
				  			${tf.question }
				  		<br />
				  	</div>
			  	  	<label style="margin-left: 10px;">
				  		<font color="red">正确答案：${tf.correct }</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  		您的答案：
				  		<c:forEach var="sa" items="${tfanswer }" varStatus="sts">
					<c:if test="${stat.count==sts.count }">
					${sa }
					</c:if>
					</c:forEach>
				  	</label>
			  		<br />
			  	</div>
			</c:forEach>
		  	<br />
	  </c:if>

		<!-- 简答题部分 -->
		<c:if test="${simlist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;简答题，每题5分，共${simlist.size()}题，共${simlist.size()*5 }分。</p>
			  <c:forEach var="sim" items="${simlist }" varStatus="stat">
			  	<div id="shtAnswerDiv${sim.id }" class="radio_list exam_prog_quest_textarea">
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
					  		<pre class="pre_body">${sim.question }</pre>
				  		<br />
				  	</div>
				  	<div style="padding-left:19px;">
				  		<br/>
				  		<label style="color:red;">参考答案：</label>
				  		<pre class="prettyprint lang-*" style="font-size:13px;">${sim.stdAnswer }</pre>
				  	</div>
				  	<div style="padding-left:19px;">
				  		<br/>
				  		<label style="color:red;">你的答案：</label>
				  	<c:forEach var="sa" items="${simanswer }" varStatus="str">
					<c:if test="${stat.count==str.count }">
					
				  		<pre class="prettyprint lang-*" style="font-size:13px;">${sa }</pre>
					</c:if>
					</c:forEach>
				  	</div>
				 
			  		<br />
			  	</div>
			</c:forEach>
		  	<br />
	  	</c:if>
	  	
	  	<!-- 编程题部分 -->
		<c:if test="${prolist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;
		  		编程题，每题10分，共${prolist.size()}题，共${prolist.size()*10 }分。</p>
			  <c:forEach var="pro" items="${prolist }" varStatus="stat">
			  	<div id="programDiv${pro.id }" class="radio_list exam_prog_quest_textarea">
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
					  		<pre class="pre_body">${pro.question }</pre>
				  		<br />
				  	</div>
				  	<div style="padding-left:17px;">
				  		<br/>
				  		<label style="color:red;">参考答案：</label>
				  		<pre class="prettyprint linenums lang-*" style="font-size:13px;">${pro.stdAnswer }</pre>
				  	</div>
				 		<div style="padding-left:19px;">
				  		<br/>
				  		<label style="color:red;">你的答案：</label>
				  	<c:forEach var="sa" items="${proanswer }" varStatus="stl">
					<c:if test="${stat.count==stl.count }">
					
				  		<pre class="prettyprint lang-*" style="font-size:13px;">${sa }</pre>
					</c:if>
					</c:forEach>
				  	</div>
			  		<br />
			  	</div>
			 </c:forEach>
		  	<br />
	  </c:if>
	  </div>
  	</td>
  	<td width="10px" ></td>
  </tr>
 </table>
</body>
</html>
