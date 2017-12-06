package com.chinazhoufan.mobile.wechat.service.pay.config;


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
	 * D_S 为周范服务号 zty537@126.com 
	 */
	public static final String ACCOUNT_D_S="D_S";
	
	/** 私有化微信帐号 D_A 关键配置  BEGIN **/
	public static final String D_S_APP_ID="wxde73550d41923678";
	/** 微信服务号key **/
	public static final String D_S_APP_SECRET="04ff475db07d75a17b4300deaba10531";
	/** 商户平台支付秘钥 **/
	public static final String D_S_APP_MONEY_SECRET="SRmUmYSfXQriYhO7v2QtYimrSsRp5Pjf";
	/** 私有化微信帐号 D_A 关键配置  END **/
	
	/**微信授权回调地址用于获取code**/
	public static final String LOGIN_REDIRECT_URI="http://www.chinazhoufan.com/wechatCall";
	
	/**依据code获取access_token与openId**/
	public static final String GET_ACCESSTOKEN_OPENID_URI="https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code";

	/**获取access_token**/
	public static final String GET_ACCESSTOKEN_URI="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";
	
	/**获取jsapi_ticket**/
	public static final String GET_JSAPITICKET_URI="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=%s&type=jsapi";
	
	/**获取临时二维码**/
	public static final String GET_QRCODE_URI="https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=%s";
	
}
