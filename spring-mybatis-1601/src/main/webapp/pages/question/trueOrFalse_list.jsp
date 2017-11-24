<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="${basePath}"/>
    <title>考卷出判断题</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
<script type="text/javascript">

</script>

</head>
<body class="main_body">
  <div class="button_bar">
		<button class="button_b_b button_bar_btnText" onclick="to('${basePath}secure/forward.action?target=trueOrFalseInput');">继续新增</button>
	<s:if test="#parameters.examNo!=null">
		<button class="button_b_b button_bar_btnText" onclick="to('${basePath}secure/examination!buildExamination.action?examNo=${param.examNo}&doFlag=1');">维护考卷</button>
	</s:if>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </div>
<form id="tfSearchForm" name="tfSearchForm" action="secure/trueOrFalseQuestion!findByPage.action" method="post">
  	<s:hidden name="questType" value="3"/>
  	<s:hidden name="catagoryId" />
  	<!-- 查询 -->
    <s:hidden name="flag" value="0" />
 <table border="0" width="100%">
  <tr>
	<td width="15px" rowspan="2"></td>
	<td>
	<fieldset>
		<legend>考卷出判断题查询</legend>
		<div id="searchDiv" style="margin-left:210px;">
		   	<span>
			   	<label><s:text name="title.trueOfFalse.body"/></label>
			   	<input type="text" name="question" value="<s:property value="myQuestion"/>" style="width:290px;" />&nbsp;(模糊查询)<br/><br/>
		   	</span>
		   	<div style="float:left;">
		   		<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.catagory"/></label><label id="catagoryError" class="catagoryMsg"></label><br/>
		   		<s:if test="catagoryList==null || catagoryList.size()==0">
			   		<select id="catagory" name="catagory" size="7" style="width:290px;"></select>
		   		</s:if>
		   		<s:else>
		   			<s:select id="catagory" name="catagory" list="catagoryList" value="%{catagoryId}" 
			  			listKey="id" listValue="catagory" size="7" cssStyle="width:290px;">
			  		</s:select>
		   		</s:else>
		   	</div>
		  	<div style="float:left; margin-left: 5px;">
			  	<label><font color="red"><b>*&nbsp;</b></font><s:text name="title.questCatagory"/></label><label id="questCtgrError" class="catagoryMsg"></label><br/>
			  	<s:if test="questCtgrList==null || questCtgrList.size()==0">
				  	<select id="quest_Catagory" name="questCatagory.id" size="7" style="width:290px;color:black;"></select>
			  	</s:if>
			  	<s:else>
			  		<s:select id="quest_Catagory" name="questCatagory.id" list="questCtgrList" value="%{questCatagory.id}" 
			  		 	listKey="id" listValue="techCatagory" size="7" cssStyle="width:290px;color:black;">
			  		</s:select>
			  	</s:else>
			  	
		  	</div>
		  	<div style="float:left;width:500px;"></div>
		   <div class="list-query-button">
			   <input id="queryBtn" type="submit" value="查询" class="button_b"/>&nbsp;&nbsp;&nbsp;&nbsp;
			   <s:reset value="重置" cssClass="button_h"></s:reset>
		   </div>
	  </div>
	</fieldset>
	</td>
	<td width="20px" rowspan="2"></td>
  </tr>
  <tr>
  	<td style="border: 1px solid gray;">
  		<!-- 列表 -->
  		<div class="listDiv">
		  <s:iterator value="trueOrFalseList" status="stat">
		  	<div id="question<s:property value="id"/>" class="radio_list">
			  	<div class="radio_list_body">
			  		<input type="checkbox" name="selectedNos" value="<s:property value="id"/>"/>
		  			<label style="color: black;">&nbsp;<s:property value="#stat.count"/>.</label>
			  		<a id="questionBody" 
			  			href="javascript:showOptions('qo_<s:property value="#stat.count"/>');">&nbsp;<s:property value="question"/></a>
			  	</div>
			  	<div>
				  	<span class="answer">答案：<s:property value="correct==\"T\"?\"正确\":\"错误\""/></span>
				  	<span style="margin-left:20px;">
				  		<input type="button" value="更新" class="rmdListData_button"
				  			onclick="location.href='secure/trueOrFalseQuestion!findById.action?id=<s:property value="id"/>&catagoryId=<s:property value="questCatagory.catagory.id"/>';"/>
				  		<input type="button" value="删除" onclick='doDelete(<s:property value="id"/>);'  class="rmdListData_button"/>&nbsp;&nbsp;
				  	</span>
			  	</div>
		  	</div>
		  </s:iterator>
		  
		  <s:if test="trueOrFalseList!=null && !trueOrFalseList.isEmpty()">
		  	<div class="add_exam">
		  		<input type="checkbox" onclick="checkAll(this,'selectedNos');"/>全选<br /><br />
		  		<label><s:text name="title.examno"/></label>
		  		<s:textfield id="examNo" name="examination.examNo" value="%{#session.ExamNo}" 
		  			size="20" maxlength="14" title="请输入或选择编号" cssStyle="font-size:11px;"/>
		  		<input id="selExamNoBtn" type="button" value="选择" onclick="selectExamNo();" class="rmdListData_button"/>
		  		<font color="red"><b>*</b><s:text name="prompt.examno"/></font><br />
		  		<!-- 显示试卷编号列表 -->
		  		<div id="examNoListDiv" style="display:none;">
		  			<ul class="listSelectItem"></ul>
		  		</div>
		  		<!-- 
		  		<label>考试日期:</label>
		  		<s:textfield name="examination.examDate" value="%{#session.ExamDate}" size="8" 
		  			onclick="WdatePicker({readOnly:true})" title="请选择考试日期"/>（可选）
		  		 -->
		  		<input type="button" id="addExam" name="addExam"
		  			class="btn_b_b button_bar_btnText" value="加入判断题" title="加入判断题到考卷" style="margin-left:30px;margin-top:5px;"/>
		  		<label id="addExamMsg"></label>
		  	</div>
		  </s:if>
		  	<br />
	  </div>
  	  <!-- 分页 -->
  	  <div class="pager">

	  </div>
  	</td>
  </tr>
 </table>

</form>
</body>
</html>
