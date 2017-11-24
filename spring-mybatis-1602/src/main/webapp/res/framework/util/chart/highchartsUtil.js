/**
 * Highcharts.js
 * 
 */

//alert("highchartsUtil.js");

function createPieJson(containerId,data,url,charTitle,seriesTitle){
	alert("url="+url);
	var chart;
    var jdata = [];
    //alert("bbbbbbbbbbb");
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

function createPie(containerId,url,charTitle,seriesTitle){
	//alert("url="+url);
	var chart;
    var jdata = [];
    //alert("bbbbbbbbbbb");
    $.ajax({
        type:"POST",
        url:url,//提供数据的Servlet
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


/**
 * 
 */
function createBar(containerId,url,charTitle,xTitle,yTitle,seriesTitle){
	//alert("containerId="+containerId+",url="+url);
	alert("createBar");
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



function createLine(containerId,url,charTitle,yTitle,seriesTitle){
	//alert("containerId="+containerId+",url="+url);
    var chart;
    var xdata = [];
    var jdata = [];
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
            chart = new Highcharts.Chart({
                //常规图表选项设置
                chart: {
                    renderTo: containerId,        //在哪个区域呈现，对应HTML中的一个元素ID
                    type: 'spline',  
                    marginRight: 10,

                },
                
                //图表的主标题
                title: {
                    text: charTitle
                },
                xAxis: {  
    				categories: xdata 
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
        },
        error:function(e){
            alert(e);
        }
    });      
}
