<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>主观题答案 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript">
$(function(){
	$("div[id^=answerDiv]").css({display:"none"});
	
	//$("#answerDiv").hide();
});

function toggle(id){
	$("#"+id).toggle();
	
}
function sumit(id){
	
	$("#"+id).click(function(){
		
		//var i=$("input[name='keguanti']").val();
		var j,g,i;
		if($("input[name='keguanti']").val()!=null){
			i=$("input[name='keguanti']").val();
		}
		else{
			i=0;
		}
		if($("input[name='jianda']").val()!=null){
			 j=$("input[name='jianda']").val();
		}
		else {
			 j=0;}
		if($("input[name='biancheng']").val()!=null){
			 g=$("input[name='biancheng']").val();
		}
		else {
			 g=0;}
		var userId=$("input[name='userId']").val();
		var examNo=$("input[name='examNo']").val();
		var score=i+j+g;
		$("#"+span).text("该生总分："+score);
		 to("score/update.do?sco="+score+"&userIds="+userId+"&exam="+examNo);
	
		});
		

}

</script>
<style type="text/css">
p{
	font-size: 17px;
	font-weight: bold;
	font-style: italic;
	margin-left:-15px;
	margin-top:0px;
	padding-top:0px;
	color:red;
	background-color:bisque;
	cursor: move;
}
.stu_score,.stu_score_title{
	display:none;
	font-size: 15px;
	color:red;
	margin-left:5px;
}
legend{
	font-size:15px;
	font-weight: bold;
	color:black;
	margin-bottom:5px;
}
</style>
</head>
<body class="main_body">
 
 <table border="0" width="100%">
  <tr>
  	<td width="5px"></td>
  	<td style="border: 0px solid gray;">
  		<h3 align="center">改卷 &nbsp;&nbsp;<font color="red"><input type="hidden" name="examNo" value="${sessionScope.exam.examNo }"/>(编号：${sessionScope.exam.examNo })</font></h3>
  		<!-- 列表 -->
  		<div class="listDiv" style="margin-left:10px;width:980px;">
		<!-- 学生简答题答案 -->
		<c:if test="${requestScope.userList != null }">
			<c:forEach var="userList" items="${userList }" varStatus="stat">
			
			  <form name="answerForm${stat.count }">
		  		<p onclick="toggle('answerDiv${userList.id }');">
		  		<input type="hidden" name="userId" value="${userList.id }"/>
		  			${stat.count }.&nbsp;${userList.userName }&nbsp;&nbsp;&nbsp;
		  			<font color="black">客观题得分：
		  			
		  			<input name="keguanti" value="${userList.scores}" style="border:0px;"/>
		  			
		  			</font>
		  			
		  		</p>
		  		<div id="answerDiv${userList.id }">
			  		
			  		<!-- 简答题 -->
		  			<c:forEach var="an" items="${userList.answer}" varStatus="st">
				  	  <c:if test="${an.fsp.questionType==5 }">
				  		<fieldset style="width:890px;border:0px;">
							<legend>（一）简答题,每题5分</legend>
				  			<div class="radio_list" style="width:960px;">
							  	<div class="radio_list_body" style="color:blue;" title='简答题,每题<s:property value="@com.olts.commons.Constant@SHORT_POINT"/>分'>
						  			<label style="color:black;">&nbsp;${st.count }.</label>&nbsp;${an.fsp.question }
							  	</div>
							  	<div><!-- class="student-shortanswer" -->
							  		<pre class="prettyprint lang-*" style="margin:2px 0px;padding:0px;">${an.answer }</pre>
							  		得分：<input type="text" name="jianda" size="3" maxlength="2" />分
							  	</div>
						  	</div>
						  	<br/>
					  	</fieldset>
			  		  </c:if>
					  <c:if test="${an.fsp.questionType==6 }">
							<fieldset style="width:890px;border:0px;">
							<legend>（二）编程题,每题10分</legend>
				  			<div class="radio_list" style="width:960px;">
							  	<div class="radio_list_body" style="color:blue;" title='编程题,每题<s:property value="@com.olts.commons.Constant@PROG_POINT"/>分'>
						  			<label style="color:black;">&nbsp;${st.count }.</label>&nbsp;${an.fsp.question }
							  	</div>
							  	<div><!--  class="student-program-answer" -->
							  		<pre class="prettyprint linenums lang-*" style="margin:2px 0px;">${an.answer }</pre>
							  		得分：<input type="text" name="biancheng" size="3" maxlength="2"/>分
							  	</div>
						  	</div>
						  	<br/>
						  	</fieldset>
				  		</c:if>
				  		</c:forEach>
				  	<br/>
					
			  		<input type="button" id="chengjitijiao${userList.id }" style="margin-top:-25px;margin-bottom:15px;" value="完成" onclick="sumit('chengjitijiao${userList.id }','tip${userList.id }')"/>
			  		<span id="tip${userList.id }" class="stu_score"></span>
			  	</div>
			  </form>
			</c:forEach>
			
			
			
	  	</c:if>
	  	<c:if test="${userList==null }">
	  		<br/>
	  		<h1 style="color:red;margin-left:430px;">本次考试无简答题和编程题!</h1>
	  	</c:if>

	  	<br/>
	  </div>
  	</td>
  	<td width="5px" ></td>
  </tr>
 </table>
</body>
</html>
