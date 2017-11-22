/**
 *散楼维护地图相关 
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
//画图工具
var toolbar, geometryService;
//面编辑工具
var editToolbar, ctxMenuForGraphics, ctxMenuForMap;
var selected, currentLocation;
//地图画图事件是否开启
var draw_Click=false;
//散楼图层
var incidentLayer=null;
//小区图层
var communtityLayer=null;
//17
//var ip="192.168.20.17";
//24
var ip="111.40.214.182";
/**
 * 初始化方法
 */
$(document).ready(function() {
        //获取初始化地图路径
    	mapApp.initUrl();
    	//初始化地图
	    mapApp.initMap();
	    //初始化地图画图方法
	    mapApp.initDrawMap();
	   
}); 


var mapApp=function () {
	
    return {
	        //初始化地图路径
    	    initUrl: function () {
				layerUrl = [];
				//底图
				layerUrl[0] = "http://111.40.214.168:6080/arcgis/rest/services/comm/China/MapServer";
				//地区区域图层
				//layerUrl[1] = "http://111.40.214.168:6080/arcgis/rest/services/beijing/address/MapServer";
			    //默认定位中心点
				center=[126.643228, 45.749201 ];
	        },
			//地图resize操作
			mapResize:function(){
				map.resize();
			    map.reposition();
			},
            //初始化地图
	        initMap:function(){
				   require( [ "esri/map", "esri/layers/ArcGISTiledMapServiceLayer","dojo/_base/lang",
							"dojo/number", "esri/geometry/webMercatorUtils",
							"esri/dijit/InfoWindow", "esri/layers/FeatureLayer",
							"esri/symbols/SimpleLineSymbol", "esri/geometry/Point",
							"esri/graphic", "esri/geometry/Extent","esri/geometry/Polygon","esri/layers/ArcGISDynamicMapServiceLayer","esri/layers/ImageParameters"], function(Map, ArcGISTiledMapServiceLayer,
							number, webMercatorUtils, lang,InfoTemplate, FeatureLayer,ArcGISDynamicMapServiceLayer,ImageParameters) {
					    //parser.parse();
					   //地图工具服务		
					   geometryService = new esri.tasks.GeometryService("http://111.40.214.168:6080/arcgis/rest/services/Utilities/Geometry/GeometryServer");
								 
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

				        var cityArea="{xmin:14069874.0762,ymin:5723732.9038,xmax:14131654.4081,ymax:5757136.6164,spatialReference:{wkid:3785}}";
				        mapApp.mapExtent(cityArea);
				        
				        //辅助定位层
				        locationlayer = new esri.layers.GraphicsLayer();
				        //循环添加小区点图层
		                for(var i=1;i<layerUrl.length;i++){
		                   tiledMapServicesXQ=new esri.layers.ArcGISDynamicMapServiceLayer(layerUrl[1], { id:"xqlayer", opacity:1, visible: true,name:"xqlid" })
		                   //设置显示图层
		                   tiledMapServicesXQ.setVisibleLayers([i]);
		                   //设置最小显示比例
		                   tiledMapServicesXQ.setMinScale(8000);
		                   //添加显示图层
		                   //map.addLayer(tiledMapServicesXQ);
		                  }
		            	//添加辅助图层到地图
		            	mapApp.locationMapAddLayer();
		            	
		            	//alert(ip);
		            	//添加散楼图层
		            	 var buildFL="http://"+ip+":6080/arcgis/rest/services/yp_address/ADDRESS_BUILDING/FeatureServer/0"
		            	   incidentLayer = new FeatureLayer(buildFL, {
		                     mode: FeatureLayer.MODE_ONDEMAND,
		                     outFields: ["*"],
		                     id: "buildFL",
		                     minScale:8000
		                   });
		            	 
		            	 incidentLayer.setDefinitionExpression("STATUS_CD = 1");
			            	//小区图层
		            	 var communtityFL="http://"+ip+":6080/arcgis/rest/services/yp_address/ADDRESS_BUILDING/FeatureServer/1"
		            		 communtityLayer = new FeatureLayer(communtityFL, {
		                     mode: FeatureLayer.MODE_ONDEMAND,
		                     outFields: ["*"],
		                     id: "communtityFL",
		                     minScale:8000
		                   });

		            	 //communtityLayer.setDefinitionExpression("STATUS_CD = 1");
		            	 
		            	   map.addLayers([communtityLayer]);
		                   map.addLayers([incidentLayer]);
		                   
		                   mapApp.isdrawClick();
		                   
		                   incidentLayer.on("click", function(evt) {
		                       var graphicAttributes = evt.graphic.attributes;
		                       flLocationMap(graphicAttributes.ADDRESS_SEQ);
                               
		                        
		                     
		                        
		                        
//	        					var content="<table ><tr><td>地址全称：</td><td>"+graphicAttributes.ADDRESS_FULLNAME+"</td></tr>" +
//	   					   		"<tr><td>地址名称：</td><td><input type='text' id='"+graphicAttributes.ADDRESS_SEQ+"_a' value='"+graphicAttributes.STREET_NAME+"'></td></tr> " +
//	   					   		"<tr><td>街道：</td><td><input type='text' id='"+graphicAttributes.ADDRESS_SEQ+"_b' value='"+graphicAttributes.ROAD_NAME+"'></td></tr>" +
//	   					   		"<tr><td>号：</td><td><input type='text' id='"+graphicAttributes.ADDRESS_SEQ+"_c' value='"+graphicAttributes.ROAD_NO+"'></td></tr>" +
//	   					   		"<tr><td><a href='javascript:;' class='infowindow_a'  onClick='saveAddress("+graphicAttributes.ADDRESS_SEQ+")'>保存地址</a></td></tr></table>";
//	                            map.infoWindow.setTitle("散户楼栋");
//	               				map.infoWindow.setContent(content);
//	               				map.infoWindow.anchor='upperright';
//	               				map.infoWindow.show(evt.graphic.geometry);

		                     });
		                   communtityLayer.on("click", function(evt) {
		                	   
			    	            //计算点面关系
		                	   if(document.getElementById("isEditLocation").checked==true){
			    	              mapApp.queryIncidentLayer(evt.graphic.geometry,evt.graphic.attributes.OBJECTID);
		                	   }else{
		                		         
//	                	          var editToolbar = new Edit(map);
//	                	          editToolbar.on("deactivate", function(evt) {
//	                	            if ( evt.info.isModified ) {
//	                	            	communtityLayer.applyEdits(null, [evt.graphic], null);
//	                	            }
//	                	          });
		                		   
//		                	    var graphicAttributes = evt.graphic.attributes;
//                               
//	        					var content= "小区名称："+graphicAttributes.NAME+"";
//	                            map.infoWindow.setTitle("小区名称");
//	               				map.infoWindow.setContent(content);
//	               				map.infoWindow.anchor='upperright';
//	               				map.infoWindow.show(evt.graphic.geometry);
		                	   }
		                     });
		                  
				      });
	        },
	        
	        //画图事件
	        isdrawClick:function (){
	        	
	        	require([	       
						"esri/map",
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
	        	       //  parser.parse();
	        	    
	        	         //function initEditing(evt) {
	        	           //var firePerimeterFL = map.getLayer("firePerimeterFL");
	        	          
	        	           var editToolbar_communtity = new Edit(map);
	        	           editToolbar_communtity.on("deactivate", function(evt) {
	        	             if ( evt.info.isModified ) {
	        	            	 communtityLayer.applyEdits(null, [evt.graphic], null);
	        	             }
	        	           });

	        	           var editingEnabled = false;
//	        	           communtityLayer.on("dbl-click", function(evt) {
//	        	        	   if(document.getElementById("isEditCommuntity").checked==true){
//			        	             event.stop(evt);
//			        	             if (editingEnabled === false) {
//			        	               editingEnabled = true;
//			        	               editToolbar_communtity.activate(Edit.EDIT_VERTICES , evt.graphic);
//			        	             } else {
//			        	            	 editToolbar_communtity.deactivate();
//			        	               editingEnabled = false;
//			        	             }
//	        	        	   }else{
//	        	        		   editToolbar_communtity.deactivate();
//		        	               editingEnabled = false;
//	        	        	   }
//	        	           });
	        	           
	        	           
	        	           
	        	        // }
	        	       });
	        }
	        ,
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        //地图点击事件
	        mapClick:function(e){
		    	require(["esri/symbols/PictureMarkerSymbol", "esri/graphic","esri/geometry/Point"
							], function(){ 
							var geometry=new esri.geometry.Point(e.mapPoint.x,e.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));

							//alert(dojo_map_click);
							//当用户未开启地图选址时才进行IdentifyTask操作
							if(dojo_map_click==null&&!draw_Click){
								//点选图层只点击1层
								var slayers=[1];
								//调用点选方法
								mapApp.queryiden(layerUrl[1],geometry,slayers);
							}

						}); 
		    	},
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
		    		     
                         //添加地图缩放级别监控，如当前地图级别小于13级结束画面操作
		    			 map.on("zoom", function(){
		    				 if(map.getZoom()<13&& draw_Click){
		    					 //结束画面操作
		    					 toolbar.deactivate();
				    	         map.showZoomSlider();
				    	         $.messager.alert('提示', '请不要在画小区图层时缩放地图', 'info');
				    	         draw_Click=false;
				    	         //将鼠标样式修改为图钉
				    	    	 map.setMapCursor("default");
		    				 }
		    				 
		    			 });

                           //实例化画图工具
		    		       toolbar = new Draw(map);
		    		       toolbar.on("draw-end", addDrawToMap);
		    		       
		    		       //给页面polygon对象添加点击事件
		    		        registry.byId("polygon").on("click", function() {	
		    					//清理修改坐标操作事件
		    					if(dojo_map_click!=null){
		    						dojo.disconnect(dojo_map_click);
		    						dojo_map_click=null;
		    						map.setMapCursor("default");
		    					}
		    		    	    //如果地图级别xiaoyu
			    		    	if(map.getZoom()<13){
			    		    	    $.messager.alert('提示', '当前地图显示级别不支持画取小区图层', 'info');
			    		    		return null;
			    		    	 }
			    		    	//
			    		    	 draw_Click=true;
			    		         toolbar.activate(Draw.POLYGON);
			    		         map.hideZoomSlider();
			    		         //将鼠标样式修改为图钉
			    		    	 map.setMapCursor("url('images/map/addsymbol.cur'),help");
		    		       });
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
			    	              //开启小区面编辑功能
			    	              mapApp.editMap(graphic);
			    	              
	                              //使用geometryService调用画面结束回调函数
			  		    	     geometryService.simplify([geometry], getLabelPoints);
		  		    	    }
		    		       
		  				 //画图结束调用事件
				    	 function getLabelPoints(geometries) {
				    	        if (geometries[0].rings.length > 0) {
				    	            geometryService.labelPoints(geometries, function(labelPoints) { // callback
				    	            //关闭画图工具
				    	            toolbar.deactivate();
				    	            map.showZoomSlider();
				    	            //将鼠标样式恢复
				    	       	    map.setMapCursor("default");
				    	          });
				    	        } else {
				    	      
				    	          $.messager.alert('提示', '最少需要选址三个点', 'info');
				    	        }
				    	        //标识关闭地图画图点击事件
				    	        draw_Click=false;
				    	      }

		    		     });
				    	},

				 //地图面编辑,右键菜单操作
				 editMap:function(labelPointGraphic){
					 //http://jshelp.thinkgis.cn/jssamples/graphics_contextmenu.html
					 require([ "esri/geometry/Point", "esri/geometry/Polygon", "esri/toolbars/draw", "esri/toolbars/edit",
					          "esri/symbols/SimpleMarkerSymbol", "esri/symbols/SimpleLineSymbol",
					          "esri/symbols/SimpleFillSymbol", "esri/graphic", "esri/geometry/jsonUtils",
					          "esri/Color", "dojo/parser", "dijit/Menu", "dijit/MenuItem", "dijit/MenuSeparator",					          
					          "dijit/form/Button", "dijit/layout/BorderContainer", "dijit/layout/ContentPane", 
					          "dojo/domReady!"
					        ], function(Point, Polygon, Draw, Edit, SimpleMarkerSymbol, SimpleLineSymbol, 
					          SimpleFillSymbol, Graphic, geometryJsonUtils,
					          Color, parser, Menu, MenuItem, MenuSeparator ) {

					          function createToolbarAndContextMenu() {
					            addGraphics();
					            editToolbar = new Edit(map);
					            createGraphicsMenu();
					          }

					          function createGraphicsMenu() {
					            // 创建右键按钮
					            ctxMenuForGraphics = new Menu({});
					            ctxMenuForGraphics.addChild(new MenuItem({ 
					              label: "编辑",
					              onClick: function() {
					                if ( selected.geometry.type !== "point" ) {
					                  editToolbar.activate(Edit.EDIT_VERTICES, selected);
					                } else {
					                
					                  $.messager.alert('提示', '请重新尝试编辑操作', 'info');
					                }
					              } 
					            }));

					            ctxMenuForGraphics.addChild(new MenuItem({ 
					              label: "移动",
					              onClick: function() {
					                editToolbar.activate(Edit.MOVE, selected);
					              } 
					            }));
					            
					            ctxMenuForGraphics.addChild(new MenuItem({ 
						              label: "保存",
						              onClick: function() {
	            	  
					            	  $.messager.prompt('保存小区', '请输入小区名称：', function(r){
					            			if (r){
							    	          	 var attr = {};
							    	             var create_Date= getNowFormatDate();
							    	             attr["NAME"] = r;
							    	             attr["STATUS_CD"] = 1;
							    	             attr["CREATE_DATE"] =create_Date
							    	             attr["CREATE_STAFF_ID"] = $("#staff_Id").val();
							    	         	  
							    	             var newGraphic = new Graphic(selected.geometry, null, attr);
							    	             communtityLayer.applyEdits([newGraphic], null, null);
							    	             //清理临时图层
							    	             map.graphics.clear();

					            				 return null;
					            			}else{
					            		       	 $.messager.alert('提示', '保存小区必须输入小区名称', 'info');
					            		         return null;
					            			}
					            	  });


						            	  
						            	  



							    	             
							    	            
							    	             


						              } 
						            }));

//					            ctxMenuForGraphics.addChild(new MenuItem({ 
//					              label: "Rotate/Scale",
//					              onClick: function() {
//					              if ( selected.geometry.type !== "point" ) {
//					                  editToolbar.activate(Edit.ROTATE | Edit.SCALE, selected);
//					                } else {
//					                  alert("Not implemented");
//					                }
//					              }
//					            }));
//
//					            ctxMenuForGraphics.addChild(new MenuItem({ 
//					              label: "Style",
//					              onClick: function() {
//					                alert("Not implemented");
//					              }
//					            }));
					          
					           // ctxMenuForGraphics.addChild(new MenuSeparator());
					            ctxMenuForGraphics.addChild(new MenuItem({ 
					              label: "删除",
					              onClick: function() {
					            	  map.graphics.clear();
					                  map.graphics.remove(selected);
					              }
					            }));

					            ctxMenuForGraphics.startup();

					            map.graphics.on("mouse-over", function(evt) {
					              selected = evt.graphic;          
					              ctxMenuForGraphics.bindDomNode(evt.graphic.getDojoShape().getNode());
					            });

					            map.graphics.on("mouse-out", function(evt) {
					              ctxMenuForGraphics.unBindDomNode(evt.graphic.getDojoShape().getNode());
					            });
					          }

					          // Helper Methods
//					          function getMapPointFromMenuPosition(box) {
//					            var x = box.x, y = box.y;
//					            switch( box.corner ) {
//					              case "TR":
//					                x += box.w;
//					                break;
//					              case "BL":
//					                y += box.h;
//					                break;
//					              case "BR":
//					                x += box.w;
//					                y += box.h;
//					                break;
//					            }
//
//					            var screenPoint = new Point(x - map.position.x, y - map.position.y);
//					            return map.toMap(screenPoint);
//					          }
					          
					          function addGraphics() {
					            // Adds pre-defined geometries to map
					            var polygonSymbol = new SimpleFillSymbol(
					              SimpleFillSymbol.STYLE_SOLID, 
					              new SimpleLineSymbol(
					                SimpleLineSymbol.STYLE_DOT, 
					                new Color([151, 249, 0, 0.8]),
					                3
					              ), 
					              new Color([151, 249, 0, 0.45])
					            );
					            
			    	            map.graphics.add(labelPointGraphic);
					          }
					          
					          createToolbarAndContextMenu();
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
            
            queryIncidentLayer:function (selectedGeometry,objectId){
	             var query = new esri.tasks.Query();
	             query.geometry = selectedGeometry;
	             incidentLayer.selectFeatures(query,esri.layers.FeatureLayer.SELECTION_NEW,function(features){
	               //calculate the convex hull
	               var array=new Array();
	               for(var i=0;i<features.length;i++){
	            	   
//	            	   var relationObj=new  relationJson(features[i].attributes.ADDRESS_SEQ,features[i].attributes.addressName);
//	            	   array.push(relationObj);
	            	   array.push(features[i].attributes);
	               }
	            
	               //弹出层
	               if(features.length>0){
	                  getAddressWindow(array,objectId);
	               }
	             
//	            	 
//	            	 
//	               var points = dojo.map(features,function(feature){
//	                 return feature.geometry;
//	               });
//	               geometryService.convexHull(points,function(result){
//	                 var symbol;
//	                 switch(result.type){
//	                   case "point":
//	                     symbol = new esri.symbol.SimpleMarkerSymbol();
//	                     break;
//	                   case "polyline":
//	                     symbol = new esri.symbol.SimpleLineSymbol();
//	                     break;
//	                   case "polygon":
//	                     symbol = new esri.symbol.SimpleFillSymbol();
//	                     break;
//	                 }
//	                 map.graphics.add(new esri.Graphic(result,symbol));
//	                 
//	                 
//	               },function(error){
//	                 console.log("An error occured during convex hull calculation");
//	               });        
	             });

            },
            //开始画气泡
			locationMap:function(paramObj){
				
				//清理点击操作
				if(dojo_map_click!=null){
					dojo.disconnect(dojo_map_click);
					dojo_map_click=null;
					map.setMapCursor("default");
				}
				
				
				   require(["esri/symbols/PictureMarkerSymbol", "esri/graphic","esri/geometry/Point"
							], function(){ 
							var geometry=new esri.geometry.Point(paramObj.x,paramObj.y, new esri.SpatialReference({ wkid: 3785 }));
							var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol("images/map/"+paramObj.img+"", 18, 18);
							var gra = new esri.Graphic(geometry, pictureMarkerSymbol);
							gra.setAttributes( {"NAME":paramObj.name,"ID":paramObj.id,"TITLE":paramObj.title,"IMG":paramObj.img,"PARAMOBJ":paramObj});
							//map.graphics.add(gra)
							//将气泡点添加到临时图层
							locationlayer.add(gra);
							//如果是新增加小区自动打开infowindw
							if(paramObj.img=="dingwei.png"){
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
				//显示模板
				if(evt.graphic.attributes.IMG=="dingwei.png"){
					
					   //处理返回值undefined 问题
						if(typeof(evt.graphic.attributes.PARAMOBJ.data.BUILDINGNAME) == "undefined"){
							evt.graphic.attributes.PARAMOBJ.data.BUILDINGNAME="";
						}
		                if(typeof(evt.graphic.attributes.PARAMOBJ.data.ROADNO) == "undefined"){
		                	evt.graphic.attributes.PARAMOBJ.data.ROADNO="";
						}
						
						if(typeof(evt.graphic.attributes.PARAMOBJ.data.ROADNAME) == "undefined"){
							evt.graphic.attributes.PARAMOBJ.data.ROADNAME="";
						}
	
					   var content="<table id='"+evt.graphic.attributes.ID+"_table'><tr><td>地址全称：</td><td>"+evt.graphic.attributes.NAME+"</td></tr>" +
					   		"<tr><td>地址名称：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_a'  value='"+evt.graphic.attributes.PARAMOBJ.data.BUILDINGNAME+"'></td></tr> " +
					   		"<tr><td>街道：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_b' value='"+evt.graphic.attributes.PARAMOBJ.data.ROADNAME+"'></td></tr>" +
					   		"<tr><td>号：</td><td><input type='text' id='"+evt.graphic.attributes.ID+"_c' value='"+evt.graphic.attributes.PARAMOBJ.data.ROADNO+"'></td></tr>" +
					   		"<tr><td><a href='javascript:;' class='infowindow_a'  onClick='saveAddress("+evt.graphic.attributes.ID+")'>保存地址</a></td></tr></table>";	
				}
				else{
				       var content="地址名称："+evt.graphic.attributes.NAME+"<br>"; 		
				}
				map.infoWindow.setTitle(evt.graphic.attributes.TITLE);
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
    //分割坐标
	var p_XY= p_XY.split(",")
	//传入参数
	var paramObj=new Object();
	paramObj.x=p_XY[0];
	paramObj.y=p_XY[1];
	paramObj.title=$(e).text();
	paramObj.img=$(e).attr("img");
	paramObj.name=$(e).attr("title");
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

//存储点选前地址信息
var addressParamInfo=null;
/**
 * 地图选址事件
 */
function loadClick(){
	
	 //关闭画面操作
	 if(draw_Click){
	  toolbar.deactivate();
      map.showZoomSlider();
      draw_Click=false;
	 }
    //将鼠标样式修改为图钉
	 map.setMapCursor("default");
	
	 //添加地图点击事件
	 dojo_map_click=dojo.connect(map,'onClick',addXQ);
     //将鼠标样式修改为图钉
	 map.setMapCursor("url('images/map/addsymbol.cur'),help");
}
/**
 * 地图选址事件点击回调
 */
function addXQ(evt){
	
	//将鼠标样式修改为默认
	map.setMapCursor("default");
	dojo.disconnect(dojo_map_click);
	dojo_map_click=null;
	
	var roadName="",roadNo="",building="";
	if(typeof(addressParamInfo.ROADNAME) != "undefined")
	{
		roadName=addressParamInfo.ROADNAME;
	}
	if(typeof(addressParamInfo.ROADNO) != "undefined")
	{
		roadNo=addressParamInfo.ROADNO;
	}
	if(typeof(addressParamInfo.BUILDINGNAME) != "undefined")
	{
		building=addressParamInfo.BUILDINGNAME;
	}
	
	var create_Date= getNowFormatDate();
	var attr = {};
    attr["ADDRESS_SEQ"] = addressParamInfo.ADDRESSSEQ;
    attr["PROJECT_ID"] =addressParamInfo.PROJECTID;
    attr["FILE_ID"] = addressParamInfo.FILEID; 
    attr["ADDRESS_NAME"] =roadName+roadNo+building;
    attr["STATUS_CD"] = 1;
    attr["CREATE_DATE"] =create_Date
    attr["CREATE_STAFF_ID"] = $("#staff_Id").val();

    
	var paramObj=new Object();
	paramObj.type='xy';
	paramObj.coordinateX=evt.mapPoint.x;
	paramObj.coordinateY=evt.mapPoint.y;
	paramObj.addressSeq=addressParamInfo.ADDRESSSEQ;
	paramObj.createDate=create_Date;
 
	var geometry=new esri.geometry.Point(evt.mapPoint.x,evt.mapPoint.y, new esri.SpatialReference({ wkid: 3785 }));
	var graphic = new esri.Graphic(geometry);
	graphic.setAttributes(attr);
	incidentLayer.applyEdits([graphic],null,null,incCallBack(paramObj),error);
	
    //因为修改操作为批次操作，用户可以随意修改坐标以及地址数据
//	var paramMapObj=new Object();
//    paramMapObj.data=addressParamInfo;
//	paramMapObj.x=evt.mapPoint.x;
//	paramMapObj.y=evt.mapPoint.y;
//	paramMapObj.title="定位地址";
//	paramMapObj.img="marker.png";
//	paramMapObj.name=addressParamInfo.ADDRESSFULLNAME;
//	paramMapObj.id=addressParamInfo.ADDRESSSEQ;
//	mapApp.locationMap(paramMapObj);
	
	var zoom=13;
	if(map.getZoom()>12){
		zoom=map.getZoom();
	}
	//放大地图至指定点
	mapApp.gotoPoint(evt.mapPoint.x,evt.mapPoint.y,zoom);
	

	

	
}
//applyEdits(adds?, updates?, deletes?, callback?, errback?)
//添加空间表成功后修改原表值
function incCallBack(paramObj){
	
	updateAddress(paramObj);
	
	incidentLayer.refresh();
	
}

function error(e){
	
	alert("操作异常");
	
}

//获取时间格式化方法
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "/";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
}
	
//function relationJson(addressSeq,addressName){
//	this.addressSeq=addressSeq;
//	this.addressName=addressName;
//}