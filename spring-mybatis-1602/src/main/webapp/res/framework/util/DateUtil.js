function getjsession()
{
	var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear()+""+ month +""+strDate+""+date.getHours()+""+date.getMinutes()+""+date.getSeconds();
    return currentdate;
}

/**
 * 向date对象中加入自定义日期格式化方法
 */
Date.prototype.format = function(format) {
    var date = {
           "M+": this.getMonth() + 1,
           "d+": this.getDate(),
           "h+": this.getHours(),
           "m+": this.getMinutes(),
           "s+": this.getSeconds(),
           "q+": Math.floor((this.getMonth() + 3) / 3),
           "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
           if (new RegExp("(" + k + ")").test(format)) {
                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
           }
    }
    return format;
}

/**
 * 格式化日期
 */
var formatterDate=function(val, row) {
	
    var date = new Date();
	date.setTime(val)
    return date.toLocaleDateString();
}

/**
 * 格式化日期
 * @param val
 * @param row
 * @param index
 * @returns {String}
 */
function dateFormat(val, row, index) {
	if (val == undefined || null == val) {
		return "";
	}
	var unixTimestamp = new Date(val.time);
	var str = unixTimestamp.getFullYear() + "-";
	if(unixTimestamp.getMonth()+1 < 10){
		str +="0";
	}
	str += (unixTimestamp.getMonth()+1) + "-";
	if(unixTimestamp.getDate() < 10){
		str +="0";
	}
	str += unixTimestamp.getDate() ;
	return str;
}