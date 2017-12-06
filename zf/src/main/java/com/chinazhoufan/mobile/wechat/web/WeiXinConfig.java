package com.chinazhoufan.mobile.wechat.web;

import com.chinazhoufan.admin.common.mpsdk4j.vo.MPAccount;

public class WeiXinConfig {
	
	/**
	 * 订阅号类型
	 */
	public static final String MP_TYPE_D="D";
	
	/**
	 * 企业号类型
	 */
	public static final String MP_TYPE_E="E";
	
	/**
	 * 服务号类型
	 */
	public static final String MP_TYPE_S="S";
	
	/**
	 * D_A 为周范订阅号 zty537@126.com 
	 */
	public static final String ACCOUNT_D_A="D_A";

	public static final String ACCOUNT_D_S="D_S";
	
	/** 私有化微信帐号 D_A 关键配置  BEGIN **/
	public static final String D_A_MP_ID="gh_e0a25e81f588";
	private static final String D_A_APP_ID="wxc3e68f0161547f2a";
	private static final String D_A_APP_SECRET="4875dd69bb621b056a56c2231380a9c4";
	private static final String D_A_APP_TOKEN="chinazhoufan";
	private static final String D_A_AES_KEY="yYaF3TFdSCZ6eKPfEFXK2A3c6ufXXAf9mhIjHjvTyli";
	/** 私有化微信帐号 D_A 关键配置  END **/
	
	/** 私有化微信帐号 D_A 关键配置  BEGIN **/

	public static final String D_S_MP_ID="gh_55a2e6ab6ccb";
	public static final String D_S_APP_ID="wxde73550d41923678";
	/** 微信服务号key **/
	public static final String D_S_APP_SECRET="04ff475db07d75a17b4300deaba10531";
	/** 商户平台支付秘钥 **/
	public static final String D_S_APP_MONEY_SECRET="SRmUmYSfXQriYhO7v2QtYimrSsRp5Pjf";
	public static final String D_S_APP_TOKEN="chinazhoufan";
	public static final String D_S_AES_KEY="4gUocy9wqVv2p5jOWwdwvrC07iB5ZVgqouKskzQRPxV";
	
	/**
	 * 微信openid进行MD5加密的Key（Key与微信openid拼接，进行两次MD5加密后，成为保存到本系统的会员wechatOpenid属性）
	 */
	public static final String OPENID_MD5_KEY = "zhoufan";
	
	/**
	 * 依据帐号编号获取帐号
	 * @param account 帐号编号
	 * @return
	 */
	public static MPAccount getAccountConfig(String account){
		switch (account) {
		case ACCOUNT_D_A:
			MPAccount mpAccount=new MPAccount();
			mpAccount.setAESKey(WeiXinConfig.D_A_AES_KEY);
			mpAccount.setAppId(WeiXinConfig.D_A_APP_ID);
			mpAccount.setAppSecret(WeiXinConfig.D_A_APP_SECRET);
			mpAccount.setMpId(WeiXinConfig.D_A_MP_ID);
			mpAccount.setMpType(WeiXinConfig.MP_TYPE_D);
			mpAccount.setToken(WeiXinConfig.D_A_APP_TOKEN); 
			return mpAccount;
		case ACCOUNT_D_S:
			MPAccount mpAccountOt=new MPAccount();
			mpAccountOt.setAESKey(WeiXinConfig.D_S_AES_KEY);
			mpAccountOt.setAppId(WeiXinConfig.D_S_APP_ID);
			mpAccountOt.setAppSecret(WeiXinConfig.D_S_APP_SECRET);
			mpAccountOt.setMpId(WeiXinConfig.D_S_MP_ID);
			mpAccountOt.setMpType(WeiXinConfig.MP_TYPE_D);
			mpAccountOt.setToken(WeiXinConfig.D_S_APP_TOKEN);
			return mpAccountOt;
		default:
			return null;
		}
	}
}
