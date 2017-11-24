

/**
 * 获取用户业务类型下拉框
 */
function loadCbox(comboboxName,code,value,text){
	$(comboboxName).combobox({
        url: basepath+'enum.do?method=getJsonCombox&code='+code,
        valueField: value,
        textField: text
    });
}

/**
 * 获取用户业务类型下拉框
 */
function loadLocalCbox(comboboxName,code,value,text){
	//alert("loadLocalCbox");
	$(comboboxName).combobox({
        url: basepath+'enum.do?method=getLocalJsonCombox&jsession='+new Date().getTime()+'&code='+code,
        valueField: value,
        textField: text
    });
}