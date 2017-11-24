/**
 * 页面分页数据处理
 */
$(function() {
	var page = (function() {
		
		var me={};
		var pageSize=10;//设置每页显示数量
		var dropdown_list;
		/**
		 * 
		 */
		me.gotoPageCommon=function (cpage){
			//获取当前页数
			var cpage=pageList.length;
		    var st = (cpage - 1) * pagesize;
		    var ed = cpage * pagesize > dropdown_list.length ? dropdown_list.length : cpage * pagesize;
			
		}
		
		
	})
});
	