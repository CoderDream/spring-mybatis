/***********************************************************
 *
 * 自定义扩展easyui的验证规则
 *
 ***********************************************************/
$.extend($.fn.validatebox.defaults.rules, {
	idcard : {// 验证身份证 
        validator : function(value) { 
            return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value); 
        }, 
        message : '身份证号码格式不正确' 
    },
    equalsTo: { //<input name="xx" validType="equals['#pwd']"/> 
        validator: function(value,param){
            return value == $(param[0]).val();
        },
        message: '两次输入的内容不一致'
    },
    minLength: {
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: '请输入至少{0}个字符'
    },
    maxLength:{
		validator : function(value,param){
			return value.length<=param[0]
		},
		message:'最多{0}个字'
	},
    length:{
    	validator : function(value,param){ 
        var len=$.trim(value).length; 
            return len>=param[0]&&len<=param[1]; 
        }, 
        message:"输入内容长度必须介于{0}和{1}之间" 
    },
    range:{ //验证数字的范围
		validator: function(value,param){
			if(/^[1-9]\d*$/.test(value)){
				return value >= param[0] && value <= param[1]
			}else{
				return false;
			}
		},
		message:'输入的数字在{0}到{1}之间'
	},
    phone: {// 验证固定电话号码 
        validator : function(value) { 
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value); 
        }, 
        message : '格式不正确,请使用下面格式:020-88888888' 
    }, 
    mobile: {// 验证手机号码 
        validator : function(value) { 
            return /^(13|15|18)\d{9}$/i.test(value); 
        }, 
        message : '手机号码格式不正确' 
    }, 
    intOrFloat: {// 验证整数或小数 
        validator : function(value) { 
            return /^\d+(\.\d+)?$/i.test(value); 
        }, 
        message : '请输入数字，并确保格式正确' 
    }, 
    integer: {// 验证整数 
    	validator : function(value) { 
	    	return /^[+]?[1-9]+\d*$/i.test(value); 
	    }, 
	    message : '请输入整数' 
    },
    number: { //验证数字（整数或小数）
		validator: function (value, param) {
			return /^[0-9]+.?[0-9]*$/.test(value);
		},
		message: '请输入数字'
	},
    currency: {// 验证货币 
        validator : function(value) { 
            return /^\d+(\.\d+)?$/i.test(value); 
        }, 
        message : '货币格式不正确' 
    }, 
    qq : {// 验证QQ,从10000开始 
        validator : function(value) { 
            return /^[1-9]\d{4,9}$/i.test(value); 
        }, 
        message : 'QQ号码格式不正确' 
    }, 
    age : {// 验证年龄
        validator : function(value) { 
            return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value); 
        }, 
        message : '年龄必须是0到120之间的整数' 
    }, 
    chinese : {// 验证中文 
        validator : function(value) { 
            return /^[\Α-\￥]+$/i.test(value); 
        }, 
        message : '请输入中文' 
    }, 
    english : {// 验证英语 
        validator : function(value) { 
            return /^[A-Za-z]+$/i.test(value); 
        }, 
        message : '请输入英文' 
    }, 
    unnormal : {//验证是否包含空格和非法字符 
        validator : function(value) { 
            return /.+/i.test(value); 
        }, 
        message : '输入值不能为空和包含其他非法字符' 
    }, 
    username : {// 验证用户名 
	    validator: function (value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message: '登录名称只允许汉字、英文字母、数字及下划线。'
    },
    safepass: { //密码由字母和数字组成，至少6位 
        validator: function (value, param) {
            return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/.test(value));
        },
        message: '密码由字母和数字组成，至少6位'
    },
    faxno : {// 验证传真 
        validator : function(value) { 
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value); 
        }, 
        message : '传真号码不正确' 
    }, 
    zip : {// 验证邮政编码 
        validator : function(value) { 
            return /^[1-9]\d{5}$/i.test(value); 
        }, 
        message : '邮政编码格式不正确' 
    }, 
    ip : {// 验证IP地址 
        validator : function(value) { 
            return /d+.d+.d+.d+/i.test(value); 
        }, 
        message : 'IP地址格式不正确' 
    }, 
    name : {// 验证姓名，可以是中文或英文 
        validator : function(value) { 
            return /^[\Α-\￥]+$/i.test(value)|/^\w+[\w\s]+\w+$/i.test(value); 
        }, 
        message : '请输入姓名' 
    },
    date : {// 验证姓名，可以是中文或英文 
        validator : function(value) { 
         	//格式yyyy-MM-dd或yyyy-M-d
            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value); 
        },
        message : '清输入合适的日期格式'
    },
    msn:{
        validator : function(value){ 
        	return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value); 
    	}, 
    	message : '请输入有效的msn账号(例：abc@hotnail(msn/live).com)' 
    },
    email:{
    	validator : function(value){ 
	    	return /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test( value ); 
	    }, 
	    message : '请输入有效的email地址(例：abc@hotnail.com)' 
    },
    same:{ 
        validator : function(value, param){ 
            if($("#"+param[0]).val() != "" && value != ""){ 
                return $("#"+param[0]).val() == value; 
            }else{ 
                return true; 
            } 
        }, 
        message : '两次输入的密码不一致！'    
    },
    radio: { //validType="radio['字段名']"
        validator: function (value, param) {
            var ok = false;
            var eleName=param[0];
            return $(":radio[name='" + eleName + "']:checked").size()>0;
        },
        message: '需要选择一项！'
    },
    checkbox: { //validType="checkbox['字段名', 最小选中数]"
        validator: function (value, param) {
    		var eleName=param[0], minCheckNum = param[1];
    		var checkNum=$(":checkbox[name='" + eleName + "']:checked").size(); //:checked前面有空格不行
    		return checkNum>=minCheckNum;
        },
        message: '至少选择{1}项'
    },
    select: { //validType="select['字段名', 最小选择数]"
        validator: function (value, param) {
    		var eleName=param[0], minSelectNum = param[1];
    		var selectNum=$("select[name='" + eleName + "'] :selected").size(); //:selected紧挨在一起不行
    		return selectNum>=minSelectNum;
        },
        message: '至少选择{1}项'
    }
});