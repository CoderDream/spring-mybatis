/**
 * Created by chenliwei on 2016/1/8
 */

 /**
  * 辅助方法，布局事件
  */
 var mainApp= function() {

		return {
			//左侧收缩触发事件
			onCollapse : function() {
				//收缩时进行地图resize
				mapApp.mapResize();
			}
		    ,
			//左侧展开后触发事件
			onExpand:function(){
				//收缩时进行地图resize
				mapApp.mapResize();
			},
			//获取当前格式化时间（输入格式2016/01/08 12：12：12）
			getNowFormatDate:function(){
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
			//如果为空或者undefined直接返回空字符串
			getValue:function(value){
				if(typeof(value) == "undefined"){
					value="";
				}
                return value;
			}
		}
}();


/**
 * 数据操作
 */
var dataOperate=function (){
	return {
		//查询地址信息定位
		getAddress:function(addressSeq){
			
			$.ajax({
		        type: "post",
		        dataType: "json",//返回json格式的数据
		        url: basePath+"Maintenance.do?method=getAddress",
		        data: {addressSeq:addressSeq},
		        beforeSend:function(){
				    //开启遮盖
					window.parent.document.getElementById("loading").style.display = "block";
		        },
		        complete :function(){
		        	//隐藏遮盖
		        	window.parent.document.getElementById("loading").style.display = "none";
		        	
		        },
		        success: function(data){
		        	//地图清理操作
		        	mapUtil.clearClick('clear_All');

	    		    //因为修改操作为批次操作，用户可以随意修改坐标以及地址数据
	    			var paramMapObj=new Object();
	    		    paramMapObj.data=data;
	    			paramMapObj.x=data.COORDINATEX;
	    			paramMapObj.y=data.COORDINATEY;	
	    			paramMapObj.title="定位地址";
	    			paramMapObj.img="dingwei.png";
	    			paramMapObj.name=data.ADDRESSFULLNAME;
	    			paramMapObj.id=data.ADDRESSSEQ;
	    			mapApp.drawBubble(paramMapObj);
	    			var zoom=14;
	    			if(map.getZoom()>13){
	    				zoom=map.getZoom();
	    			}
	    			//放大地图至指定点

	    			mapApp.gotoPoint(data.COORDINATEX,data.COORDINATEY,zoom);

		        },
		        error:function(data){    
		        	$.messager.alert('错误', '查询失败', 'error');
		        }
			});
		},
		//参考定位
		getReference:function(e){
			  var city = $('#city').combobox('getValue');
			  
			    if(city==""){
			    	 $.messager.alert('提示', '请选址项目对应城市', 'info');
			        return ;
			    } 
			    
				var communityKey = $(e).attr("ref");
				if(typeof(communityKey) == "undefined"){
					$.messager.alert('错误', '该位置无法进行参考定位', 'error');
					return;
				}
								
				$.ajax({
			        type: "post",
			        dataType: "json",//返回json格式的数据
			        url: basePath+"Maintenance.do?method=searchKeyName",
			        data: {"q":communityKey,cityId:city,keyType:2},//要发送的数据
			        beforeSend:function(){
					    //开启遮盖
						window.parent.document.getElementById("loading").style.display = "block";
			        },
			        complete :function(){
			        	//隐藏遮盖
			        	window.parent.document.getElementById("loading").style.display = "none";
			        	
			        },
			        success: function(data){//msg为返回的数据，在这里做数据绑定
						
			        	//地图清理操作
			        	mapUtil.clearClick('clear_All');
			        	//聚合使用X坐标集合
			        	var x_array=[];
			        	//聚合使用Y坐标集合
			        	var y_array=[];
			        	
			        	if(data.total!=0){
 
			        		var listhtml = "";
			        		var size=0;
			        		var j=0;
			        		var img_btn=['A','B','C','D','E','F','G','H','I','J'];
			        		$.each( data.jsondata, function(index, content){
 
			        			if(size>=10) {
			        				return;
			        			}

			        			//判断坐标是为空  地图相关处理
			            		if(parseFloat(content.x)*parseFloat(content.x)>1){
			                        
//			            			if(j==1){
//			            				content.x=13544417.8;
//			            				content.y=4706547.33;  
//			            			}
//			            			if(j==2){
//			            				content.x=13544413.8919;
//			            				content.y=4706222.5971;  
//			            			}
			            			 
			            			
			    					var paramObj=new Object();
			    					paramObj.x=content.x;
			    					paramObj.y=content.y;
			    					paramObj.title='参考定位';
			    					paramObj.img=img_btn[size]+".png";
			    					paramObj.name=content.fullname;
			    					paramObj.id=content.addressid;
			            			//画气泡
			    					mapApp.drawBubble(paramObj);
			            			//X坐标集合
			    	        		x_array[j]=parseFloat(content.x);
			            			//Y坐标集合
			    	        		y_array[j]=parseFloat(content.y);
			    	        		j++;
			            		}
			              		
			        			size++;
			        		});
			        		//如果返回的坐标集合都大于0进行聚集操作
			        		if(x_array.length>0&&y_array.length>0){
			        			//地图聚合
			            		mapApp.mapExtent_Array(x_array,y_array);	
			        		}

			        		}else{
			        			$.messager.alert('提示', '该地址无法进行参考定位', 'info');
			        	}
			        },
			        error:function(data){    
			        	$.messager.alert('错误', '查询失败', 'error');
			        }
				});
		},
		//显示小区关联散楼列表
		getShowRelation:function(communityId){
			
			
			$('#relationWin').window('open');
			
			$("#relationResult").datagrid({
		        height:370,
		        width:580,
		        idField:'ADDRESSSEQ',
		        //data: data,
		        url:'Maintenance.do?method=getAddressList&communityId='+communityId,
		        //singleSelect:false,
		        nowrap:true,
		        fitColumns:true,
		        rownumbers:true,
		        showPageList:false,
		        fixRowHeight:300,
		        pageSize:2000,
		        columns:[[
		            {field:'ADDRESSSEQ',title:'散楼编码',width:100,halign:"center", align:"left"},
		            {field:'ADDRESS_NAME',title:'散楼名称',width:100,halign:"center", align:"left",
		            	formatter: function(value,row,index){
		            		
		            		    row.ROADNAME= typeof(row.ROADNAME) != "undefined" ? row.ROADNAME : "";
		            		    row.ROADNO= typeof(row.ROADNO) != "undefined" ? row.ROADNO : "";
		            		    row.BUILDINGNAME= typeof(row.BUILDINGNAME) != "undefined" ? row.BUILDINGNAME : "";
		            		
								return "<span class='note'>"+row.ROADNAME+row.ROADNO+row.BUILDINGNAME+"</span>";
						}	
		            
		            },
		            {field:'COMMUNITYNAME',title:'小区名称',width:100,halign:"center", align:"left"} 
		        ]],
		        toolbar:'#win_tool_btn',
		        pagination:false
		    });
		},
		//地址小区关联操作
		relationCommunity:function(paramObj){
			
			$.ajax({
		        type: "post",
		        dataType: "json",//返回json格式的数据
		        url: basePath+"Maintenance.do?method=relationAddress",
		        data: paramObj,//要发送的数据
		        beforeSend:function(){
				    //开启遮盖
					window.parent.document.getElementById("loading").style.display = "block";
		        },
		        complete :function(){
		        	//隐藏遮盖
		        	window.parent.document.getElementById("loading").style.display = "none";
		        	
		        },
		        success: function(data){//msg为返回的数据，在这里做数据绑定
		    
                    //小区关联成功后将空间点存储到到空间表		        	
		        	if(data.status){
		        		
		        		dataOperate.getAddress(data.info.ADDRESSSEQ);
		        		
						var create_Date= mainApp.getNowFormatDate();
						var attr = {};
					    attr["ADDRESS_SEQ"] = data.info.ADDRESSSEQ;
					    attr["PROJECT_ID"] =data.info.PROJECTID;
					    attr["FILE_ID"] = data.info.FILEID; 
					    attr["ADDRESS_NAME"] =data.info.roadName+data.info.roadNo+data.info.building;
					    attr["STATUS_CD"] = 1;
					    attr["CREATE_DATE"] =create_Date
					    attr["CREATE_STAFF_ID"] = $("#staff_Id").val();
					    buildMapOperate.buildFLSave(attr)

		        	}else{
		            	$.messager.alert('错误', data.msg, 'error');
		        	}
		        },
		        error:function(data){    
		        	$.messager.alert('错误', '查询失败', 'error');
		        }
			});
		},
		//修改散楼地址状态为审核通过
		updateBuildingDeal:function(addressSeq){
			$.ajax({
		        type: "post",
		        dataType: "json",//返回json格式的数据
		        url: basePath+"Maintenance.do?method=updateBuildingDeal",
		        data: {addressSeq:addressSeq},//要发送的数据
		        beforeSend:function(){
				    //开启遮盖
					window.parent.document.getElementById("loading").style.display = "block";
		        },
		        complete :function(){
		        	//隐藏遮盖
		        	window.parent.document.getElementById("loading").style.display = "none";
		        	
		        },
		        success: function(data){//msg为返回的数据，在这里做数据绑定
		    	        	
		        	if(data.status){
		    			$.messager.show({
		    				title:'提示信息',
		    				msg:data.msg,
		    				timeout:2000,
		    				showType:'slide'
		    			});
					    //刷新列表
					    $('#searchResult').datagrid('reload');
		        	}else{
		            	$.messager.alert('错误', data.msg, 'error');
		        	}
		        },
		        error:function(data){    
		        	$.messager.alert('错误', '查询失败', 'error');
		        }
			});
		},
		//修改地址信息
		updateAddress:function(addressSeq){
			var paramMap=new Object();
			paramMap.addressSeq=addressSeq;
			paramMap.type='address';
			paramMap.buildingName=$('#'+addressSeq+'_a').val();
			paramMap.roadName=$('#'+addressSeq+'_b').val();
			paramMap.roadNo=$('#'+addressSeq+'_c').val();	
		    paramMap.addressName=$('#'+addressSeq+'_a').val()+$('#'+addressSeq+'_b').val()+$('#'+addressSeq+'_c').val();
		    dataOperate.updateAddress_date(paramMap);
		  },
		    //保存方法
			updateAddress_date:function(paramMap){
			$.ajax({
		        type: "post",//使用get方法访问后台
		        dataType: "json",//返回json格式的数据
		        url: basePath+"Maintenance.do?method=updateAddress",
		        data: paramMap,//要发送的数据
		        beforeSend:function(){
				    //开启遮盖
					window.parent.document.getElementById("loading").style.display = "block";
		        },
		        complete :function(){
		        	//隐藏遮盖
		        	window.parent.document.getElementById("loading").style.display = "none";		        	
		        },
		        success: function(data){//msg为返回的数据，在这里做数据绑定

		    	    //地图清理操作
		    	    mapUtil.clearClick('clear_All');
				    //刷新列表
				    $('#searchResult').datagrid('reload');
				    //提示修改成功
		        	if(data.status){
		        		//修改成功,500毫秒后消失
		        		$.messager.show({
		        			title:'提示',
		        			msg:data.msg,
		        			timeout:1500,
		        			showType:'slide'
		        		});

		        	}else{
		            	$.messager.alert('错误', data.msg, 'error');
		        	}
		        },
		        error:function(data){    
		        	$.messager.alert('错误', '查询失败', 'error');
		        }
			});
		},
		//获取地址ID序列(该方法使用同步事件)
		getAddressSeq:function(){
			
			var address_seq=null;
			
			$.ajax({
		        type: "post",//使用get方法访问后台
		        dataType: "json",//返回json格式的数据
		        url: basePath+"Maintenance.do?method=getAddressSeq",
		        async:false, 
		        beforeSend:function(){
				    //开启遮盖
					window.parent.document.getElementById("loading").style.display = "block";
		        },
		        complete :function(){
		        	//隐藏遮盖
		        	window.parent.document.getElementById("loading").style.display = "none";		        	
		        },
		        success: function(data){//msg为返回的数据，在这里做数据绑定

		        	address_seq= data.addressSeq;
		        },
		        error:function(data){    
		        	$.messager.alert('错误', '查询失败', 'error');
		        }
			});
			
			return address_seq;
		}
		
		  
		
	}
}();



