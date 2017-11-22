<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>试卷维护</title>
<script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script type="text/javascript">
var rows = null
var tab3Index = null
var showArray = new Array();
var questIdArray = new Array();
$(function (){
	var data = [{"name":"试卷名","value":"-","editor":"text","eName":"paperName"},
				{"name":"满分","value":"-","editor":"text","eName":"fullScore"},
				{"name":"做卷时间(小时)","value":"-","editor":"text","eName":"validateTime"},
				{"name":"出卷人","value":"-","editor":"text","eName":"byUser"}]
	$('#tab2').propertygrid({
		fitColumns:true,
		singleSelect:true,
		showGroup:false,
		rownumbers:true,//行号
		columns:[[
		          {field:'name',title:'属性',halign:'center',align:'center',width:20},
		          {field:'value',title:'数据',halign:'center',align:'center',width:20},
		          ]],
	})
	$('#tab2').propertygrid('loadData', data); //将数据绑定到datagrid 
	
	
	 $('#tab3').datagrid({
		fitColumns:true,
		singleSelect:true,
		rownumbers:true,//行号
		columns:[[
		          {field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
		          {field:'type',title:'题型',halign:'center',align:'center',width:20},
		          {field:'easyLevel',title:'难易程度',halign:'center',align:'center',width:20},
		          {field:'score',title:'占分',halign:'center',align:'center',width:20},
		          {field:'questId',title:'题目Id',halign:'center',align:'center',width:20,hidden:true},
		          ]],
					onClickRow:function (index,row){
						tab3Index = index
					}
	}) 
	 $('#tab4').datagrid({
			url:"<%=basePath %>paper.do?method=getUpdatePaperDetailInfo",
			fitColumns:true,
			singleSelect:true,
			rownumbers:true,//行号
			columns:[[
			          {field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
			          {field:'type',title:'题型',halign:'center',align:'center',width:20},
			          {field:'easyLevel',title:'难易程度',halign:'center',align:'center',width:20},
			          {field:'score',title:'占分',halign:'center',align:'center',width:20},
			          ]],
			onClickRow:function (index,row){
				rows = row
			}
		}) 
})
function addPaperQuest(){
	if(rows == null || rows == ''){
		$.messager.alert('提示','请选中右侧表格中一行')
	}else{
		showArray.push(rows)
		questIdArray.push(rows.questID)
		$('#tab3').propertygrid('loadData', showArray);
	}
}
function delPaperQuest(){
	if(tab3Index == null ){
		$.messager.alert('提示','请选中左侧表格中一行')
	}else{
		showArray.splice(tab3Index,1)
		questIdArray.splice(tab3Index,1)
		$('#tab3').propertygrid('loadData', showArray);
	}
}
function savePaper(){
	var rows2 = $('#tab2').propertygrid("getRows")
	if(rows2[0].value == '-'){
		$.messager.alert('错误','请输入试卷名')
		return false;
	}
	if(rows2[3].value == '-'){
		$.messager.alert('错误','请输入出卷人')
		return false;
	}
	var s = ''
	for(var i = 0;i<rows2.length;i++){
		s += '\"'+rows2[i].eName + '\":\"' + rows2[i].value + '\",';
	}
	var i = 0;
	for(;i<questIdArray.length;i++){
		s += '\"questId'+(i+1) + '\":\"' + questIdArray[i] + '\",';
	}
	s += '\"questIdCount\":\"' + i + '\"';
	s = "{"+s+"}"
	s = JSON.parse(s)
	 $.ajax({
			url:'<%=basePath%>paper.do?method=addPaper',
			type:'post',
			dataType:'json',
			returnType:'json',
			data:s,
			success:function(r){
				if(r == "ok"){
					window.parent.closeTab('新增试卷')
				}else{
					$.messager.alert('提示', '请重试');
				}
			}
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
	<div class="easyui-panel" title="试卷信息"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div>
			<table id="tab2" width="100%" style="padding:5px;"></table>
		</div>
	</div>
	
	<div class="easyui-panel" title="试卷题目"  data-options="headerCls:'panel_title_1',collapsible:false">
			<div id="cc" class="easyui-layout" data-options="fit:true,collapsible:false,minHeight:200">   
			    <div data-options="headerCls:'panel_title_1',collapsible:false,region:'east',title:'全部试题',split:true" style="width:50%;">
			    	<table id="tab4" width="100%" style="padding:5px;"></table>
			    </div>   
			    <div data-options="headerCls:'panel_title_1',collapsible:false,region:'center',title:'已有试题'" style="padding:5px;background:#eee;">
			    	<table id="tab3" width="100%" style="padding:5px;"></table>
			    </div>   
			</div>  
		<div align="center">
		        <a href="javascript:addPaperQuest();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">增加试题</a>  
		        <a href="javascript:delPaperQuest();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">删除试题</a>  
		        <a href="javascript:savePaper();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">保存试卷</a>  
			</div>
	</div>
	
</body>
</html>