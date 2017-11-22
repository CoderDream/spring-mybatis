/**
 * Created by chenliwei on 2016/1/8
 */
 
/**
 * 查询列表
 */
function search(){
    mapUtil.clearClick('clear_All');	

    //获取表格应该设置高度
    var heigth = window.document.getElementById('cc').offsetHeight-165;
    //获取用户输入楼栋名称
    var communityKeyId=$('#communityKey').combobox('getValue');
    //获取下拉框的值
    var is_verify=$('#is_verify').combobox('getValue');
     
    var urlStr='';
    
	var project = $('#project').combobox('getValue');
    if(project==""){
        $.messager.alert('提示', '请选择项目名', 'info');
        return ;
    }
    var city = $('#city').combobox('getValue');
    if(city==""){
        $.messager.alert('提示', '请选择城市', 'info');
        return ;
    } 
    
	if(typeof(communityKeyId) == "undefined"){
		communityKeyId=null;
	}else{
	    urlStr='&is_verify='+is_verify+'&communityKeyId='+communityKeyId+'&project='+project+'&city='+city;
	}
 
    //将数据灌入表格中
	$("#searchResult").datagrid({
	    height:heigth,
	    idField:'ADDRESSSEQ',
	    //data: data,
	    url:'Maintenance.do?method=getCommunityKeyList'+urlStr,
	    singleSelect:true,
	    nowrap:true,
	    fitColumns:true,
	    rownumbers:true,
	    showPageList:false,
	    fixRowHeight:300,
	    pageSize:15,
	    columns:[[
	        //{field:'ck',checkbox:true}, 
	        {field:'ADDRESSSEQ',hidden:true},
	        {field:'ADDRESSFULLNAME',title:'散楼全名',width:160,halign:"center", align:"center",
	        	formatter: function(value,row,index){	        		
	        		if(typeof(value) != "undefined"){
						return "<span class='note' title='"+value+"'>"+value+"</span>";
	        		}else{
	        			return "<span class='note'></span>";
	        		}
				}	
	        },
           {field:'COORDINATEX',title:'操作',width:60,halign:"center", align:"center",        	
	        	formatter: function(value,row,index){
	        		if(row.ISVERIFY){
    				    return "<button onClick='dataOperate.getAddress("+row.ADDRESSSEQ+")'>定位</button>";
	        		}else{	  
	        		    return "<button   onClick='buildMapOperate.buildClick("+row.ADDRESSSEQ+")'>上图</button>";
	        		}
	        		//如果已经关联小区只能进行定位操作
	        	/*	if(row.ISVERIFY){
    				    return "<button onClick='dataOperate.getAddress("+row.ADDRESSSEQ+")'>坐标定位</button>";
	        		}
	        		//如果坐标信息为空只能进行移动和参考定位
        			if(typeof(row.COORDINATEX) == "undefined"||typeof(row.COORDINATEY) == "undefined"){  
        				//如果街道为空只能修改坐标位置，不能进行参考定位
                        if(typeof(row.ROADNAME) != "undefined"){
            				return "<button ref='"+row.ROADNAME+"' onClick='dataOperate.getReference(this)'>位置参考</button><button  ref='"+row.ADDRESSSEQ+",1' onClick='buildMapOperate.buildClick("+row.ADDRESSSEQ+")'>匹配小区</button>";
                        }else{
            				return "<button   onClick='buildMapOperate.buildClick("+row.ADDRESSSEQ+")'>匹配小区</button>";
    	        		} 
        			}else{
        				    return "<button   onClick='buildMapOperate.buildClick("+row.ADDRESSSEQ+")'>匹配小区</button><button  onClick='dataOperate.getAddress("+row.ADDRESSSEQ+")'>坐标定位</button>";
        			}*/
				}

	        }
	    ],],
	    toolbar:'#tt_btn',
	    pagination:true,
	    onDblClickRow:function(rowIndex, rowData){
	        //viewDetail(rowData.userId);
	    },
        onLoadSuccess:function(data)
        {
            $(".note").tooltip(
                {
                onShow: function(){
                    $(this).tooltip('tip').css({ 
                        width:'300',
                        boxShadow: '1px 1px 3px #292929'                        
                    });
                }
            }
            );
         }

	});
}





/**
 * 批量查询查询列表
 */
function search_batch(){
    mapUtil.clearClick('clear_All');	

    //获取表格应该设置高度
    var heigth = window.document.getElementById('cc').offsetHeight-165;
    //获取用户输入楼栋名称
    var communityKeyId=$('#communityKey').combobox('getValue');
    //获取下拉框的值
    var is_verify=$('#is_verify').combobox('getValue');
     
    var urlStr='';
    
	var project = $('#project').combobox('getValue');
    if(project==""){
        $.messager.alert('提示', '请选择项目名', 'info');
        return ;
    }
    var city = $('#city').combobox('getValue');
    if(city==""){
        $.messager.alert('提示', '请选择城市', 'info');
        return ;
    } 
    
	if(typeof(communityKeyId) == "undefined"){
		communityKeyId=null;
	}else{
		//alert(communityKeyId);
// (#{cityId}))and t.OPERATE_STAFF_ID=#{staffId})
	    urlStr='&is_verify='+is_verify+'&communityKeyId='+communityKeyId+'&projectId='+project+'&cityId='+city;
	}
 
    //将数据灌入表格中
	$("#searchResult").datagrid({
	    height:heigth,
	    idField:'ADDRESSSEQ',
	    //data: data,
	    url:'Maintenance.do?method=getCommunityKeyList_Batch'+urlStr,
	    singleSelect:true,
	    nowrap:true,
	    fitColumns:true,
	    rownumbers:true,
	    showPageList:false,
	    fixRowHeight:300,
	    pageSize:15,
	    columns:[[

	        {field:'KEYID',hidden:true},
	        {field:'COMMUNITYKEY',title:'散楼全名',width:160,halign:"center", align:"center",
	        	formatter: function(value,row,index){	        		
	        		if(typeof(value) != "undefined"){
						return "<span class='note' title='"+value+"'>"+value+"</span>";
	        		}else{
	        			return "<span class='note'></span>";
	        		}
				}	
	        },
           {field:'option',title:'操作',width:100,halign:"center", align:"center",        	
	        	formatter: function(value,row,index){	        			        		
    				    return "<button ref='"+row.COMMUNITYKEY+"' onClick='dataOperate.getReference(this)'>参考</button>" +
    				    		"<button onClick='batchKey.batchKeyClick("+row.KEYID+")'>批量定位</button>";
				}

	        }
	    ],],
	    toolbar:'#tt_btn',
	    pagination:true,
	    onDblClickRow:function(rowIndex, rowData){
	        //viewDetail(rowData.userId);
	    },
        onLoadSuccess:function(data)
        {
            $(".note").tooltip(
                {
                onShow: function(){
                    $(this).tooltip('tip').css({ 
                        width:'300',
                        boxShadow: '1px 1px 3px #292929'                        
                    });
                }
            }
            );
         }

	});
}