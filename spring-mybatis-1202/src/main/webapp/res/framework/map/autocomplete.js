/**
 * 搜索引擎查询处理
 */
//用户选择的城市编码
var cityId_Value=708;
//是否已经开启Autocomplete事件
var is_Autocomplete=false;
//默认引擎检索类型
var is_Type=1;


function autocomplete(cityId){

    $('#searchKeyName').autocomplete(basePath+"Maintenance.do?method=searchKeyName", {
        max: 12,    //列表里的条目数
        minChars: 2,    //自动完成激活之前填入的最小字符
        width: 400,     //提示的宽度，溢出隐藏
        scrollHeight: 300,   //提示的高度，溢出显示滚动条
        delay:500,
        matchContains: false,    //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
        mustMatch:true,
        cacheLength :1,
        matchSubset :false,
        extraParams: { 
        	cityId: function()
        	{ 
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
    	
    });

}