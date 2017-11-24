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
var questId = "";
$(function (){
	$('#tab2').datagrid({
		url:"<%=basePath %>manager.do?method=getQuestionInfo",
		fitColumns:true,
		singleSelect:true,
		pagination:true,
		pageSize:10,
		pageList:[10,20,40],
		rownumbers:true,//行号
		columns:[[
		          {field:'type',title:'题型',halign:'center',align:'center',width:20},
		          {field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
		          {field:'easyLevel',title:'难易程度',halign:'center',align:'center',width:20},
		          {field:'score',title:'占分',halign:'center',align:'center',width:20},
		          {field:'answer',title:'答案',halign:'center',align:'center',width:20},
		          {field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
		          ]],
	})
})
function formatter1(value,row){
	return "<a href='javascript:update("+row.questID+")'>修改</a>|<a href='javascript:deleteQues("+row.questID+")'>删除</a>";
}
function update(id){
	questId = id;
	$('#updateDialog').show();
	commUseDialog = $("#updateDialog").dialog({
        width: 450,
        height: 350,
        draggable: true,
        resizable: false,
        modal: true
    });
	$('#tab3').propertygrid({
		url:"<%=basePath %>manager.do?method=getUpdateQuestionInfo&questId="+id,
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
function deleteQues(id){
	$.ajax({
		url:'<%=basePath%>manager.do?method=delQuestion&qusid='+id,
		type:'post',
		dataType:'json',
		returnType:'json',
		success:function(r){
			if(r == "ok"){
				$('#tab2').datagrid('reload')
			}else{
				$.messager.alert('提示', '请重试');
			}
		}
	})
}
function search(){
	var type = $.trim($('#type').val());
	var mainContent = $.trim($('#mainContent').val()) ;
		$('#tab2').datagrid({
			url:"<%=basePath %>manager.do?method=getQuestionInfo&type="+encodeURI(encodeURI(type))+"&mainContent="+encodeURI(encodeURI(mainContent)),
			type:'post',
			fitColumns:true,
			singleSelect:true,
			pagination:true,
			pageSize:10,
			pageList:[10,20,40],
			rownumbers:true,//行号
			columns:[[
			          {field:'type',title:'题型',halign:'center',align:'center',width:20},
			          {field:'mainContent',title:'题干',halign:'center',align:'center',width:20},
			          {field:'easyLevel',title:'难易程度',halign:'center',align:'center',width:20},
			          {field:'score',title:'占分',halign:'center',align:'center',width:20},
			          {field:'answer',title:'答案',halign:'center',align:'center',width:20},
			          {field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
			          ]],
		})
}
function addQues(){
	window.parent.addTab('新增题目','<%=basePath %>manager.do?method=enterAddQuestionPage');
}
function uptQuest(){
	$.messager.confirm('确认','您确认想要修改题目吗？',function(r){    
	    if (r){    
	     	var s = '';
			var rows = $('#tab3').propertygrid('getRows');
			for(var i=0; i<rows.length; i++){
					s += '\"'+rows[i].eName + '\":\"' + rows[i].value + '\",';
			}
			if(s.length>0){
				s+='\"questId\":\"'+questId+'\"';
			}else{
				return false;
			}
			s="{"+s+"}";
			s = JSON.parse(s)
	    	$.ajax({
	    		url:'<%=basePath%>manager.do?method=updateQuestion',
	    		type:'post',
	    		dataType:'json',
	    		returnType:'json',
	    		data:s,
	    		success:function(r){
	    			if(r == "ok"){
	    				$.messager.alert('提示', '修改成功');
	    				$('#updateDialog').dialog('close');
	    				$('#tab2').datagrid('reload')
	    			}else{
	    				$.messager.alert('提示', '请重试');
	    			}
	    		}
	    	})
	    }    
	});  
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
	<div class="easyui-panel" title="题目信息维护"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div style="padding:5px;line-height: 30px">
				题型:<input type="text"  id="type" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入题型'"/>&nbsp;  
				题干:<input type="text"  id="mainContent" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入题干'"/>&nbsp;  
			<div style="float:right;">
				<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		        <a href="javascript:addQues();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">新增题目</a>  
			</div>
		</div>
		<div>
			<table id="tab2" width="100%" style="padding:5px;"></table>
		</div>
	</div>
	
	<div id="updateDialog" style="display: none;" title="修改题目信息">
		<table id="tab3" width="100%" style="padding:5px;"></table>
		<br>
		<div align="center">
		        <a href="javascript:uptQuest();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">修改题目</a>  
			</div>
	</div>
</body>
</html>