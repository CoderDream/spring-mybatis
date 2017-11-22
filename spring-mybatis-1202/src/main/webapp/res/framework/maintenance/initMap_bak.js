/**
 * Created by chenliwei on 2016/1/8
 */

// 地图对象
var map;
// 临时工具层
var toolLayer;
// 修改散楼坐标点击事件
var buildMapClick=null;
// 查询小区散楼对应关系点击事件
var communityMapClick=null;
// 画面工具
var toolbar;
//小区面编辑点击事件
var editCommunityMapClick=null;
//小区图层
var XQ_Layer=null;

// 初始化方法
$(document).ready(function() {

	  // 初始化地图
	  mapApp.initMap();
	  //初始化小区画面方法
	  communityOperate.initDrawMap();

});


//地图操作
var mapApp = function() {

	return {
		// 初始化地图
		initMap : function() {
			require([ "esri/map", "esri/layers/ArcGISTiledMapServiceLayer",
					"dojo/_base/lang", "dojo/number","esri/geometry/webMercatorUtils",
					"esri/dijit/InfoWindow","esri/layers/FeatureLayer",
					"esri/symbols/SimpleLineSymbol", "esri/geometry/Point",
					"esri/graphic", "esri/geometry/Extent","esri/geometry/Polygon",
					"esri/layers/ArcGISDynamicMapServiceLayer",
					"esri/layers/ImageParameters","esri/symbols/PictureMarkerSymbol", 
					"esri/graphic","esri/geometry/Point","esri/tasks/query" ], function(Map,
					ArcGISTiledMapServiceLayer, number, webMercatorUtils, lang,
					InfoTemplate, FeatureLayer, ArcGISDynamicMapServiceLayer,
					ImageParameters) {

				// 地图工具服务
				geometryService = new esri.tasks.GeometryService(
						geometryServiceUrl);

				map = new Map("mapDiv", {
					//center : center,
					zoom : 1,
					sliderStyle : "small",
					slider : true,
					logo : false
				});

				

				//底图图层
				var baseLayer = new ArcGISTiledMapServiceLayer(baseLayerUrl);
				//添加底部图
				map.addLayer(baseLayer);
		        //默认中心点定位
		        mapApp.mapExtent(default_Extent);	
		        //添加小区图层
		        mapApp.addCommunityFL();
		        //调用添加散楼图层方法
		        mapApp.addBuildFL();
		        //添加临时工具图层
		        toolLayer = new esri.layers.GraphicsLayer();
		        //添加临时层,以及临时层事件
		        mapApp.addToolLayer();
		        
		        
				//var tiledMapServicesXQ=new esri.layers.ArcGISDynamicMapServiceLayer(
				//		"http://111.40.214.168:6080/arcgis/rest/services/dalian/address/MapServer",
				//		{ id:"xqlayer", opacity:1, visible: true,name:"xqlid" });
				//添加显示图层
                //map.addLayer(tiledMapServicesXQ);

			});
		},
		//添加散楼图层
		addBuildFL:function(){
			buildFLLayer = new esri.layers.FeatureLayer(buildingLayerUrl, {
               mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
               outFields: ["*"],
               id: "buildFL",
               minScale:8000
             });
			//图层过滤条件
			buildFLLayer.setDefinitionExpression("STATUS_CD = 1");
     	    //添加图层
            map.addLayers([buildFLLayer]);
            //散楼图层点击事件
            buildFLLayer.on("click", function(evt) {
        	  //点击方法
            	dataOperate.getAddress(evt.graphic.attributes.ADDRESS_SEQ);
            });
		},
		//添加小区图层
		addCommunityFL:function(){
			communityFLLayer = new esri.layers.FeatureLayer(communtityLayerUrl, {
	               mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	               outFields: ["*"],
	               id: "communityFL",
	               minScale:8000
	             });
			//添加图层
            map.addLayers([communityFLLayer]);
            //小区图层点击事件
            communityFLLayer.on("click", function(evt) {
            
          	  //点击方法
                // flLocationMap(evt.graphic.graphicAttributes.ADDRESS_SEQ);
              });
		},
		removeLayer:function(){
			map.removeLayer(XQ_Layer);

		},
		addLayer:function(url){
			//替换IP
			var url =url.replace("192.168.1.23", "111.40.214.168");

            XQ_Layer=new esri.layers.ArcGISDynamicMapServiceLayer(url, { id:"xqlayer", opacity:1, visible: true,name:"xqlid" })
            //设置显示图层
            XQ_Layer.setVisibleLayers([1]);
            //设置最小显示比例
            XQ_Layer.setMinScale(40000);
            //添加显示图层
            map.addLayer(XQ_Layer);
		},
		//使用地图范围计算
		mapExtent:function(p_extent){
			  require(["esri/geometry/Extent", "esri/SpatialReference"
						], function(){ 
     
				  var extent = new esri.geometry.Extent(eval('(' + p_extent + ')'));
			      map.setExtent(extent, true);
			  }); 
		},
		//根据XY集合地图范围计算进行聚集操作
		mapExtent_Array:function(x_array,y_array){				
			  require(["esri/geometry/Extent", "esri/SpatialReference"
					], function(){ 
					  var minx=mainApp.ArrayMin(x_array);   
					  var miny=mainApp.ArrayMin(y_array);   		  
					  var maxx=mainApp.ArrayMax(x_array);   
					  var maxy=mainApp.ArrayMax(y_array);
					  var extent = new esri.geometry.Extent(minx, miny, maxx, maxy,
								new esri.SpatialReference({
									wkid : "102113"
								}));
					  map.setExtent(extent, true);
			  }); 
		},
		//地图resize操作
		mapResize:function(){
			map.resize();
		    map.reposition();
		},
		addToolLayer:function(){
			//将辅助图层添加到Map中
			map.addLayer(toolLayer);
			//添加临时图层点击事件
			toolLayer.on("click", mapApp.toolLayerClick);
			//添加鼠标滑过事件
			toolLayer.on("mouse-over", mapApp.toolLayerMouseOver);
			//添加鼠标滑出时间
			toolLayer.on("mouse-out", mapApp.toolLayerMouseOut);
		},
		toolLayerClick:function(evt){
			
			mapApp.showInfowindow(evt);
		},
		//工具层气泡鼠标滑过事件
		toolLayerMouseOver:function(evt){
			var img=evt.graphic.attributes.IMG;
			//更换气泡图片
			mapApp.dealtenGraphic(img,true);
		},
		//工具层气泡鼠标滑出事件
		toolLayerMouseOut:function(evt){
			var img=evt.graphic.attributes.IMG;
			//更换气泡图片
			mapApp.dealtenGraphic(img,false);
		},
        //向工具层中画气泡方法
		drawBubble:function(paramObj){
			var geometry=new esri.geometry.Point(paramObj.x,paramObj.y, new esri.SpatialReference({ wkid: 3785 }));
			var pictureMarkerSymbol;
			if(paramObj.img=="dingwei.png"){
				 pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("images/map/"+paramObj.img+"", 18, 18);
			}else{
				 pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("images/map/"+paramObj.img+"", 23, 30);
			}
			
			var gra = new esri.Graphic(geometry, pictureMarkerSymbol);
			gra.setAttributes( {"NAME":paramObj.name,"ID":paramObj.id,"TITLE":paramObj.title,"IMG":paramObj.img,"PARAMOBJ":paramObj});
			//将气泡点添加到临时图层
			toolLayer.add(gra);	
			//判断定位图标，如单点定位自动开启infowindow(特殊处理)
			if(paramObj.img=="dingwei.png"){
				var param=new Object();
				param.graphic=gra;
				mapApp.showInfowindow(param);
			}
		},
		//根据辅助层气泡图片属性修改气泡颜色
		dealtenGraphic:function (img,flag){
			//截取图片名称，用于换图片拼接
		     var K_img=img.substring(img.lastIndexOf('/')+1,img.lastIndexOf('.'));
			//获取辅助图层
		     var graphics = toolLayer.graphics;
		     //循环辅助图层graphics
		     for (var i = 0; i < graphics.length; i++)
		     {
		    	//获取对应graphic
		     	var graphic = graphics[i];
		     	//如graphic的IMG和鼠标滑过的属性相同则改变该气泡颜色
		     	if (img == graphic.attributes.IMG&&img!="dingwei.png")
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
		},
		//定位地图到指定位置指定级别
		gotoPoint:function(x,y,zoom){
		  	var mapPoint=new esri.geometry.Point(parseFloat(x), parseFloat(y),map.spatialReference);
		  	map.setZoom(zoom);
			map.centerAt(mapPoint);
		},
		//infowindow
		showInfowindow:function(evt){
			//获取散楼图层气泡点击模板内容
			var content=mapModel.getModel(evt);
			
			map.infoWindow.setTitle(evt.graphic.attributes.TITLE);
			map.infoWindow.setContent(content);
			map.infoWindow.anchor='upperright';
			map.infoWindow.show(evt.graphic.geometry);
		}

	}
}();



//修改小区面信息存储对象
var communityEvtObj=null;
var draw_toolbar=false;
var edit_toolbar=false;
//修改小区面编辑工具
var editToolbar_communtity;
//标识添加小区类型（1：正常添加小区，2：修改坐标后添加小区）
var addcommunity_K;
var selected_graphics=null;
//小区相关操作
var communityOperate=function(){
	return {
		buildClick:function(){
    	    //地图清理操作
    	    mapUtil.clearClick('clear_All');
    	    //将鼠标样式修改为图钉
    	    map.setMapCursor("url('images/map/seach.cur'),help");
    		//添加散楼修改坐标地图点击事件
    	    communityMapClick=dojo.connect(map,'onClick',communityOperate.clickCallback);
		},
		//散楼位置修改点击事件回调函数
		clickCallback:function(evt){
			//恢复鼠标默认样式
			map.setMapCursor("default");
			//关闭点击事件
        	dojo.disconnect(communityMapClick);
        	//修改对象初始化值
        	communityMapClick=null;
        	//声明geometry
        	var geometry=new esri.geometry.Point(evt.mapPoint.x,evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
		    //声明查询条件
        	var query=esri.tasks.Query();
        	query.geometry = geometry;
        	communityFLLayer.queryFeatures(query, communityOperate.selectClickInBuffer);
		},
		//根据点区小区面信息
		selectClickInBuffer:function(response){

	         var features = response.features;
	         //循环查询返回数据(根据业务场景只取返回的第一个feature属性值)
	         if(features.length>0){
	        	 //ADDRESS_SEQ/OBJECTID
	        	 dataOperate.getShowRelation(features[0].attributes.ADDRESS_SEQ);
	        	 
	         }else{
	 			$.messager.show({
					title:'提示信息',
					msg:'当前选择位置没有发现小区图层数据',
					timeout:2000,
					showType:'slide'
				});
	         } 
	          
		},
	    //根据坐标点查询所在小区
		getXYCommuntiy:function(evt){
        	//声明geometry
        	var geometry=new esri.geometry.Point(evt.mapPoint.x,evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
		    //声明查询条件
        	var query=esri.tasks.Query();
        	query.geometry = geometry;
        	communityFLLayer.queryFeatures(query, communityOperate.selectXYInBuffer);
		},
		//根据点区小区address_seq
		selectXYInBuffer:function(response){
             var res=null;
	         var features = response.features;
	         //循环查询返回数据(根据业务场景只取返回的第一个feature属性值)
	         if(features.length>0){
	        	 //如果查询到操作人员将楼栋点标记到小区面中直接保存点面关系
	        	 res=features[0].attributes.ADDRESS_SEQ;
	        	 var paramObj=new Object(); 
				 paramObj.type='addRelation'
				 paramObj.addressSeq=buildObj.addressSeq;
				 paramObj.communtityId=features[0].attributes.ADDRESS_SEQ;
				 paramObj.communtityName=features[0].attributes.COMMUNTITY_NAME;
				 paramObj.x=buildObj.evt.mapPoint.x;
				 paramObj.y=buildObj.evt.mapPoint.y;
				 dataOperate.relationCommunity(paramObj);
	        	 
	         }else{
	        	 
        	     var paramMapObj=new Object();
    			 paramMapObj.x=buildObj.evt.mapPoint.x;
    			 paramMapObj.y=buildObj.evt.mapPoint.y;	
    			 paramMapObj.title="散楼临时定位点";
    			 paramMapObj.img="location.png";
    			 paramMapObj.name="临时散楼定位点，待小区画面完成后自动清除";
    			 paramMapObj.id=000;
    			 mapApp.drawBubble(paramMapObj);
	        	 
	        	 
	        	 $.messager.alert('提示', '当前移动位置下没有可以关联的虚拟小区，请继续进行画虚拟小区操作,小区画面操作结束后自动保存');
		        
	        	 //已修改坐标位置为基点放大地图
    			 var zoom=14;
    			 if(map.getZoom()>13){
    				zoom=map.getZoom();
    			 }
    			 //放大地图至指定点
    			 mapApp.gotoPoint(buildObj.evt.mapPoint.x,buildObj.evt.mapPoint.y,zoom);
    			
	        	 //开启画面方法
	        	 toolbar.activate(esri.toolbars.Draw.POLYGON);
	        	 //开启小区画面标识
	        	 draw_toolbar=true;
	        	 //修改散楼后添加小区标识
	        	 addcommunity_K=2;
	        	 
		         map.hideZoomSlider();
		         //将鼠标样式修改为图钉
		    	 map.setMapCursor("url('images/map/addsymbol.cur'),help");
	         }	         
		},
		//普通添加小区方法
		addCommuntiy:function(){
       	     //开启画面方法
       	     toolbar.activate(esri.toolbars.Draw.POLYGON);
       	     //开启小区画面标识
       	     draw_toolbar=true;
        	 //正常添加小区标识
        	 addcommunity_K=1;
        	 
	         map.hideZoomSlider();
	         //将鼠标样式修改为图钉
	    	 map.setMapCursor("url('images/map/edit.cur'),help");
		}
		,
    	//初始化画面方法
    	initDrawMap:function(){
    		require(["dojo/dom", "dojo/dom-attr", "dojo/_base/array", "esri/Color", "dojo/number",
    		         "dojo/parser", "dijit/registry", "esri/config", "esri/graphic", "esri/tasks/GeometryService",
    		         "esri/tasks/BufferParameters", "esri/toolbars/draw", "esri/symbols/SimpleMarkerSymbol",
    		         "esri/symbols/SimpleLineSymbol", "esri/symbols/SimpleFillSymbol", "esri/symbols/Font",
    		         "esri/symbols/TextSymbol",  "dijit/layout/BorderContainer", "dijit/layout/ContentPane"
    		     ], function(dom, domAttr, array, Color, number, parser, registry, esriConfig, Graphic, GeometryService, BufferParameters, Draw,
    		                 SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol, Font, TextSymbol) {
    		       
    		       parser.parse();
    		     
                   //实例化画图工具
    		       toolbar = new Draw(map);
    		       toolbar.on("draw-end", addDrawToMap);
    		           		          		       
   		    	   //画图调用方法
  				   function addDrawToMap(evtObj) {
	  		    	      map.graphics.clear();
	  		    	      var geometry = evtObj.geometry;
	  		    	      // 添加一个几何图形到面上
	  		    	      var symbol = new SimpleFillSymbol(
	  		    	        SimpleFillSymbol.STYLE_SOLID,
	  		    	        new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, new Color([0, 0, 0]), 2),
	  		    	        new Color([0, 0, 255, 0.5]));
	  		    	        var graphic = new Graphic(geometry, symbol);
	  		    	      map.graphics.add(graphic);
                          //使用geometryService调用画面结束回调函数
	  		    	     geometryService.simplify([geometry], getLabelPoints);
  		    	    }


  				      		       
  				 //画图结束调用事件
		    	 function getLabelPoints(geometries) {
		    	        if (geometries[0].rings.length > 0) {
		    	            geometryService.labelPoints(geometries, function(labelPoints) { // callback
		    	           
		    	            draw_toolbar=false;
		    	            //关闭画图工具
		    	            toolbar.deactivate();
		    	            map.showZoomSlider();
		    	            //将鼠标样式恢复
		    	       	    map.setMapCursor("default");
		    	       	    
		    	       	    var address_SEQ=dataOperate.getAddressSeq(); 
		    	       	    
		    	       	    //保存小区
			            	$.messager.prompt('保存小区', '请输入小区名称：', function(r){
			            			if (r){
					    	          	 var attr = {};
					    	             var create_Date= mainApp.getNowFormatDate();
					    	             attr["COMMUNTITY_NAME"] = r;
					    	             attr["STATUS_CD"] = 1;
					    	             attr["ADDRESS_SEQ"] = address_SEQ;
					    	             attr["CREATE_DATE"] =create_Date
					    	             attr["CREATE_STAFF_ID"] = $("#staff_Id").val();
					    	         	  
					    	             var newGraphic = new Graphic(geometries[0], null, attr);
					    	             communityFLLayer.applyEdits([newGraphic], null, null);
					      				 map.graphics.clear()
					      				 mapUtil.clearClick('clear_All');
                                         //如果添加小区为修改楼栋后强制添加则需要建立点面关系
					    	             if(addcommunity_K==2){
						    	        	 //如果查询到操作人员将楼栋点标记到小区面中直接保存点面关系
						    	        	 res=address_SEQ;
						    	        	 var paramObj=new Object(); 
						    				 paramObj.type='addRelation'
						    				 paramObj.addressSeq=buildObj.addressSeq;
						    				 paramObj.communtityId=address_SEQ;
						    				 paramObj.communtityName=r;
						    				 paramObj.x=buildObj.evt.mapPoint.x;
						    				 paramObj.y=buildObj.evt.mapPoint.y;
						    				 dataOperate.relationCommunity(paramObj);
						      				 map.graphics.clear()
						      				 mapUtil.clearClick('clear_All');
					    	             }
					    	             

			            				 return null;
			            			}else{
			            		       	 $.messager.alert('提示', '保存小区必须输入小区名称', 'info');
			              				 map.graphics.clear()
			            		         return null;
			            			}
			            			mapUtil.clearClick('clear_All');
			            	  });

		    	          });
		    	        } else {
		    	      
		    	          $.messager.alert('提示', '最少需要选址三个点', 'info');
		    	        }
		    	        //标识关闭地图画图点击事件
		    	        draw_Click=false;
		    	      }
    		   });
		},
	editClick:function(){
	    //地图清理操作
	    mapUtil.clearClick('clear_All');
	    //将鼠标样式修改为图钉
	    map.setMapCursor("url('images/map/edit.cur'),help");
		//修改小区面层点击事件
	    editCommunityMapClick=dojo.connect(map,'onClick',communityOperate.editClickCallback);
	},
	//散楼位置修改点击事件回调函数
	editClickCallback:function(evt){
		//恢复鼠标默认样式
		map.setMapCursor("default");
		//关闭点击事件
    	dojo.disconnect(editCommunityMapClick);
    	//修改对象初始化值
    	editCommunityMapClick=null;
    	//声明geometry
    	var geometry=new esri.geometry.Point(evt.mapPoint.x,evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
	    //声明查询条件
    	var query=esri.tasks.Query();
    	query.geometry = geometry;
    	communityFLLayer.queryFeatures(query, communityOperate.selectEditClickInBuffer);
	},
	//根据点区小区面信息
	selectEditClickInBuffer:function(response){

         var features = response.features;
         //循环查询返回数据(根据业务场景只取返回的第一个feature属性值)
         if(features.length>0){
      	 
	        	require([ "esri/map",
							"esri/toolbars/edit",
							"esri/layers/FeatureLayer",
							"esri/config",							
							"dojo/_base/event",
							"dojo/parser",							
							"dijit/layout/BorderContainer", "dijit/layout/ContentPane", 
							"dojo/domReady!"
		        	       ], function(
		        	    		   Map, Edit, FeatureLayer, esriConfig,
		        	    	        event, parser
		        	       ) {
		        	          
	        		           edit_toolbar=true;
		        	           editToolbar_communtity = new Edit(map);
		        	          // editToolbar_communtity.on("deactivate", function(evt) {
		        	             //if ( evt.info.isModified ) {
		        	            	 //communityFLLayer.applyEdits(null, [evt.graphic], null);
		        	            	// communityFLLayer.applyEdits(null, [selected_graphics], null);

		        	           //  }
		        	           //});

		        	           selected_graphics=null;
		        	           selected_graphics=features[0];
		        	           editToolbar_communtity.activate(Edit.EDIT_VERTICES , selected_graphics);
		        	           
		        	           communityFLLayer.on("dbl-click", function(evt) {
		        	        	  edit_toolbar=false;
				        	      event.stop(evt);
				        	     // editToolbar_communtity.activate(Edit.EDIT_VERTICES , evt.graphic);
				        	      
				        	      //editToolbar_communtity.activate(Edit.EDIT_VERTICES , selected_graphics);
				        	      //关闭编辑工具
				        	     // editToolbar_communtity.deactivate();
		        	           });

		        	       });
 
         }else{
 			$.messager.show({
				title:'提示信息',
				msg:'当前选择位置没有发现小区图层数据,无法进行修改操作',
				timeout:2000,
				showType:'slide'
			});
         } 
          
	},
	saveCommunity:function(){
		communityFLLayer.applyEdits(null, [selected_graphics], null);
		editToolbar_communtity.deactivate();
	}
	
	}
	
}();
//
//var batchKeyClick=null;
//var batchObj=new Object();
////使用关键字进行批量匹配小区
//var batchKey=function(){
//	return {
//		//关键字批量改点操作
//		batchKeyClick:function(keyId){
//			//地图清理操作
//			mapUtil.clearClick('clear_All');
//			//重新实例散楼信息存储对象
//			batchObj=new Object;
//			batchObj.keyId=keyId;
//    	    //将鼠标样式修改为图钉
//    	    map.setMapCursor("url('images/map/addsymbol.cur'),help");
//    		//添加散楼修改坐标地图点击事件
//    	    batchKeyClick=dojo.connect(map,'onClick',buildMapOperate.clickCallback);
//		},
//		//散楼位置修改点击事件回调函数
//		clickCallback:function(evt){
//			//恢复鼠标默认样式
//			map.setMapCursor("default");
//			//关闭点击事件
//        	dojo.disconnect(batchKeyClick);
//        	//修改对象初始化值
//        	buildMapClick=null;
//        	//将定位坐标存储到
//        	buildObj.evt=evt;
//			//获取该散楼坐标点所在小区面ID
//        	batchKey.getXYCommuntiy(evt);
//		},
//	    //根据坐标点查询所在小区
//		getXYCommuntiy:function(evt){
//        	//声明geometry
//        	var geometry=new esri.geometry.Point(evt.mapPoint.x,evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
//		    //声明查询条件
//        	var query=esri.tasks.Query();
//        	query.geometry = geometry;
//        	communityFLLayer.queryFeatures(query, batchKey.selectXYInBuffer);
//		},
//		selectXYInBuffer:function(response){
//            var res=null;
//	         var features = response.features;
//	         //循环查询返回数据(根据业务场景只取返回的第一个feature属性值)
//	         if(features.length>0){
//	        	 
//
//	        	 //如果查询到操作人员将楼栋点标记到小区面中直接保存点面关系
//	        	 res=features[0].attributes.ADDRESS_SEQ;
//	        	 var paramObj=new Object(); 
//				 paramObj.type='batchRelation';
//				 paramObj.keyId=batchObj.keyId;
//				 paramObj.communtityId=features[0].attributes.ADDRESS_SEQ;
//				 paramObj.communtityName=features[0].attributes.COMMUNTITY_NAME;
//				 paramObj.x=buildObj.evt.mapPoint.x;
//				 paramObj.y=buildObj.evt.mapPoint.y;
//				 dataOperate.relationCommunity(paramObj);
//	        	 
//	         }else{
//	        	 $.messager.alert('提示', '批量关键字位置修改必须将坐标点达在虚拟小区面中', 'error');
//         
//		}
//	}
//}

//存储修改地址临时对象
var buildObj=null;
//散楼编辑
var buildMapOperate=function(){
	return {
		//散楼位置修改点击事件
		buildClick:function(addressSeq){
			mapUtil.clearClick('clear_All');
			//重新实例散楼信息存储对象
			buildObj=new Object;
			buildObj.addressSeq=addressSeq;
    	    //地图清理操作
    	    mapUtil.clearClick('clear_All');
    	    //将鼠标样式修改为图钉
    	    map.setMapCursor("url('images/map/addsymbol.cur'),help");
    		//添加散楼修改坐标地图点击事件
    	    buildMapClick=dojo.connect(map,'onClick',buildMapOperate.clickCallback);
		},
		//散楼位置修改点击事件回调函数
		clickCallback:function(evt){
			//恢复鼠标默认样式
			map.setMapCursor("default");
			//关闭点击事件
        	dojo.disconnect(buildMapClick);
        	//修改对象初始化值
        	buildMapClick=null;
        	//将定位坐标存储到
        	buildObj.evt=evt;
			//获取该散楼坐标点所在小区面ID
			communityOperate.getXYCommuntiy(evt);
		},
		//散楼保存函数
		buildFLSave:function(attr){
			var geometry=new esri.geometry.Point(buildObj.evt.mapPoint.x,buildObj.evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
			var graphic = new esri.Graphic(geometry);
			graphic.setAttributes(attr);
			buildFLLayer.applyEdits([graphic],null,null,buildMapOperate.saveCallBack(),buildMapOperate.error);
		},
		//散楼保存成功回调
		saveCallBack:function(evt){
			//刷新地图
			buildFLLayer.refresh();
			$.messager.show({
				title:'提示信息',
				msg:'散楼空间数据保存成功',
				timeout:1500,
				showType:'slide'
			});

		},
		//散楼操作异常处理
		error:function(evt){
			$.messager.alert('错误', '存储散楼空间数据时发生异常，请联系管理员', 'error');
		}
		
	}
}();




//infowindow显示模板
var mapModel=function (){
	
	return {
		getModel:function(evt){
			var content="";
			if(evt.graphic.attributes.IMG=="dingwei.png"){
				content=mapModel.getBuild(evt);
			}else{
				content=mapModel.getUnify(evt);
			}
			return content;
		},
		//小区显示模板
		getUnify:function(evt){
			var content="地址名称："+evt.graphic.attributes.NAME+"<br>"; 
			return content;
		},
		//散楼显示模板
		getBuild:function(evt){
			   var content="<table id='"+evt.graphic.attributes.ID+"_table'><tr><td style='width: 60px;'>地址全称：</td><td>"+mainApp.getValue(evt.graphic.attributes.NAME)+"</td></tr>" +
		   		"<tr><td>小区名称：</td><td>"+mainApp.getValue(evt.graphic.attributes.PARAMOBJ.data.COMMUNITYNAME)+"</td></tr>"+
			    "<tr><td>地址名称：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_a'  value='"+mainApp.getValue(evt.graphic.attributes.PARAMOBJ.data.BUILDINGNAME)+"'></td></tr> " +
		   		"<tr><td>街道：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_b' value='"+mainApp.getValue(evt.graphic.attributes.PARAMOBJ.data.ROADNAME)+"'></td></tr>" +
		   		"<tr><td>号：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_c' value='"+mainApp.getValue(evt.graphic.attributes.PARAMOBJ.data.ROADNO)+"'></td></tr>" +
		   		"<tr><td colspan='2'><a href='javascript:;' class='infowindow_a'  onClick='dataOperate.updateAddress("+evt.graphic.attributes.ID+")'>保存地址</a>" +
		   				"&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' class='infowindow_a'  onClick='dataOperate.updateBuildingDeal("+evt.graphic.attributes.ID+")'>确认匹配</a></td></tr></table>";
			   return content;
		}
		
		
	}
	
}();



/**
 * 地图工具类
 */
var mapUtil=function(){
	return {
		clearClickBtn:function(){
			mapUtil.clearClick('clear_All');
			$.messager.show({
				title:'提示信息',
				msg:'图层操作清理完成',
				timeout:1500,
				showType:'slide'
			});
		},
		clearClick:function(type){
			/*
			 * edit_Build  散楼修改坐标位置
			 * draw_Community 小区画面操作
			 * draw_Bubble 参考定位画气泡
			 * mapClick 地图点击事件（如查看小区和散楼对应关系）
			 * clear_All 清理地图所有事件
			 *         	
			 */
			var operateType=['editCommunity','community_Map_Click','build_Map_Click','draw_Community','draw_Bubble','map_Click','clear_All','close_infowindow','toolLayer'];
		    //恢复鼠标样式
			map.setMapCursor("default");
            for(var i=0;i<operateType.length;i++){
            	
            	if(operateType[i]!=type||operateType[i]=='clear_All'){
            		
            		
            		if(operateType[i]=='build_Map_Click'){
            			//清理修改散楼事件
            			mapUtil.clearBuildMapClick();
            		}else if(operateType[i]=='community_Map_Click'){
            			//清理小区点击事件
            			mapUtil.clearCommunityMapClick();
            		}else if(operateType[i]=='draw_Community'){
            			//清理小区画面操作
            			mapUtil.clearDrawCommunity();
            		}else if(operateType[i]=='draw_Bubble'){
            			//清理清理疯狂画气泡图层
            			mapUtil.clearDrawBubble();
            		}else if(operateType[i]=='map_Click'){
            			//清理修改地图点击事件
            			mapUtil.clearMapClick();
            		}else if(operateType[i]=='close_infowindow'){
            			//清理infowindow窗口
            			mapUtil.closeInfowindow();
            		
            		}else if(operateType[i]=='toolLayer'){
            			//清理infowindow窗口
            			mapUtil.clearToolLayer();
            			
            		}else if(operateType[i]=='editCommunity'){
            			//清理infowindow窗口
            			mapUtil.editCommunity();
            			
            		}
            		else{
            			if(operateType[i]!='clear_All'){
            			   $.messager.alert('提示', '地图清理操作传入参数异常，请联系管理员', 'info');
            			}
            		}	
            	  }
               }
		    },
		    clearCommunityMapClick:function(){
            	if(communityMapClick!=null){
              	   dojo.disconnect(communityMapClick);
                   CommunityMapClick=null;
              	}
		    }
      	    ,
        	clearToolLayer:function(){
        		toolLayer.clear();
        		map.graphics.clear();
        	},
            clearBuildMapClick:function(){
            	if(buildMapClick!=null){
            	  dojo.disconnect(buildMapClick);
            	  buildMapClick=null;
            	}
            },
            clearDrawCommunity:function(){
            	if(draw_toolbar){
	                //关闭画图工具
		            toolbar.deactivate();
		            draw_toolbar=false;
            	}
            },
            clearDrawBubble:function(){
            	//alert("清理气泡层");
            },
            clearMapClick:function(){
            	//alert("清理地图点击事件");
            },
            closeInfowindow:function(){
            	//alert("infowindow");
            	map.infoWindow.hide();
            },
            editCommunity:function(){           	
            	if(editCommunityMapClick!=null){           		
            		dojo.disconnect(editCommunityMapClick);           	
            	}
            	if(edit_toolbar){
	            	   editToolbar_communtity.deactivate();
	            	   edit_toolbar=false;
	            }
            }
	}
}();