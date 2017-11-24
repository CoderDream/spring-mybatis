<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="p" uri="http://www.lanqiao.com/tag/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>考卷出编程题 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" id="swicth-style"/>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link type="text/css" rel="stylesheet" href="js/prettify/prettify-custom.css"/>
	<link rel="stylesheet" type="text/css" href="js/easyui/easyui-messager.css" />
	<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="js/prettify/prettify.js"></script>
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/easyui/easyui-messager.js"></script>
	<script type="text/javascript" src="script/courses-category.js"></script>
<style>
ulli{ list-style-type:decimal;}
</style>
	
	
<script type="text/javascript">
/**
 * 显示隐藏选择项
 */
function showOptions(qo){
	$("#"+qo).toggle();
}
/**
 * 全部展开、收起选择项
 */
function collapseExpand(cssClass){
	var collExp = $(":hidden[name='coll_exp']")
	var v = collExp.val();
	if(v==0){
		$(cssClass).show();
		collExp.val(1);
		$(".collapse_expand").html("[-]");
	}else{ 
		$(cssClass).hide();
		collExp.val(0);
		$(".collapse_expand").html("[+]");
	}
	return false;
}
//全选
function checkAll(flag){
	var box=document.getElementsByName("a-product");
	for(var i in box){
		box[i].checked=flag;	
	}
	
}
function doDelete(id){
	 $.messager.confirm("确认删除", "您真的要删除该项？", function(r){
		if (r){
			$.post("fsp/deleteFsp.do?id="+id);
			$("#question"+id).remove();
			showMsgOnRightBottom("操作提示","删除成功！", 3000, "success");
				
			
		}
	});
}
function toAdd(){
	var left = (document.body.clientWidth-700)/2-100;
	var top = (document.body.clientHeight-450)/2;
	$("#dialog").css({"top":top, "left":left});
	$("#dialog").dialog({
		title: '新增编程题',    
	    width: 900,    
	    height: 460,    
	    closed: false,
	    cache: false,    
	    href: 'pages/question/program_add.jsp',    
	    modal: true  
	});
		
}

function toUpdate(id,techCateId){
	var left = (document.body.clientWidth-700)/2-100;
	var top = (document.body.clientHeight-450)/2;
	$("#dialog1").css({"top":top, "left":left});
	$("#dialog1").dialog({
		title: '更新编程题',    
	    width: 900,    
	    height: 460,    
	    closed: false,
	    cache: false,    
	    href: 'fsp/selectFspById2.do?id='+id + '&techCateId=' +techCateId ,    
	    modal: true  
	});
		
}

/* $(function(){
	//初始化试卷编号下拉列表
	$.get("exam/selectAll2.do",function(jsonList){
		var examNo = $("#examNoListDiv");
		
		//<input type="radio" name="selExamNo" value="d.examNo"/>
		$.each(jsonList, function(i,d){
			examNo.append("<li>"+"<input name='examMessage' type='radio' value='"+d.examNo+"' onclick='writeToBlank(this)'/>"+d.examNo+"&nbsp;&nbsp;&nbsp;"+d.examDate+"</li>");
		});
	
	},"json");
	
}); */

$(function(){
	$("#selExamNoBtn").click(function(){
		$(this).toggleClass(function(){
			if($(this).val()=="选择"){
				$("#examNoListDiv").css({display:"block"});
				$(this).val("隐藏");
			}else{
				$("#examNoListDiv").css({display:"none"});
				$(this).val("选择");
			}
		});
	});
});
//把radio的值填入文本框
function writeToBlank(id){
	var examNo = $(id).val();
	$("#examNo").val(examNo);
	$("#whBtn").css({display:"inline"});
}
//清空文本框
function resetValue(){
	$("#examNo").empty();
}
//执行ajax查询考卷状态
$(function(){
	$("#examBtn").click(function(){
		$("#tips").empty();
		var data = $("#examNo").val();
		if($.trim(data).length==0){
			$("#examNo")[0].focus();
			//$("#tips").append("请输入考卷编号！");
			showMsgBoxOnCenter("提示","请输入考卷编号！", 200,100,2000, "error");
		}
		else{
			$.get("examination/query.do",{examNo:data},function(result){
				if(result=="false"){
					//$("#tips").append("考卷不存在，请重新输入考卷编号！");
					showMsgBoxOnCenter("提示","考卷不存在，请重新输入考卷编号！", 300,100,2000, "error");
				}else{
					var ids=[];
					$("input[type='checkbox']").each(function(){
						if($(this).prop("checked")==true){
							ids.push($(this).val());
						}
					});
					if(ids.length==0){
						showMsgBoxOnCenter("提示","请选择试题！", 200,100,2000, "error");
					}else{
					
						$.get("exam/updateExamination.do?idCards="+ids,{type:"6",examNo:data},function(result){
							/* if(result=="false"){
								//$("#tips").append("试题添加成功！");
								showMsgBoxOnCenter("提示","试题添加成功！", 200,100,2000, "success");
							}else{
								//$("#tips").append("试题已存在！");
								showMsgBoxOnCenter("提示",result+"题已存在！", 200,100,2000, "error");
							} */
						if(result!=null && result!=""){
							var no=[];
							$.each(result,function(i,n){
								$("input[type='checkbox']").each(function(){
								
									if($(this).val()==n){
										no.push($(this).next().text());
										$("#question"+n).css("border","2px solid red");
										
									}
								});
							});
							//$("#tips").append("试题已存在！");
							
							showMsgBoxOnCenter("提示",no+"题已存在！", 200,100,2000, "error");
						}else{
							//$("#tips").append("试题添加成功！");
							showMsgBoxOnCenter("提示","试题添加成功！", 200,100,2000, "success");
						}
						},"json");
					}
				}
			},"text");
		}
	});
});

function kjwh(){
	var examno=$("#examNo").val();
	location.href="exam/selectExam.do?flag=1&examNo="+examno;
}
</script>

</head>
<body class="main_body" onload="prettyPrint()">
  <div class="button_bar" style="margin-left: 950px;width: 300;text-align: left;">
		<input type="button" class="button_b_b button_bar_btnText" onclick="toAdd()" value="新增简答题">
		<input type="button" id="whBtn" class="button_b_b button_bar_btnText" onclick="kjwh()" style="display: none;" value="维护考卷">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </div>
<form id="searchForm" name="searchForm" action="fsp/selectFspForPage.do?flag=2" method="post">
	<!-- 试题类型 -->
  	<input type="hidden" name="questionType" value="6"/>
  	<input type="hidden" name="catagoryId" />
  	<!-- 查询 -->
  	<input type="hidden" name="flag" value="0" />
  	<input type="hidden" name="coll_exp" value="0" />
  	
 <table border="0" width="100%">
  <tr>
	<td width="10px" rowspan="2"></td>
	<td>
	<fieldset>
		<legend>考卷出编程题查询</legend>
		<div id="searchDiv" style="margin-left:210px;">
		   	<span>
			   	<label>编程题题干：</label>
			   	<input type="text" name="question" value="" style="width:290px;" />&nbsp;(模糊查询)<br/><br/>
		   	</span>
		   	<div style="float:left;">
		   		<label><font color="red"><b>*&nbsp;</b></font>课程：</label><label id="catagoryError" class="catagoryMsg"></label><br/>
			   		<select id="courses" name="courses" size="7" style="width:290px;height: 120px;"></select>
		   	</div>
		  	<div style="float:left; margin-left: 5px;">
			  	<label><font color="red"><b>*&nbsp;</b></font>知识点：</label><label id="questCtgrError" class="catagoryMsg"></label><br/>
				  	<select id="category" name="techCateId" size="7" style="width:290px;color:black;height: 120px;"></select>
		  	</div>
		  	<div style="float:left;width:500px;"></div>
		   <div class="list-query-button">
			   <input id="sbm" type="submit" value="查询" class="button_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
			   <input type="reset" value="重置" class="button_h"/>
		   </div>
	  </div>
	</fieldset>
	</td>
	<td width="20px" rowspan="2"></td>
  </tr>
  <tr>
  	<td style="border: 0px solid gray;">
  		<!-- 列表 -->
  		<div class="listDiv">
		  <c:forEach var="fsp" items="${fspList }" varStatus="stat">
		  	<div id="question<c:out value="${fsp.id }"/>" class="radio_list" 
		  		style="width:100%;border:1px solid #A9A9AA;">
			  	<div class="radio_list_body">
			  		<input type="checkbox" name="a-product" value="${fsp.id }"/>
		  			<label style="color: black;">&nbsp;<c:out value="${stat.count }"/>.</label>
			  		<a id="questionBody" 
			  			href="javascript:showOptions('qo_<c:out value="${stat.count }"/>');">&nbsp;<c:out value="${fsp.question }"/></a>
			  	</div>
		  		<div id='qo_${stat.count }' class="sa_stdAnwser" style="display: none;">
				  	<font color="red" style="font-weight: bold;">参考答案：</font>
				  	<pre class="prettyprint linenums lang-*" style="padding-left:0px;margin:2px 0px;">${fsp.stdAnswer }</pre>
			  		<span>
				  		<input type="button" value="更新" 
				  			onclick="toUpdate(<c:out value="${fsp.id }"/>,<c:out value="${fsp.techCateId }"/>);"/>
				  		<input type="button" value="删除" onclick="doDelete(<c:out value="${fsp.id }"/>)" style="margin-right:20px;"/>
				  	</span>
			  	</div>
		  	</div>
		  	<br/>
		 </c:forEach>
		 <c:if test="${fspList!=null}">
	  	  <div class="pager" 
	  	  	style="width:100%;height:20px;border:1px solid #A9A9AA;line-height: 20px;vertical-align: middle;text-align: right; ">
				<p:page url="fsp/selectFspForPage.do?flag=2&questionType=5" page="${page}"/>
			
		  </div>
		</c:if>
		  	
		  	<c:if test="${fspList!=null and !fspList.isEmpty()}">
		  	<div class="add_exam">
		  		<a href="javascript:return false;" style="text-decoration:none;" title="全部展开/全部收起 选项">
		  			<span onclick="collapseExpand('.sa_stdAnwser');" class="collapse_expand">[+]</span>
		  		</a>
		  		<input name="a-product" type="checkbox" onclick="checkAll(this.checked);" value=""/>全选<br /><br />
		  		<label>考卷编号</label>
		  		<input type="text" id="examNo" name="examination.examNo" value="" 
		  			size="20" maxlength="14" title="如北京大学：PU1211201" cssStyle="font-size:11px;"/>
		  			<span id="tips" style="color:red;font-size:14px; font-style: italic;"></span>
		  		<input id="selExamNoBtn" type="button" value="选择" onclick="" style="font-size: 11px;"/>
		  		<font color="red"><b>*</b>（注：考点拼音简称2~6个大写字母+YYMMDD+1~2位班级号，如北京大学1班：PU1211201）</font><br />
		  		<!-- 显示试卷编号列表 -->
		  		<div id="examNoListDiv" style="display:none;margin-left:20px;">
		  			<ul class="listSelectItem">
		  			<c:forEach var="list" items="${sessionScope.examList }" varStatus="statu">
		  					<li style="font-size: 12px;">
		  						<input type="radio" name="examMessage" value="${list.examNo }" onclick="writeToBlank(this)"/>
		 						${list.examNo } &nbsp;&nbsp;
		  						<fmt:formatDate value="${list.examDate }" pattern="yyyy年MM月dd日"/>
		  					</li>
		  				</c:forEach>
		  			</ul>
		  		</div>
		  		<!-- 
		  		<label>考试日期:</label>
		  		<s:textfield name="examination.examDate" size="8" value="%{#session.ExamDate}" title="请选择考试日期"
		  			onclick="WdatePicker({readOnly:true})"/>（可选）
		  		 -->
		  		<input type="button" id="examBtn" name="addExam" class="btn_b_b button_bar_btnText" value="加入编程题" title="加入编程题到考卷" style="margin-left:30px;margin-top:5px;"/>
		  		<label id="addExamMsg"></label>
		  	</div>
		  	</c:if>
		  	<br />
	  </div>
  	</td>
  </tr>
 </table>
</form>
<div id="dialog"></div>
<div id="dialog1"></div>
</body>
</html>
