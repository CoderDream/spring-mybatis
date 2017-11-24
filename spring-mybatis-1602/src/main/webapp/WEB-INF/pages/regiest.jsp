<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
	<script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
	<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body style="background-image: url('images/bg.jpg');">
<div id="loginWindow" class="easyui-window" title="注册窗口" data-options="iconCls:'icon-vixtel'" style="width:320px;height:320px;padding:5px;background: #fafafa;">
	<br>
	<div border="false" style=" padding-left:50px; border:0px solid #ccc;">
        <form>
            <table>
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
                           style="width:100%;height:30px;padding:12px" data-options="prompt:'学号',iconWidth:38"/>
                    </td>
                </tr>
            </table>
        </form>
	</div>
	<div border="false" style="text-align:left;height:30px;line-height:30px; margin-top:6px;">
		<div style="padding-left:57px;">
			<a class="easyui-linkbutton"  style="width:90px;" href="javascript:login()" id="regis">登陆</a>
			<a class="easyui-linkbutton"  style="width:90px;" href="javascript:regist()" id="regis">注册</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	function regist(){
		if($.trim($('#realname').val())==''||$.trim($('#username').val())==''||$.trim($('#tel').val())==''||$.trim($('#password').val())==''||$.trim($('#cla').val())==''||$.trim($('#num').val())==''){
			$.messager.alert('提示', '请输入全部信息');
		}else{
			$.ajax({
				url:'<%=basePath%>login.do?method=regist',
				dataType:'json',
				returnType:'json',
				type:'post',
				data:{username:$.trim($('#username').val()),realname:$.trim($('#realname').val()),tel:$.trim($('#tel').val()),num:$.trim($('#num').val()),cla:$.trim($('#cla').val()),password:$.trim($('#password').val())},
				success:function(result){
					if(result == 'ok'){
						location.href = "login.do?method=enterLoginPage";
					}
					if(result == 'no'){
						$.messager.alert('提示', '已存在此用户');
					}
					if(result == 'error'){
						$.messager.alert('提示', '出错了');
					}
				}
			})
		}
	}
	function login(){
		return window.location.href = "login.do?method=enterLoginPage";
	}
</script>
</body>
</html>