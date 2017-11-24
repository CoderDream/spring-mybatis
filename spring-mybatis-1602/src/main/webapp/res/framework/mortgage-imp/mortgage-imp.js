/**
 * 押品数据导入公用js
 */

/**
 * 返回到项目列表
 */
var goToProjectList=function(basePath){
	window.location.href=basePath+"/mortgageImp/mortgageProjectList.do";
}

/**
 * 根据项目ID返回到文件列表中
 * @param projectId 项目ID
 */
var goToFileList=function(basePath,_projectId){
	window.location.href=basePath+"/mortgageImp/toProjectFileList.do?projectId="+_projectId;
}

/**
 * 提示等待
 * @param msg 提示信息
 */
var waiting=function(msg){
	 $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("#wnavt");//等待效果显示在wnavt控件
     $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("#wnavt").css({display:"block",left:40,top:180});

}

/**
 * 删除等待
 */
var removeWaiting=function(){
	$("#wnavt").find("div.datagrid-mask-msg").remove();
    $("#wnavt").find("div.datagrid-mask").remove();
}



