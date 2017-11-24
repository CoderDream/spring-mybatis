function createBar(containerId,url,charTitle,xTitle,yTitle,seriesTitle){
    var chart;
    var xdata = [];
    var jdata = [];
    //异步请求数据
    $.ajax({
        type:"GET",
        url:url,
        success:function(data){
            //迭代，把异步获取的数据放到数组中
            $.each(data,function(i,d){
                //alert(d.name+" "+d.value);
                //alert(d.name);
            	xdata.push(d.name);
            	jdata.push(d.value);
            });
            
            //alert(xdata);
          	//alert(jdata);
          	
          	chart = new Highcharts.Chart({
                //常规图表选项设置
                chart: {
                    renderTo: containerId,        //在哪个区域呈现，对应HTML中的一个元素ID
    				type:'column',
    				margin:75,
                    options3d: {
                        enabled: true,
                        alpha: 15,
                        beta: 15,
                        depth:50,
                        viewDistance:25
                    }
                },
                
                //图表的主标题
                title: {
                    text: charTitle
                }, 
                xAxis: {
                	categories:xdata,
                	title:{text:xTitle}
                },
                yAxis: {  
                	title: {  
                		text: yTitle  
                	},  
                }, 

                //每种图表类型属性设置
                plotOptions: {
                    column:{
                    	depth:25,
                    	dataLabels:{
                    		enabled:true
                    	}
                    }
                },
                // 去掉水印
                credits: {
                    enabled:false
          		},
          		exporting: {
                    enabled:true
        		},
                //图表要展现的数据
                series: [{
                    name: seriesTitle,
                    data:jdata
                }]
            });
            
            //设置数据
            //chart.series[0].setData(browsers);
            //chart.xAxis[0].categories = xdata;
        },
        error:function(e){
            alert(e);
        }
    }); 
    
}