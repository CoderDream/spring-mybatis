package com.olts.commons;

public class StringUtil {
	/**
	 * 检查指定字符串是否为null或 ""
	 * @param source
	 * @return  null或""返回 true, 否则返回false
	 */
	public static boolean isEmpty(String source){
		if(source==null || source.trim().length()==0){//
			return true;
		}
		return false;
	}

	/**
	 * 检查指定字符串是否不为null或 ""
	 * @param source
	 * @return
	 */
	public static boolean isNotEmpty(String source){
		return (!isEmpty(source));
	}

	public static int toInt(String source){
		if (isNotEmpty(source)) {
			return Integer.parseInt(source);
		}
		return 0;
	}

	public static double toDouble(String source){
		if (isNotEmpty(source)) {
			return Double.parseDouble(source);
		}
		return 0;
	}
	
	public static Long toLong(String source){
		if (isNotEmpty(source)) {
			return Long.parseLong(source);
		}
		return (long) 0;
	}

}
