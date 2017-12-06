package com.chinazhoufan.admin.common.utils;


import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;

import java.util.Random;

/**
 * 周范密钥工具
 * 当前工具仅适用于对接第三方平台签名
 * @author  杨晓辉
 * @date 创建时间：2017年5月24日 上午11:04:08 
 * @version 2.0.0 
 */
public class ZFSecretKeyUtils {
	
	private static final String ZHOUFAN_WECHAT_KEY="814AF29F21D1BB708165BD2E012861E2";
	
	private static final String ZHOUFAN_ZJS_KEY="22DEF80C7C17B0E491AFCCDEB1729CEE";
	
	private static final String[] PARAM={"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	
	/**
	 * 获取微信支付密钥
	 * 每笔订单均可获取
	 * 微信订单查询也使用该KEY
	 * @return 密钥
	 */
	public static String getWechatPayKey(){
		String randomStr="";
		StringBuffer stringBuffer=new StringBuffer();
		Random random=new Random();
		for(int i=0;i<5;i++){
			int x=(int)(Math.random()*35);
			stringBuffer.append(PARAM[x]);
		}
		String md5=Md5.toMd5(WeiXinConfig.D_S_APP_SECRET+""+stringBuffer.toString()+""+ZHOUFAN_WECHAT_KEY);
		md5=md5.substring(0,md5.length()-5)+stringBuffer.toString();
		return md5.toUpperCase();
	}
	
	/**
	 * 微信支付key检测
	 * @param key			支付时交给微信的KEY，且微信回调时返回
	 * @return 正确或错误
	 */
	public static boolean valiWechatPayKey(String key){
		String random=key.substring(key.length()-5,key.length()).toLowerCase();
		String md5=Md5.toMd5(WeiXinConfig.D_S_APP_SECRET+""+random+""+ZHOUFAN_WECHAT_KEY);
		md5=(md5.substring(0,md5.length()-5)+random).toUpperCase();
		return md5.equals(key);
	}
	
}
