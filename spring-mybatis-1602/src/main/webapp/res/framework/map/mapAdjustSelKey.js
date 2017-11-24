/**
 *人工小区调整地图相关
 */
//图层URL
var layerUrl;
//地图对象
var map;
//辅助图层
var locationlayer;
//聚合使用X坐标集合
var x_array=[];
//聚合使用Y坐标集合
var y_array=[];
//控制页面点击取点操作
var dojo_map_click=null;
//定时器
var iTime=null;
//是否执行过初始化地图方法
var Mapflag=true;


//页面加载项
$(document).ready(function() {
	//初始化画地图
	//mapApp.initUrl();
	//mapApp.initMap();
	//autocomplete("searchKeyName");

}); 


var mapApp=function () {
	
    return {

	        //初始化地图路径
    	    initUrl: function () {
				layerUrl = [];
				//底图
				layerUrl[0] = "http://111.40.214.181/arcgis/rest/services/comm/China/MapServer";
				//地区区域图层
				//layerUrl[1] = "http://111.40.214.168:6080/arcgis/rest/services/beijing/address/MapServer";
				
				layerUrl[1] =server.replace("192.168.1.23", "111.40.214.168");;
				//默认定位中心点
				center=[126.643228, 45.749201 ];
	        },
            //初始化地图
	        initMap:function(){
				   require( [ "esri/map", "esri/layers/ArcGISTiledMapServiceLayer",
							"dojo/number", "esri/geometry/webMercatorUtils",
							"esri/dijit/InfoWindow", "esri/layers/FeatureLayer",
							"esri/symbols/SimpleLineSymbol", "esri/geometry/Point",
							"esri/graphic", "esri/geometry/Extent","esri/geometry/Polygon","esri/layers/ArcGISDynamicMapServiceLayer","esri/layers/ImageParameters" ], function(Map, ArcGISTiledMapServiceLayer,
							number, webMercatorUtils, InfoTemplate, FeatureLayer,ArcGISDynamicMapServiceLayer,ImageParameters) {
						//地图工具服务		
						geometryService = new esri.tasks.GeometryService("http://192.168.1.23:6080/arcgis/rest/services/Utilities/Geometry/GeometryServer");
								 
					    map = new Map("mapDiv", {
									center : center,
									zoom : 1,
									sliderStyle : "small",
									slider:true,
									logo : false
								});


				        //底图图层
				        var baseLayer = new ArcGISTiledMapServiceLayer(layerUrl[0]);
				        //添加底部图
				        map.addLayer(baseLayer);
				        //辅助定位层
				        locationlayer = new esri.layers.GraphicsLayer();
				        //循环添加小区点图层
		                //for(var i=1;i<layerUrl.length;i++){
		                   //tiledMapServicesXQ=new esri.layers.ArcGISDynamicMapServiceLayer(layerUrl[1], { id:"xqlayer", opacity:1, visible: true,name:"xqlid" })
		                   //设置显示图层
		                   //tiledMapServicesXQ.setVisibleLayers([1]);
		                   //设置最小显示比例
		                   //tiledMapServicesXQ.setMinScale(8000);
		                   //添加显示图层
		                   //map.addLayer(tiledMapServicesXQ);
		                   
		                   var tiledMapServicesXQ=new esri.layers.ArcGISDynamicMapServiceLayer(layerUrl[1], { id:"xqlayer", opacity:1, visible: true,name:"xqlid" })
		                   //设置显示图层
		                   tiledMapServicesXQ.setVisibleLayers([1,4]);
		                   //设置最小显示比例
		                   tiledMapServicesXQ.setMinScale(8000);
		                   //添加显示图层
		                   map.addLayer(tiledMapServicesXQ);
		                 // }
		                
		                
		            	//添加辅助图层到地图
		            	mapApp.locationMapAddLayer();
	                    //地图点击事件
	                    map.on("click", mapApp.mapClick);
		                //加载默认定位位置,因加载顺序暂时只能使用定时器处理
	    	            mapApp.mapExtent(cityArea);
//		                iTime= window.setInterval(function() { 
//		                	if(cityArea){
//		                	  mapApp.mapExtent(cityArea); 
//		                	  clearInterval(iTime);
//		                	}
//		                }, 500);
		            	 
				      });
	        },
	        //地图点击事件
	        mapClick:function(e){
		    	require(["esri/symbols/PictureMarkerSymbol", "esri/graphic","esri/geometry/Point"
							], function(){ 
							var geometry=new esri.geometry.Point(e.mapPoint.x,e.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));

							//当用户未开启地图选址时才进行IdentifyTask操作
							if(dojo_map_click==null){
								//点选图层只点击1层
								var slayers=[1];
								//调用点选方法
								mapApp.queryiden(layerUrl[1],geometry,slayers);
							}

						}); 
		    	},
		    	/**
		         * 点选查询 IdentifyTask 
		         * @param serivices   服务地址
		         * @param geometry    几何对象 被查询
		         * @param slayers     图层数组 like [0,1]
		         */
		    	queryiden:function(serivices,geometry,slayers){
		        require(["esri/tasks/IdentifyTask","esri/tasks/IdentifyParameters"], 
		            	function(IdentifyTask,IdentifyParameters) {
		            		var  identifyTask = new    IdentifyTask(serivices);
		                    var  identifyParams = new  IdentifyParameters();
		                    identifyParams.tolerance =30;
		                    identifyParams.returnGeometry = true;
		                    identifyParams.layerIds =slayers;
		                    identifyParams.layerOption = IdentifyParameters.LAYER_OPTION_VISIBLE; 
		                    identifyParams.width  = map.width;
		                    identifyParams.height =map.height;
		                    identifyParams.mapExtent = map.extent;
		                    identifyParams.geometry = geometry;
		                    var deferred = identifyTask.execute(identifyParams);
		                    identifyTask.execute(identifyParams, mapApp.idencallback, mapApp.errback);	
		            	});
		            	  
		            },

            idencallback:function(response){
            	   var  il = response.length;
            	   
        		    for (var i = 0; i < il; i++) {
        		        var lid=response[i].layerId;
        		         if(lid==1){//  小区楼栋点图层
                       
							var attributes=new Object();
							attributes=response[i].feature.attributes;
							attributes.NAME=response[i].feature.attributes.LABEL;
							attributes.TITLE=response[i].feature.attributes.LABEL;
							attributes.IMG="A.png";	
							
							var graphic=new Object();
							graphic.attributes=attributes;
							graphic.geometry=response[i].feature.geometry;
							
							var param=new Object();
							param.graphic=graphic;
	
							mapApp.locationMapClick(param);
	        		        break;
        		         }

        		      }
            },
            errback:function(e){
               console.log(e);
               $.messager.alert('错误', '系统错误', 'error');
            },
            //开始画气泡
			locationMap:function(paramObj){
				
				   require(["esri/symbols/PictureMarkerSymbol", "esri/graphic","esri/geometry/Point"
							], function(){ 
							var geometry=new esri.geometry.Point(paramObj.x,paramObj.y, new esri.SpatialReference({ wkid: 3785 }));
							var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("images/map/"+paramObj.img+"", 25, 28);
							var gra = new esri.Graphic(geometry, pictureMarkerSymbol);
							gra.setAttributes( {"NAME":paramObj.name,"ID":paramObj.id,"TITLE":paramObj.title,"IMG":paramObj.img});
							//map.graphics.add(gra)
							//将气泡点添加到临时图层
							locationlayer.add(gra);
							//如果是新增加小区自动打开infowindw
							if(paramObj.img=="marker.png"){
								var param=new Object();
								param.graphic=gra;
								mapApp.locationMapClick(param);
							}
					}); 
				
			},
			//将临时辅助图层添加到Map中
			locationMapAddLayer:function(){
				//将辅助图层添加到Map中
				map.addLayer(locationlayer);
				//添加临时图层点击事件
				locationlayer.on("click", mapApp.locationMapClick);
				//添加鼠标滑过事件
				locationlayer.on("mouse-over", mapApp.locationMapMouseOver);
				//添加鼠标滑出时间
				locationlayer.on("mouse-out", mapApp.locationMapMouseOut);
			},
			//辅助层气泡点击事件
			locationMapClick:function(evt){
				
				var title;
				//处理新增小区点和正常小区点的不同
				if(evt.graphic.attributes.IMG=="marker.png"){
				   var content="小区名称：<input id='xqName'></input><br><a href='javascript:;' class='infowindow_a' ref='"+evt.graphic.geometry.x+","+evt.graphic.geometry.y+"' onClick='btnClick_Add(this)'>添加小区</a>";			
				}else{
					//alert(evt.graphic.attributes.TITLE);
					if(evt.graphic.attributes.TITLE=="POI"){
					  var content="地址名称："+evt.graphic.attributes.NAME+"<br>";			
					}else{
				      var content="地址名称："+evt.graphic.attributes.NAME+"<br><a href='javascript:;' class='infowindow_a' onClick='btnClick(this)' ref='"+evt.graphic.geometry.x+","+evt.graphic.geometry.y+","+evt.graphic.attributes.TITLE+"'>选择小区</a>";			
				     }
				 }
				map.infoWindow.setTitle("地图定位");
				map.infoWindow.setContent(content);
				map.infoWindow.anchor='upperright';
				map.infoWindow.show(evt.graphic.geometry);
				
			},
			//辅助层气泡鼠标滑过事件
			locationMapMouseOver:function(evt){
				var img=evt.graphic.attributes.IMG;
				//更换气泡图片
				mapApp.dealtenGraphic(img,true);
			},
			//辅助层气泡鼠标画出事件
			locationMapMouseOut:function(evt){
				var img=evt.graphic.attributes.IMG;
				//更换气泡图片
				mapApp.dealtenGraphic(img,false);
			},
			
		    //放大地图定位点
			gotoPoint:function(x,y,zoom){
			  	var mapPoint=new esri.geometry.Point(parseFloat(x), parseFloat(y),map.spatialReference);
			  	map.setZoom(zoom);
				map.centerAt(mapPoint);
			},
			//获取数组最小值
			ArrayMax:function(array)
			{
			    return Math.max.apply(Math,array);
			},
			//获取数组最大值
			ArrayMin:function(array)
			{
			    return Math.min.apply(Math,array);
			},
			//地图范围计算进行聚集操作
			locationMapExtent:function(x,y){				
				  require(["esri/geometry/Extent", "esri/SpatialReference"
						], function(){ 
						  var minx=mapApp.ArrayMin(x);   
						  var miny=mapApp.ArrayMin(y);   		  
						  var maxx=mapApp.ArrayMax(x);   
						  var maxy=mapApp.ArrayMax(y);
						  var extent = new esri.geometry.Extent(minx, miny, maxx, maxy,
									new esri.SpatialReference({
										wkid : "102113"
									}));
						  map.setExtent(extent, true);
				  }); 
			},
			//使用地图范围计算
			mapExtent:function(p_extent){
				  require(["esri/geometry/Extent", "esri/SpatialReference"
							], function(){ 
         
					  var extent = new esri.geometry.Extent(eval('(' + p_extent + ')'));
				      map.setExtent(extent, true);
				  }); 
			},
			//根据辅助层气泡图片属性修改气泡颜色
			dealtenGraphic:function (img,flag){
					//截取图片名称，用于换图片拼接
				     var K_img=img.substring(img.lastIndexOf('/')+1,img.lastIndexOf('.'));
					//获取辅助图层
				     var graphics = locationlayer.graphics;
				     //循环辅助图层graphics
				     for (var i = 0; i < graphics.length; i++)
				     {
				    	 //获取对应graphic
				     	var graphic = graphics[i];
				     	 //如graphic的IMG和鼠标滑过的属性相同则改变该气泡颜色
				     	if (img == graphic.attributes.IMG&&img!="marker.png")
				         {
				     		//如果为true加亮气泡
					     	if (flag){
					     		
					     		var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("./images/map/"+K_img+img, 23, 30);
					     	}else { 
					     		var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("./images/map/"+img, 25, 32);
					     	} 
					     	graphic.setSymbol(pictureMarkerSymbol);
					     	
				         }
				    }
			}
	        
       };

}();


function locationMap(e){

	var address_name=$(e).text();
	var p_XY=$(e).attr("ref");

    //如果小区无坐标
	if(typeof(p_XY.length) == "undefined" ){
       	$.messager.alert('提示', '小区无坐标信息', '无法进行定位');
       	return null;
	 }
	if(p_XY[0]==0||p_XY[1]==0){
       	$.messager.alert('提示', '小区无坐标信息', '无法进行定位');
       	return null;
	}
    //分割坐标
	var p_XY= p_XY.split(",")
	//传入参数
	var paramObj=new Object();
	paramObj.x=p_XY[0];
	paramObj.y=p_XY[1];

	paramObj.img=$(e).attr("img");
	
	
	if($(e).text()=="POI位置"){
		paramObj.name=$(e).attr("title");
		paramObj.title="POI";
	}else{
		paramObj.name=$(e).text();
		paramObj.title=$(e).attr("title");
	}
	

	paramObj.id=$(e).attr("id");
	mapApp.locationMap(paramObj);
		
	//放大地图至指定点
	mapApp.gotoPoint(p_XY[0],p_XY[1],15);
}
/**
 * 地图选址小区按钮事件
 */
function btnClick(e){
	var content=$(e).attr("ref");
	var content= content.split(",")
	$('#communityAlias').val(content[2]);
	$('#y').val(content[1]);
	$('#x').val(content[0]);
	
}
/**
 * 地图选址新增小区按钮事件
 */
function btnClick_Add(e){
	var content=$(e).attr("ref");
	var content= content.split(",")
	$('#communityAlias').val($("#xqName").val());
	$('#y').val(content[1]);
	$('#x').val(content[0]);
}
/**
 * 地图选址事件
 */
function loadClick(){

	 //添加地图点击事件
	 dojo_map_click=dojo.connect(map,'onClick',addXQ);
     //将鼠标样式修改为图钉
	 map.setMapCursor("url('images/map/addsymbol.cur'),help");
}
/**
 * 地图选址事件点击回调
 */
function addXQ(evt){	
	//传入参数
	var paramObj=new Object();
	paramObj.x=evt.mapPoint.x;
	paramObj.y=evt.mapPoint.y;
	paramObj.title="新增小区"
	paramObj.img="marker.png";
	paramObj.name="";
	paramObj.id="0";
	//辅助层添加气泡
	mapApp.locationMap(paramObj);
	//放大地图至指定点
	//mapApp.gotoPoint(evt.mapPoint.x,evt.mapPoint.y,15);
	//将鼠标样式修改为默认
	map.setMapCursor("default");
	dojo.disconnect(dojo_map_click);
	dojo_map_click=null;
}