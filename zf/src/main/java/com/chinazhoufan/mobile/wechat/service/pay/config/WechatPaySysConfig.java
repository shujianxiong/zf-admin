package com.chinazhoufan.mobile.wechat.service.pay.config;
/**
 * 微信支付配置
 * @author  杨晓辉
 * @date 创建时间：2017年5月5日 下午5:20:29 
 * @version 2.0.0 
 */
public class WechatPaySysConfig {
	
	public static final String WX_REFUND_URL_STRING="https://api.mch.weixin.qq.com/pay/unifiedorder";		// 微信退款接口地址
	
	public static final String WX_REFUNDQUERY_URL_STRING="https://api.mch.weixin.qq.com/pay/orderquery";	// 微信退款单查询接口
	
	public static final String WX_WEIXIN_CERT_DIR="/opt/WeixinCert/apiclient_cert.p12";						// 证书服务器存放地址
	
	public static final String WX_MCH_ID="1410915102";														// 微信支付商户号

	public static final String WX_REFUND_URL_STRING_NEW="https://api.mch.weixin.qq.com/secapi/pay/refund";		// 微信退款接口地址
	
}
