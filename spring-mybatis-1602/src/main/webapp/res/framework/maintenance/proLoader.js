/**
 * Created by xianling on 2015/12/29
 */
var selectFlag=true;
// 获取项目下拉框
var btsloader = function(param, success, error) {
	// 获取输入的值
	var q = param.q || "";
	// 此处q的length代表输入多少个字符后开始查询
	// if(q.length <= 0) return false;
	$.ajax({
		url : basePath + "checkData/projectShow.do",
		// type:"post",
		data : {
			// 传值，还是JSON数据
			project : q
		},

		// 重要，如果写jsonp会报转换错误，此处不写都可以
		dataType : "json",
		success : function(data) {

			// 关键步骤，遍历一个List对象
			var items = $.each(data, function(index, value) {
					return {
						PROJECTID : value.PROJECTID,
						PROJECTNAME : value.PROJECTNAME
					};
			});
			
			// 执行loader的success方法
			success(items);
			
			if(selectFlag){
				selectFlag=false;
				var data = $('#project').combobox('getData');
		        if (data.length > 0) {
		             $('#project').combobox('select', data[0].PROJECTID);
		             //默认查询城市
		             selectCity();
		        } 
			}
			
		},
		// 异常处理
		error : function(xml, text, msg) {
			error.apply(this, arguments);
		}
	});
};

// 选中项目下拉框后，触发城市下拉框
function selectCity() {
	var project = $('#project').combobox('getValue');
	$('#city').combobox({
		url : basePath + 'checkData/cityShow.do?projectId=' + project,
		valueField : 'CITYID',
		textField : 'CITYNAME',
	    onLoadSuccess: function (data) {
	        if (data.length > 0) {
	            $(this).combobox('setValue',data[0].CITYID);
	            //默认加载地图定位
	             selectCommunityKey();
	        }
        }
 });
}



//关键字下拉列表
function selectCommunityKey() {
	var project = $('#project').combobox('getValue');
	var city = $('#city').combobox('getValue');
	$('#communityKey').combobox({
		url : basePath + 'Maintenance.do?method=communityKeyShow&projectId=' + project+"&cityId="+city,
		valueField : 'keyId',
		textField : 'communityKey',
	});
	//获取城市名称
	var cityName = $('#city').combobox('getText');
	//切换城市地图重新聚合
	if(map!=null){
	   cityExtent(cityName);
	}
}

//切换城市地图重新聚合
function cityExtent(cityName){
	    
	    //参数不能为空
	    if(cityName==""){
	        return ;
	    } 
	    window.parent.document.getElementById("loading").style.display = "block";
		//根据地区名称重新进行定位操作
		$.ajax({
	        type: "post",//使用get方法访问后台
	        dataType: "json",//返回json格式的数据
	        url: basePath+"peopleAdjust.do?method=getCity_Extent",
	        data: {cityName:cityName},//要发送的数据
	        beforeSend:function(){
			    //开启遮盖
				window.parent.document.getElementById("loading").style.display = "block";
	        },
	        complete :function(){
	        	//隐藏遮盖
	        	window.parent.document.getElementById("loading").style.display = "none";	        	
	        },
	        success: function(data){//msg为返回的数据，在这里做数据绑定
	        	if(XQ_Layer!=null){
	        		//清理原小区图层
	        		mapApp.removeLayer();
	        	}
				if(data.cityArea.length >0){
		        	mapApp.mapExtent(data.cityArea);
				}
				if(data.serverUrl.length >0){
		        	mapApp.addLayer(data.serverUrl);
				}

	        },
	        error:function(data){  
	        	$.messager.alert('错误', '城市范围聚合失败', 'error');
	        }
		});
}