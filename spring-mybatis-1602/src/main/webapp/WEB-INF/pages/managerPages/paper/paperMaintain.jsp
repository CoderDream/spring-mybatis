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
var paperId = '${paperId}';
var addId = ''
var delId = ''
$(function (){
	$('#tab2').propertygrid({
		url:"<%=basePath %>paper.do?method=getUpdatePaperInfo&paperId="+paperId,
		fitColumns:true,
		singleSelect:true,
		showGroup:false,
		rownumbers:true,//行号
		columns:[[
		          {field:'name',title:'属性',halign:'center',align:'center',width:20},
		          {field:'value',title:'数据',halign:'center',align:'center',width:20},
		          ]],
	})
	 $('#tab3').datagrid({
		url:"<%=basePath %>paper.do?method=getUpdatePaperDetailInfo&paperId="+paperId,
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
			delId = row.questID
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
				addId = row.questID
			}
		}) 
})
function addPaperQuest(){
	if(addId == null || addId == ''){
		$.messager.alert('提示','请选中右侧表格中一行')
	}else{
		console.log(addId)
		$.ajax({
			url:'<%=basePath%>paper.do?method=addPaperQuest&paperId='+paperId+'&questId='+addId,
			type:'post',
			dataType:'json',
			returnType:'json',
			success:function(r){
				if(r == "ok"){
					$('#tab3').datagrid('reload')
				}else{
					$.messager.alert('提示', '请重试');
				}
			}
		})
	}
}
function delPaperQuest(){
	if(delId == null || delId == ''){
		$.messager.alert('提示','请选中左侧表格中一行')
	}else{
		$.ajax({
			url:'<%=basePath%>paper.do?method=delPaperQuest&paperId='+paperId+'&questId='+delId,
			type:'post',
			dataType:'json',
			returnType:'json',
			success:function(r){
				if(r == "ok"){
					$('#tab3').datagrid('reload')
				}else{
					$.messager.alert('提示', '请重试');
				}
			}
		})
	}
}
function updatePaperInfo(){
	var rows = $('#tab2').propertygrid("getRows")
	$.ajax({
			url:'<%=basePath%>paper.do?method=updatePaperInfo&paperId='+paperId,
			type:'post',
			dataType:'json',
			returnType:'json',
			data:{paperName:rows[0].value,fullScore:rows[1].value,validateTime:rows[3].value},
			success:function(r){
				if(r == "ok"){
					$('#tab2').datagrid('reload')
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
	<div class="easyui-panel" title="试卷信息维护"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div>
			<table id="tab2" width="100%" style="padding:5px;"></table>
		</div>
		<div align="center">
		        <a href="javascript:updatePaperInfo();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">修改信息</a>  
			</div> 
	</div>
	
	<div class="easyui-panel" title="试卷题目维护"  data-options="headerCls:'panel_title_1',collapsible:false">
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
			</div>
	</div>
	
</body>
</html>