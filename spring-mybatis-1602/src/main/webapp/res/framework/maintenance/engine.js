/**
 * 搜索引擎查询处理
 */
//用户选择的城市编码
var cityId_Value=708;
//是否已经开启Autocomplete事件
var is_Autocomplete=false;
//默认引擎检索类型
var is_Type=1;

//引擎输入框光标聚焦事件
function focusKeyword(e){
	
    //获取当前选择城市
    var city = $('#city').combobox('getValue');
    //判断城市是否已经选择
    if(city==""){
    	 $.messager.alert('提示', '请项目对应城市', 'info');
        return ;
    } 
    //将用户选择的城市编码赋予给全局变量
	cityId_Value=$('#city').combobox('getValue');
	
	//判断是否开启Autocomplete事件
	if(!is_Autocomplete){
		is_Autocomplete=true;
		autocomplete();
	}
}

function selectChange(){
	is_Type=$("#keyType").val();
	//alert(is_Type);
}

function autocomplete(){
	//searchKeyNameForPOI
	//searchKeyName

	

    $('#keyword').autocomplete(basePath+"Maintenance.do?method=searchKeyName", {
        max: 12,    //列表里的条目数
        minChars: 2,    //自动完成激活之前填入的最小字符
        width: 400,     //提示的宽度，溢出隐藏
        scrollHeight: 300,   //提示的高度，溢出显示滚动条
        delay:500,
        matchContains: false,    //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
        mustMatch:true,
        cacheLength :1,
        matchSubset :false,
        // matchCase :false,
        //autoFill: false,    //自动填充cityId_Value
        //extraParams:{"jsession":new Date(),cityId:cityId_Value,keyType:is_Type},
        
        extraParams: { 
        	cityId: function()
        	{ 
        		var cityId=$('#city').combobox('getValue');
        		return cityId; 
        	}, 
        	keyType: function() 
        	{
        		var keyType=$("#keyType").val();
        		return keyType; 
        	}
        },
        parse: function (data) {
          	 
        return $.map(data.jsondata, function (row) {
       	 
               return {
                   data: row,
                   value: row.x,
                   result: row.fullname
               };

        });

        }
        ,
        formatItem: function(row, i, max) {
            //return i + '/' + max + ':"' + row.FULLNAME;
            return row.fullname;
        },
        formatMatch: function(row, i, max) {
            return row.fullname;
        },
        formatResult: function(row) {
            return row;
        }
    }).result(function(event, row, formatted) {
    	if(typeof(row) != "undefined"){
    	    //地图清理操作
    	    mapUtil.clearClick('clear_All');
   	        //定位参数
	    	var paramObj=new Object();
	    	paramObj.x=parseFloat(row.x);
	    	paramObj.y=parseFloat(row.y);
	    	paramObj.title="引擎定位";
	    	paramObj.img="A.png";
	    	paramObj.name=row.fullname;
	    	paramObj.id=row.address_id;
	    	//调用画气泡方法
	    	mapApp.drawBubble(paramObj);   
	    	//将地图定位到的指定位置
	    	mapApp.gotoPoint(parseFloat(row.x),parseFloat(row.y),13);
    	}
    });

}