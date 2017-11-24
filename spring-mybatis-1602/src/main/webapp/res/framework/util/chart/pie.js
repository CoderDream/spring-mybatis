

function createPieJson(containerId,data,url,charTitle,seriesTitle){
	//alert("url="+url);
	var chart;
    var jdata = [];
    $.ajax({
        type:"POST",
        url:url,//提供数据的Servlet
        data:data,
        success:function(data){
        	//var xdata= [];
			jQuery.each(data, function(idx,item) {
			      //alert(item.name+","+item.value);
				jdata.push([item.name,item.value]);
			      //xdata.push(item.name);
			});
			//alert("aaaaaaaaaaaaaaaaaa");
			//chart.xAxis.categories = xdata;
			//chart2.series[0].setData(browsers); 
			chart = new Highcharts.Chart({
	            //常规图表选项设置
	            chart: {
	                renderTo: containerId,        //在哪个区域呈现，对应HTML中的一个元素ID
	                plotBackgroundColor: null,    //绘图区的背景颜色
	                plotBorderWidth: null,        //绘图区边框宽度
	                plotShadow: false,            //绘图区是否显示阴影   
	                options3d: {
	                    enabled: true,
	                    alpha: 45,
	                    beta: 0
	                }
	            },
	            
	            //图表的主标题
	            title: {
	                text: charTitle
	            },
	            //每种图表类型属性设置
	            plotOptions: {
	                //饼状图
	                pie: {
	                	depth:25,
	                    allowPointSelect: true,
	                    cursor: 'pointer',
	                    dataLabels: {
	                        enabled: true,
	                        color: '#000000',
	                        connectorColor: '#000000',
	                        formatter: function() {
	                            //Highcharts.numberFormat(this.percentage,2)格式化数字，保留2位精度
	                            return '<b>'+ this.point.name +'</b>: '+Highcharts.numberFormat(this.y,0,',');
	                        }
	                    },
	                    showInLegend: true
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
	                type: 'pie',
	                name: seriesTitle,
	                data:jdata
	            }]
	        });
        },
        error:function(e){
            alert(e);
        }
    });
}


function createPieJsonSimple(containerId,data,url,charTitle,seriesTitle){
	//alert("url="+url);
	var chart;
    var jdata = [];
    $.ajax({
        type:"POST",
        url:url,//提供数据的Servlet
        data:data,
        success:function(data){
        	//var xdata= [];
			jQuery.each(data, function(idx,item) {
			      //alert(item.name+","+item.value);
				jdata.push([item.name,item.value]);
			      //xdata.push(item.name);
			});
			chart = new Highcharts.Chart({
	            //常规图表选项设置
	            chart: {
	                renderTo: containerId,        //在哪个区域呈现，对应HTML中的一个元素ID
	                plotBackgroundColor: null,    //绘图区的背景颜色
	                plotBorderWidth: null,        //绘图区边框宽度
	                plotShadow: false            //绘图区是否显示阴影   
	            },  
	            //图表的主标题
	            title: {
	                text: charTitle
	            },
	            //每种图表类型属性设置
	            plotOptions: {
	                //饼状图
	                pie: {
	                    allowPointSelect: true,
	                    cursor: 'pointer',
	                    dataLabels: {
	                        enabled: false
	                    },
	                    showInLegend: true
	                }
	            },
	            // 去掉水印
	            credits: {
	                enabled:false
	      		},
	      		exporting: {
	                enabled:false
	    		},
	            //图表要展现的数据
	            series: [{
	                type: 'pie',
	                name: seriesTitle,
	                data:jdata
	            }]
	        });
        },
        error:function(e){
            alert(e);
        }
    });
}