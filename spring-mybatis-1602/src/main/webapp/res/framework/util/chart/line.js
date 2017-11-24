/** -----------------------------------------------------------------------
 * 
 *      filename : line.js
 *     
 *      @author yanggy
 * 
 -------------------------------------------------------------------------*/

/**
 * 通过异步方式获取一个折线图
 * 
 * @param containerId  放置图标的容器ID
 * @param url          异步请求的地址
 * @param charTitle    图表的主标题
 * @param subTitle     图表的副标题
 * @param yTitle       纵坐标的标题(Y轴)
 * @author yanggy
 * @since 2015.11.5
 */
function createAjaxGetLine(containerId,url,charTitle,subTitle,yTitle){
	//alert("createAjaxGetLine");
	//alert("containerId="+containerId+",url="+url);
    $.ajax({
        type:"GET",
        url:url,
        success:function(data){
        	//alert(JSON.stringify(data));
        	//alert(data.series);
            chart = new Highcharts.Chart({
                //常规图表选项设置
                chart: {
                    renderTo: containerId,        //在哪个区域呈现，对应HTML中的一个元素ID
                    type: 'spline',  
                    marginRight: 10
                },            
                //图表的主标题
                title: {
                    text: charTitle,
                    style:[{
                    	fontSize:'10px',
                    	color:'#3E576F'
                    }]  
                },
                subtitle:{
                	text:subTitle
                },
                xAxis: {  
    				categories: eval('('+data.xdata+')')
                }, 
                yAxis: {  
                	title: {  
                		text: yTitle  
                	}, 
                	plotLines:[{
                		value:0,
                		width:1,
                		color:'#808080'
                	}]
                }, 
                credits: {
                    enabled:false
          		},
          		exporting: {
                    enabled:false
        		},
                series: eval('('+data.series+')')
            });
        },
        error:function(e){
            alert(JSON.stringify(e));
        }
    });      
}