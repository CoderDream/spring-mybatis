/**
 * 常用方法
 */

/**
 * 判断空
 * @param {String} val
 * @returns {Boolean}
 */
function isNull(val){
	if(!val){
		return true;
	}
	if(val == null || val == "" || val == "undefined" || val == "null" || val == "NULL"){
		return true;
	}
	return false;
}