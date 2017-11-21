
/**
 * 简化easyui模态对话窗的调用
 * 
 * @param target  模态对话窗要显示的DIV ID
 * @param _url	  模态对话窗要显示内容的URL
 * @param _title  模态对话窗口标题
 * @param _width  模态对话窗的宽度
 * @param _height 模态对话窗的高度
 */
function ajaxDialog(target, _url, _title, _width, _height){
    $(target).load(_url);
    //打开模态对话窗
    $(target).dialog({
	    title: _title,
	    width: _width,
	    height: _height,
	    closed: false,
	    cache: false,
	    href: "",
	    modal: true
	});
}

/**
 * 关闭模态对话窗口
 * 
 * @param selector 模态对话窗要显示的DIV ID
 */
function closeDialog(target){
	 $(target).dialog("close");
}