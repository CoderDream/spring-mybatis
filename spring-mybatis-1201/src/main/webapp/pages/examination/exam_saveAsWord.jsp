<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int i = 1;
%>
<%!
String getChineseNumber(int ii){
	switch(ii){
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
    <title>考卷 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
<link type="text/css" rel="stylesheet" href="js/prettify/prettify-custom.css"/>
<link rel="stylesheet" href="css/buttons/font-awesome.min.css"/>
<link rel="stylesheet" href="css/buttons/buttons.css"/>
<link rel="Stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/screen.css"/>
<link rel="Stylesheet" type="text/css" href="js/easyui/easyui-messager.css" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
<script type="text/javascript" src="js/prettify/prettify.js"></script>
<script type="text/javascript" src="js/buttons.js"></script>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript">
$(window).load(function(){
     prettyPrint();
});

$(function(){
	$("#subBtn").click(function(){
		var key = [];
		var value = [];
		//循环单选
		
			$("input[name='sing']").each(function(){
				key.push($(this).val());
				//alert($(this).val());
			});
			$("input[name^='radio_']").each(function(){
				if($(this).prop("checked")==true){
					value.push($(this).val());
					//alert($(this).val());
				}
			});
			
		
		
			$("input[name='multiple']").each(function(){
				key.push($(this).val());
				//alert($(this).val());
			});
			$("div[id^='multipleDiv']").each(function(){
				var mult="";
				$(this).find(":checkbox").each(function(){
					if($(this).prop("checked")==true){
						mult=mult+$(this).val();
				}
				});
					value.push(mult);
					//alert(mult);
					//alert(value);
			}); 
			
		
		
			$("input[name='tf']").each(function(){
				key.push($(this).val());
				//alert($(this).val());
			});
			$("input[name^='tf_']").each(function(){
				if($(this).prop("checked")==true){
					value.push($(this).val());
					//alert($(this).val());
				}
			});
			$("input[name='sim']").each(function(){
				key.push($(this).val());
				//alert($(this).val());
			});
			$("textarea[name^='sim_']").each(function(){
					value.push($(this).val());
					//alert($(this).val());
			});
			$("input[name='pro']").each(function(){
				key.push($(this).val());
				//alert($(this).val());
			});
			$("textarea[name^='pro_']").each(function(){
					value.push($(this).val());
					//alert($(this).val());
				
			});
			var userId=$("#userId").val();
			var examNo=$("#examno").val();
			//alert(key);
			//alert(value);
		location.href="exam/saveAnswer.do?key="+key+"&answer="+value+"&userId="+userId+"&examNo="+examNo;
		
	});
	
});

</script>
<style type="text/css" >
p{
	font-size: 17px;
	font-weight: bold;
	font-style: italic;
	margin-left:-17px;
}
</style>

</head>
<body class="main_body" >
 <table id="content" border="0" width="100%">
  <tr>
  	<td width="5px"></td>
  	<td style="border: 1px solid gray;">
  	<form id="exam" name="exam" action="exam/saveAnswer.do" method="post">
  		<h2 align="center">试卷 &nbsp;&nbsp;<font color="red">(编号：${exam.examNo})</font></h2>
 	<!-- 列表 -->
 	 <input type="hidden" id="userId" value="${sessionScope.user.id}"/>
 	  <input type="hidden" id="examno" value="${exam.examNo}"/>
 	<div class="listDiv" style="margin-left:17px;">
	  	<!-- 单选题部分 -->
	  	<c:if test="${singlist!=null}">
		<p>(<%=getChineseNumber(i++) %>)&nbsp;单选题，每题2分，共${singlist.size()}题，共${singlist.size()*2 }分。</p>
		    <c:forEach var="sing" items="${singlist }" varStatus="stat">
		  	  <div id="radioDiv${sing.id }" class="radio_list" style="width:100%;">
		  	  <input type="hidden" name="sing" value="radio${sing.id }"/>
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
				  	<label style="margin-left: 10px;">请选择答案：</label>
				  	<span class="exam_answers">
				  		<input type="radio" name="radio_${sing.id }" value="A" 
				  			onclick="pickOne('radio_${sing.id }',this);"/>A&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="radio" name="radio_${sing.id }" value="B" 
				  			onclick="pickOne('radio_${sing.id }',this);"/>B&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="radio" name="radio_${sing.id }" value="C" 
				  			onclick="pickOne('radio_${sing.id }',this);"/>C&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="radio" name="radio_${sing.id }" value="D" 
				  			onclick="pickOne('radio_${sing.id }',this);"/>D&nbsp;&nbsp;</span>
				  	<br /><br />
			  	</div>
		  	</div>
		  	</c:forEach>
		</c:if>
		
		<!-- 多选题部分 -->
			<c:if test="${multlist!=null}">
				<p>(<%=getChineseNumber(i++) %>)&nbsp;多选题，每题4分，共${multlist.size()}题，共${multlist.size()*4 }分。</p>
		      <c:forEach var="mult" items="${multlist}" varStatus="stat">
		  	  <div id="multipleDiv${muil.id }" class="radio_list" style="width:100%;">
		  	   	<input type="hidden" name="multiple" value="multiple${mult.id }"/>
			  	<div class="radio_list_body" style="font-size:14px;">
		  			<label style="color: black;">&nbsp;${stat.count }.</label>
			  		<a id="questionBody" 
			  			href="javascript:showOptions('mqo_${stat.count }');">${mult.question }</a>
			  	</div>
			  	<div id='mqo_${stat.count }' class="radio_list_options" style="width:897px;">
				  	<ul style="padding-left: 20px;">
				  		<li>A</li>
				  		<li>B</li>
				  		<li>C</li>
				  		<li>D</li>
				  		<c:if test="E!=null">
					  		<li>E</li>
				  		</c:if>
				  	</ul>
				  	<label style="margin-left: 10px;">请选择答案：</label>
				  	<span class="exam_answers">
				  		<input type="checkbox" name="multiple_${mult.id }" value="A" 
				  			onclick="pickMultiple(this);" class="chk-box"/>A&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="checkbox" name="multiple_${mult.id }" value="B" 
				  			onclick="pickMultiple(this);" class="chk-box"/>B&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="checkbox" name="multiple_${mult.id }" value="C" 
				  			onclick="pickMultiple(this);" class="chk-box"/>C&nbsp;&nbsp;</span>
				  	<span class="exam_answers">
				  		<input type="checkbox" name="multiple_${mult.id }" value="D" 
				  			onclick="pickMultiple(this);" class="chk-box"/>D&nbsp;&nbsp;</span>
				  <c:if test="selectOption.optionE!=null">
				  	<span class="exam_answers">
				  		<input type="checkbox" name="multiple_${mult.id }" value="E" 
				  			onclick="pickMultiple(this);" class="chk-box"/>E&nbsp;&nbsp;</span>
				  </c:if>
				  	<br /><br />
			  	</div>
		  	</div>
		  </c:forEach>
		</c:if>
		
		 <!-- 判断题部分 -->
		<c:if test="${tflist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;判断题，每题1分，共${tflist.size()}题，共${tflist.size() }分。</p>
			    <c:forEach var="tf" items="${tflist}" varStatus="stat">
			  	<div id="tORfDiv${tf.id }" class="radio_list" style="width:100%;">
			  		<input type="hidden" name="tf" value="tf${tf.id }"/>
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
				  			${tf.question }
				  		<br />
				  	</div>
				  	请选择答案：
				  		<span>
					  		<input type="radio" name="tf_${tf.id }" value="对" 
					  			onclick="pickOneTF('tf_${tf.id }',this);"/>正确</span>&nbsp;&nbsp;
				  		<span>
					  		<input type="radio" name="tf_${tf.id }" value="错" 
					  			onclick="pickOneTF('tf_${tf.id }',this);"/>错误</span>
			  		<br />
			  	</div>
			</c:forEach>
		  	<br />
			</c:if>
		
		<!-- 简答题部分 -->
		<c:if test="${simlist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;简答题，每题5分，共${simlist.size()}题，共${simlist.size()*5 }分。</p>
			 
			  <c:forEach var="sim" items="${simlist }" varStatus="stat">
			  	<div id="shtAnswerDiv${sim.id }" class="radio_list" style="width:1050px;">
			  	<input type="hidden" name="sim" value="sim${sim.id }"/>
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
					  		<pre class="pre_body">${sim.question }</pre>
				  		<br />
				  	</div>
				  	<span style="padding-left:17px;">
				  		<br/>
				  		<span style="padding-left:17px;">
				  		<%-- sa_简答题题号 --%>
				  		<textarea name="sim_${sim.id }" rows="8" cols="115"></textarea>
				  	</span>
				  		
				  	</span>
			  		<br />
			  	</div>
			 </c:forEach>
		  	<br />
			</c:if>	
	  	<!-- 编程题部分 -->	
		<c:if test="${prolist!=null}">
		  	<p>(<%=getChineseNumber(i++) %>)&nbsp;编程题，每题10分，共${prolist.size()}题，共${prolist.size()*10 }分。</p>
			  <c:forEach var="pro" items="${prolist }" varStatus="stat">
			  <input type="hidden" name="pro" value="pro${pro.id }"/>
			  	<div id="programDiv${pro.id }" class="radio_list" style="width:1050px;">
			  	
				  	<div class="radio_list_body" style="color:blue;">
			  			<label style="color: black;">&nbsp;${stat.count }.</label>
					  		${pro.question }
				  		<br />
				  	</div>
				  	<span style="padding-left:17px;">
				  		<br/>
				  		<span style="padding-left:17px;">
				  		<%-- sa_编程题号 --%>
				  		<textarea name="pro_${pro.id }" rows="15" cols="115"></textarea>
				  	</span>
				 			  		<br />
			  	</div>
			 </c:forEach>
		  	<br />
	  	</c:if>
	</div>
  	
  	 <div align="center">
		  <input id="subBtn" type="button" value="交卷" class="button button-pill button-action" style="font-size:15px;font-weight: bold;"/>
		 	</input>
	  	 
	  	<br /><br />
	  </div>
	  </form>
  	<td width="10px" ></td>
  </tr>
 </table>
</body>
</html>
