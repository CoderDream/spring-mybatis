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
var oldOptID = ''
$(function (){
	$('#tab2').datagrid({
		url:"<%=basePath %>manager.do?method=getAccountInfo",
		fitColumns:true,
		singleSelect:true,
		pagination:true,
		pageSize:10,
		pageList:[10,20,40],
		rownumbers:true,//行号
		columns:[[
				{field:'optID',title:'账号',halign:'center',align:'center',width:20},
				{field:'optName',title:'姓名',halign:'center',align:'center',width:20},
				{field:'isAdmin',title:'身份',halign:'center',align:'center',width:20},
				{field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
				]],
	})
})
function formatter1(value,row){
	return "<a href=javascript:update('"+row.optID+"','"+row.oldOptID+"')>修改</a>|<a href=javascript:deleteAccount('"+row.optID+"')>删除</a>";
}
function update(id,oldid){
	oldOptID = oldid
	$('#updateDialog').show();
	commUseDialog = $("#updateDialog").dialog({
        width: 430,
        height: 300,
        draggable: true,
        resizable: false,
        modal: true
    });
	$('#tab3').propertygrid({
		url:"<%=basePath %>manager.do?method=getUpdateAccountInfo&optID="+encodeURI(encodeURI(id)),
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
function deleteAccount(id){
	$.ajax({
		url:'<%=basePath%>manager.do?method=delAccount&optID='+id,
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
	var optID = $.trim($('#optID').val());
	var optName = $.trim($('#optName').val()) ;
		$('#tab2').datagrid({
			url:"<%=basePath %>manager.do?method=getAccountInfo&optID="+encodeURI(encodeURI(optID))+"&optName="+encodeURI(encodeURI(optName)),
			type:'post',
			fitColumns:true,
			singleSelect:true,
			pagination:true,
			pageSize:10,
			pageList:[10,20,40],
			rownumbers:true,//行号
			columns:[[
					{field:'optID',title:'账号',halign:'center',align:'center',width:20},
					{field:'optName',title:'姓名',halign:'center',align:'center',width:20},
					{field:'isAdmin',title:'身份',halign:'center',align:'center',width:20},
					{field:'caozuo',title:'操作',halign:'center',align:'center',width:20,formatter:formatter1}
					]],
		})
}
function showAddAccountDialog(){
	$('#addAccountDialog').show();
	commUseDialog = $("#addAccountDialog").dialog({
        width: 450,
        height: 350,
        draggable: true,
        resizable: false,
        modal: true
    });
}
function addAccount(){
	var name = $("#username").val()	
	var pwd = $("#password").val()	
	var realname = $("#realname").val()	
	var cla = $("#cla").val()	
	var num = $("#num").val()	
	var tel = $("#tel").val()	
	var isAdmin = $("#isAdmin").val()	
	if(name == null || name == '' ||pwd == null || pwd == '' || isAdmin == null || isAdmin == ''){
		$.messager.alert('提示','账号、密码、身份不可为空')
	}	else{
		$.ajax({
			url:'<%=basePath%>manager.do?method=addAccount',
			type:'post',
			dataType:'json',
			returnType:'json',
			data:{username:name,password:pwd,isAdmin:isAdmin,cla:cla,num:num,tel:tel,realname:realname},
			success:function(r){
				if(r == "ok"){
					$('#tab2').datagrid('reload');
					$('#addAccountDialog').dialog('close');
				}else{
					$.messager.alert('提示', '已存在此用户');
				}
			}
		})
	}
}
function uptAccount(){
	$.messager.confirm('确认','您确认想要修改账号信息吗？',function(r){    
	    if (r){    
	     	var s = '';
			var rows = $('#tab3').propertygrid('getRows');
			for(var i=0; i<rows.length; i++){
					s += '\"'+rows[i].eName + '\":\"' + rows[i].value + '\",';
			}
			if(s.length>0){
				s+='\"oldOptID\":\"'+oldOptID+'\"';
			}else{
				return false;
			}
			s="{"+s+"}";
			s = JSON.parse(s)
	    	$.ajax({
	    		url:'<%=basePath%>manager.do?method=updateAccount',
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
	    				$.messager.alert('提示', '已存在此用户');
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
	<div class="easyui-panel" title="账号信息维护"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div style="padding:5px;line-height: 30px">
				账号:<input type="text"  id="optID" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入账号'"/>&nbsp;  
				名字:<input type="text"  id="optName" class="easyui-textbox" value="" size=20 data-options="prompt:'请输入登录名'"/>&nbsp;  
			<div style="float:right;">
				<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		        <a href="javascript:showAddAccountDialog();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">新增账号</a>  
			</div>
		</div>
		<div>
			<table id="tab2" width="100%" style="padding:5px;"></table>
		</div>
	</div>
	
	<div id="updateDialog" style="display: none;" title="修改账号信息">
		<table id="tab3" width="100%" style="padding:5px;"></table>
		<br>
		<div align="center">
		        <a href="javascript:uptAccount();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">修改</a>  
			</div>
	</div>
	
	
	
	<div id="addAccountDialog" style="display: none;" title="添加账号信息">
			 <table id="addTable" align="center" style="padding-top:20px">
                <tr>
                    <td>
                    <input class="easyui-textbox" id="username" style="width:100%;height:30px;padding:12px" 
                           data-options="prompt:'账号',iconWidth:38"/>
                    </td>
                </tr>
                 <tr>
                    <td>
                    <input class="easyui-textbox" type="password" id="password"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'密码',iconWidth:38"/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <input class="easyui-textbox" id="realname" style="width:100%;height:30px;padding:12px" 
                           data-options="prompt:'姓名',iconWidth:38"/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <input class="easyui-textbox" id="isAdmin" style="width:100%;height:30px;padding:12px" 
                           data-options="prompt:'身份 1:管理员 0:学生 2:老师',iconWidth:38"/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <input class="easyui-textbox"  id="cla"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'班级',iconWidth:38"/>
                    </td>
                </tr>
                 <tr>
                    <td>
                    <input class="easyui-numberbox"  id="tel"
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'手机号',iconWidth:38"/>
                    </td>
                </tr>
                 <tr>
                    <td>
                    <input class="easyui-numberbox"  id="num"
                           style="width:350px;height:30px;padding:12px" data-options="prompt:'学号',iconWidth:38"/>
                    </td>
                </tr>
            </table>
            <div align="center">
		        <a href="javascript:addAccount();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">添加账号</a>  
			</div>
	</div>
	
</body>
</html>