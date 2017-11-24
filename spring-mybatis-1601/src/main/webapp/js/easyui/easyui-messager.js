/**=====================================================
 * 
 * 简化easyui消息提示框的调用
 * 
 *=======================================================*/


/**
 * 将消息框的显示在窗口的右下方
 * 
 * @param _title 消息框标题
 * @param _msg 消息内容
 * @param _timeout 消息框自动消失的时间
 * @param _class 值为：info,success,error
 */
function showMsgOnRightBottom(_title, _msg, _timeout,_msgType){
	$.messager.show({
			title: _title,
			msg: "<div class='prompt-box'><div class='"+ _msgType +"-icon'></div><div class='prompt-msg'>"+_msg+"</div></div>", 
			timeout: _timeout,
			showType: "slide"
	});
}

/**
 * 将消息框的显示在窗口的正中央
 * 
 * @param _title 消息框标题
 * @param _msg 消息内容
 * @param _width 消息框的宽度
 * @param _height 消息框的高度
 * @param _timeout 消息框自动消失的时间
 * @param _msgType 值为：info,success,error
 */
function showMsgBoxOnCenter(_title, _msg, _width, _height, _timeout ,_msgType){
	$.messager.show({
		title: _title,
		msg: "<div class='prompt-box'><div class='"+_msgType+"-icon'></div><div class='prompt-msg'>"+_msg+"</div></div>",
		width: _width,
	    height: _height,
		timeout: _timeout,
		showType: 'slide',
		style:{
			left:(document.body.clientWidth- _width)/2,
			top:(document.body.style.pixelHeight+document.documentElement.style.pixelHeight)/2,//(document.body.clientWidth-550)/2
			bottom:''
		}
	});
}