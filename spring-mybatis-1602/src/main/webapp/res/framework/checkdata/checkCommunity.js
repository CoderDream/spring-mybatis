var data={"total":27,"rows":[
    {"userId":"1","userName":"Koi","name":"管理员","sex":"男","department":"Large"},
    {"userId":"2","userName":"Dalmation","name":"管理员","sex":"男","department":"Spotted Adult Female"},
    {"userId":"3","userName":"Rattlesnake","name":"管理员","sex":"男","department":"Venomless"},
    {"userId":"4","userName":"Rattlesnake","name":"管理员","sex":"男","department":"Rattleless"}
]};



$(function(){
    $("#searchResult").datagrid({
        height:$("#body").height(),
        width:$("#body").width(),
        idField:'userId',
        data: data,
        fit: true,
        //url:"datagrid.json",
        singleSelect:false,
        nowrap:true,
        fitColumns:true,
        rownumbers:true,
        showPageList:false,
        fixRowHeight:300,
        pageSize:15,
        columns:[[
            {field:'ck',checkbox:true},
            {field:'userName',title:'用户名',width:100,halign:"center", align:"left"},
            {field:'name',title:'姓名',width:100,halign:"center", align:"left"},
            {field:'sex',title:'性别',width:100,halign:"center", align:"left"},
            {field:'department',title:'部门',width:100,halign:"center", align:"left"}
        ]],
        toolbar:'#tt_btn',
        pagination:true,
        onDblClickRow:function(rowIndex, rowData){
            viewDetail(rowData.userId);
        }
    });
})