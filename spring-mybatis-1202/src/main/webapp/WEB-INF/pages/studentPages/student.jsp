<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>学生自助页面</title>
   <script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
	<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
  
  <body class="easyui-layout">   
    <div data-options="region:'north',split:true" style="height:100px;">
    	<span style="font-size: 70px;padding-top: 15px;padding-left: 400px">网上在线考试平台</span>
    </div>   
    <div data-options="region:'west',split:true" style="width:200px;">
    	<ul id="tt"></ul>
    </div>   
    <div id="mainPanle" data-options="region:'center'," style="padding:5px;background:#eee;">
    	<div id="tabs"  class="easyui-tabs" fit="true" border="false"></div>
    </div>   
</body>  
<script type="text/javascript">
	$(function(){
		$('#tt').tree({
			onClick: function (node) { 
				if(node.text == '退出系统'){
					window.location.href = "login.do?method=enterLoginPage";
				}
		        if (!node.children && node.text != '退出系统'){
		            addTab(node.text,node.url);
		        }
		    },
			data: [{
				text: '考生自助管理',
				state: 'open',
				children: [{
					"iconCls":"icon-edit",    
					text: '参加考试',
					url:'<%=basePath%>/student.do?method=goTest'
				},{
					"iconCls":"icon-edit",    
					text: '过期考试浏览',
					url:'<%=basePath%>/student.do?method=allPapers'
				},{
					"iconCls":"icon-edit",    
					text: '已完成考试',
					url:'<%=basePath%>/student.do?method=gotoExamDonePage'
				},{
					"iconCls":"icon-edit",    
					text: '错题浏览',
					url:'<%=basePath%>/student.do?method=gotoWrongQuestionsPage'
				},{
					"iconCls":"icon-edit",    
					text: '退出系统',
				}]
			}]
		});
		
	})
	
	function addTab(subtitle,url){
		 if (!$('#tabs').tabs('exists', subtitle)) {
		        $('#tabs').tabs('add', {
		            title: subtitle,
		            content: createFrame(url),
		            closable: true,
		            width: $('#mainPanle').width() - 10,
		            height: $('#mainPanle').height() - 26
		        });
		    } else {
		        $('#tabs').tabs('select', subtitle);
		    }
	}
	function closeTab(title){
		if(title == '新增试卷'){
			$.messager.alert('提示','新增试卷成功')
		}
		 $('#tabs').tabs('close',title);
	}
	function createFrame(url) {
	    var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
	    return s;
	}
</script>
</html>
