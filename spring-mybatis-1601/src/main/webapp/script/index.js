//检测浏览器版本
function detect(){
	var version = parseFloat($.browser.version); //获取浏览器版本
	var ieNormalversion = 8.0; //IE正常版本8.0
	var chromeNormalversion = 537.36; //Chrome正常版本537.36

	if(!($.browser.safari || $.browser.mozilla)){
		alert("请使用Google Chrome浏览器，版本 34.0.1847.131 m 或以上版本！");
		disableLoginBtn();
	}
}
//禁用登录按钮
function disableLoginBtn(){
	$(":submit").removeClass("button_r_b").addClass("button_h_b");
	$(":submit").attr({"disabled":true, title:"按钮不可用"});
}