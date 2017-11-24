<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>答卷页</title>
<script src="<%=basePath %>res/easyui/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath %>res/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=basePath %>res/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>res/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>res/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<style type="text/css">
	td:hover{
		background-color:#C4C4C4;
	}
</style>
<script type="text/javascript">
var paperId = '${paperId}'
var validateTime = '${validateTime}'
var r1 = '';
var ii = '';
var trueName = '${trueName}'
$(function (){
	$.ajax({
		url:'<%=basePath%>/student.do?method=getTestInfo&paperId='+paperId,
		type:'post',
		dataType:'json',
		returnType:'json',
		success:function(r){
			r1 = r;
			for(var i = 0;i<r.length;i++){
				ii = i + 1;
				if(trueName != null && '' != trueName && trueName != undefined){
					if(r[i].answer == 'A' ){
						$('#ol').append("<li ><span style='font-size: 20px;font-family: -webkit-pictograph;'>"+r[i].mainContent+"(分数:"+r[i].score+")</span>"+
								"<table style='width: 100%;height: 100%;'>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=A checked=checked>A:"+r[i].A+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=B>B:"+r[i].B+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=C>C:"+r[i].C+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=D>D:"+r[i].D+"</td></tr></table>"+
								"</li>")
					} 
					if(r[i].answer == 'B'){
						$('#ol').append("<li ><span style='font-size: 20px;font-family: -webkit-pictograph;'>"+r[i].mainContent+"(分数:"+r[i].score+")</span>"+
								"<table style='width: 100%;height: 100%;'>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=A>A:"+r[i].A+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=B checked=checked>B:"+r[i].B+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=C>C:"+r[i].C+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=D>D:"+r[i].D+"</td></tr></table>"+
								"</li>")
					} 
					if(r[i].answer == 'C'){
						$('#ol').append("<li ><span style='font-size: 20px;font-family: -webkit-pictograph;'>"+r[i].mainContent+"(分数:"+r[i].score+")</span>"+
								"<table style='width: 100%;height: 100%;'>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=A>A:"+r[i].A+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=B>B:"+r[i].B+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=C checked=checked>C:"+r[i].C+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=D>D:"+r[i].D+"</td></tr></table>"+
								"</li>")
					}
					if(r[i].answer == 'D'){
						$('#ol').append("<li ><span style='font-size: 20px;font-family: -webkit-pictograph;'>"+r[i].mainContent+"(分数:"+r[i].score+")</span>"+
								"<table style='width: 100%;height: 100%;'>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=A>A:"+r[i].A+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=B>B:"+r[i].B+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=C>C:"+r[i].C+"</td></tr>"+
								"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=D checked=checked>D:"+r[i].D+"</td></tr></table>"+
								"</li>")
					}
				}else{
					$('#ol').append("<li ><span style='font-size: 20px;font-family: -webkit-pictograph;'>"+r[i].mainContent+"(分数:"+r[i].score+")</span>"+
							"<table style='width: 100%;height: 100%;'>"+
							"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=A>A:"+r[i].A+"</td></tr>"+
							"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=B>B:"+r[i].B+"</td></tr>"+
							"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=C>C:"+r[i].C+"</td></tr>"+
							"<tr style='width: 1300px;' ><td style='width: 1300px;height:30px'><input type=radio name="+i+" value=D>D:"+r[i].D+"</td></tr></table>"+
							"</li>")
				}
			}
		}
	})
	
})
var answerArray = new Array();
function submitPaper(){
	for(var i = 0;i<ii;i++){
		r1[i].easyLevel = ($("input[name="+i+"]:checked").val())==undefined?"none":($("input[name="+i+"]:checked").val())
	}
	$.ajax({
		url:'<%=basePath%>/student.do?method=maskPaper&paperId='+paperId,
		type:'post',
		dataType:'json',
		returnType:'json',
		traditional:true,
		data:{"rr":JSON.stringify(r1)},
		success:function(t){
			window.close();
		}
	})
}
/* function chooseCheckbox(){
	$("input[name=1]").attr("checked", true);
} */
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
	<div class="easyui-panel" title="试卷名：${paperName}"  data-options="headerCls:'panel_title_1',collapsible:false">
		<div>
			<ol id="ol"></ol>
		</div>
		<%
			if(request.getAttribute("trueName") == null || "".equals(request.getAttribute("trueName"))){
				%>
				 <div align="center">
				        <a href="javascript:submitPaper();" class="easyui-linkbutton" iconCls="icon-add" style="width:120px">提交试卷</a>  
				</div>
		<%	}
		
		%>
	</div>
</body>
</html>