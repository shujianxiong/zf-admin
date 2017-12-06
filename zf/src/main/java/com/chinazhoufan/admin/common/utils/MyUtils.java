package com.chinazhoufan.admin.common.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 全局工具类
 * @author 杨晓辉
 *
 */

public class MyUtils {

	/*** 
     * 判断 String 是否是 int 
     *  
     * @param input 
     * @return 
     */  
    public static boolean isInteger(String input){  
    	if(StringUtils.isBlank(input))
    		return true;
        Matcher mer = Pattern.compile("^[+-]?[0-9]+$").matcher(input);  
        return mer.find();  
    } 
    
}
