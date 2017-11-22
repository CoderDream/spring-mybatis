<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>题库</title>
<script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script type="text/javascript">
$(function (){
	$('#tab2').datagrid({
		url:"<%=basePath %>student.do?method=getStudentWrongQuestInfo",
		fitColumns:true,
		singleSelect:true,
		pagination:true,
		pageSize:10,
		pageList:[10,20,40],
		rownumbers:true,//行号
		columns:[[
		          {field:'paperName',title:'试卷名',halign:'center',align:'center',width:20},
		          {field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
		          {field:'score',title:'题目占分',halign:'center',align:'center',width:20},
		          {field:'myAnswer',title:'你的答案',halign:'center',align:'center',width:20},
		          {field:'answer',title:'正确答案',halign:'center',align:'center',width:20},
		          {field:'byUser',title:'出卷人',halign:'center',align:'center',width:20},
		          {field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
		          ]]
	})
})
function formatter1(value,row){
	return "<a href=javascript:lookQuest('"+row.questID+"')>查看题目</a>";
}
function lookQuest(id){
	$('#updateDialog').show();
	$('#updateDialog').dialog({
		 width: 450,
        height: 350,
        draggable: true,
        resizable: false,
        modal: true
	})
	$('#tab3').propertygrid({
		url:"<%=basePath %>manager.do?method=getUpdateQuestionInfo&pageName=wrong&questId="+id,
		fitColumns:true,
		singleSelect:true,
		showGroup:false,
		rownumbers:true,//行号
		columns:[[
		          {field:'name',title:'属性',halign:'center',align:'center',width:20},
		          {field:'value',title:'数据',halign:'center',align:'center',width:20},
		          ]],
	})
}
function search(){
	var paperName = $.trim($('#paperName').val());
	var mainContent = $.trim($('#mainContent').val()) ;
		$('#tab2').datagrid({
			url:"<%=basePath %>student.do?method=getStudentWrongQuestInfo&mainContent="+encodeURI(encodeURI(mainContent))+"&paperName="+encodeURI(encodeURI(paperName)),
			type:'post',
			fitColumns:true,
			singleSelect:true,
			pagination:true,
			pageSize:10,
			pageList:[10,20,40],
			rownumbers:true,//行号
			columns:[[
					{field:'paperName',title:'试卷名',halign:'center',align:'center',width:20},
					{field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
					{field:'score',title:'题目占分',halign:'center',align:'center',width:20},
					{field:'myAnswer',title:'你的答案',halign:'center',align:'center',width:20},
					{field:'answer',title:'正确答案',halign:'center',align:'center',width:20},
					{field:'byUser',title:'出卷人',halign:'center',align:'center',width:20},
					{field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
					]],
		})
}
</script>
<style type="text/css">
.abody{
	position: absolute;
	left: 0;top: 0;bottom: 0;right: 0;
}
a{
	text-decoration:none;
}
.panel_title_1 div{
	font-size:15px;
	text-align:center;
	color:red;
	font-weigh:10px;
	padding:1px;
}

.panel_text div{
	vertical-align:middle;
	line-height:100px;
	text-align:center;
}
.combo-panel {
  height:60px;
  overflow: auto;
}
</style>
</head>
<body class="abody">
	<div class="easyui-panel" title="错题浏览"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div style="padding:5px;line-height: 30px">
				试卷名:<input type="text"  id="paperName" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入试卷名'"/>&nbsp;  
				题干:<input type="text"  id="mainContent" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入题干'"/>&nbsp;  
			<div style="float:right;">
				<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			</div>
		</div>
		<div>
			<table id="tab2" width="100%" style="padding:5px;"></table>
		</div>
	</div>
	
	<div id="updateDialog" style="display: none;" title="题目信息">
		<table id="tab3" width="100%" style="padding:5px;"></table>
		<br>
	</div>
</body>
</html>