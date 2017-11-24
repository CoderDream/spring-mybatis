<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增题目</title>
<script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script type="text/javascript">
var cityid = "${cityId}";
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
function formatter1(){
	return "d";
}
function search(){
	var type = $.trim($('#type').val());
	var mainContent = $.trim($('#mainContent').val()) ;
		$('#tab2').datagrid({
			url:"<%=basePath %>manager.do?method=getQuestionInfo&type="+type+"&mainContent="+mainContent,
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
	var type = $.trim($('#type').val())
	var mainContent = $.trim($('#mainContent').val())
	var easyLevel = $.trim($('#easyLevel').val())
	var score = $.trim($('#score').val())
	var answer = $.trim($('#answer').val())
	var A = $.trim($('#A').val())
	var B = $.trim($('#B').val())
	var C = $.trim($('#C').val())
	var D = $.trim($('#D').val())
	if(type != null && type != '' && mainContent != null && mainContent != '' && score != null && score != '' && easyLevel != null && easyLevel != '' && answer != null && answer != '' && A != null && A != '' && B != null && B != '' && C != null && C != '' && D != null && D != ''){
		$.ajax({
			url:'<%=basePath%>manager.do?method=addQuestion',
			dataType:'json',
			returnType:'json',
			type:'post',
			data:{type:type,mainContent:mainContent,easyLevel:easyLevel,score:score,answer:answer,A:A,B:B,C:C,D:D},
			success:function(result){
				if(result == 'ok'){
					
					window.parent.closeTab('新增题目')
				}else{
					$.messager.alert('提示', '保存失败');
				}
			}
		})
	}else{
		$.messager.alert('提示', '请将信息填写完整');
	}
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
	<div class="easyui-panel" title="新增题目"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div style="padding:5px;line-height: 30px" align="center">
		<table>
                  <tr>
                    <td>
                    题型:<input class="easyui-textbox"  id="type"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入题型',iconWidth:38"/>
                    </td>
                </tr>
                  <tr>
                    <td>
                    题干:<input class="easyui-textbox"  id="mainContent"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入题干',iconWidth:38"/>
                    </td>
                </tr>
                  <tr>
                    <td>
                    占分:<input class="easyui-numberbox"  id="score"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入占分',iconWidth:38"/>
                    </td>
                </tr>
                  <tr>
                    <td>
                    难易程度:<input class="easyui-textbox"  id="easyLevel"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入难易程度(简单，一般，困难)',iconWidth:38"/>
                    </td>
                </tr>
                 <tr>
                    <td>
                    选项A:<input class="easyui-textbox"  id="A"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入选项A',iconWidth:38"/>
                    </td>
                </tr> 
                <tr>
                    <td>
                    选项B:<input class="easyui-textbox"  id="B"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入选项B',iconWidth:38"/>
                    </td>
                </tr> 
                <tr>
                    <td>
                    选项C:<input class="easyui-textbox"  id="C"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入选项C',iconWidth:38"/>
                    </td>
                </tr> 
                <tr>
                    <td>
                    选项D:<input class="easyui-textbox"  id="D"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入选项D',iconWidth:38"/>
                    </td>
                </tr>
                <tr>
                    <td>
                    答案:<input class="easyui-textbox"  id="answer"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'请输入答案',iconWidth:38"/>
                    </td>
                </tr>
            </table>
			</div>
			<div align="center">
		        <a href="javascript:addQues();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">添加题目</a>  
			</div>
		</div>
</body>
</html>