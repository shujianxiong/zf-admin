package com.chinazhoufan.mobile.wechat.service.pay;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.security.KeyStore;
import java.util.*;

import javax.net.ssl.SSLContext;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.HttpTool;
import com.chinazhoufan.admin.common.utils.PropertiesLoader;
import com.chinazhoufan.admin.common.utils.SignatureUtils;
import com.chinazhoufan.admin.modules.bus.dao.wp.WechatPayConfigDao;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayConfig;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayRecord;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.wechat.service.pay.config.WechatPaySysConfig;
import com.chinazhoufan.mobile.wechat.service.pay.entity.WechatRefundQueryResult;
import com.chinazhoufan.mobile.wechat.service.pay.entity.WechatRefundResult;
import com.chinazhoufan.mobile.wechat.service.pay.exception.WechatPayException;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

/**
 * 微信退款
 * @author  张金俊
 * @date 创建时间：2017年6月8日 下午3:46:31
 * @version 2.0.0
 */
@Service
@Transactional(readOnly=true)
public class WechatRefundService extends CrudService<WechatPayConfigDao, WechatPayConfig>{

	private static Logger logger = LoggerFactory.getLogger(PropertiesLoader.class);


	/**
	 * 微信退款（旧版本已弃用）
	 * @param wechatPayRecord   （要退款的）微信支付记录
	 * @param refundFee    		退款金额(eg: 103.05)
	 * @param openid    		用户的OPENID
	 */
	@Transactional(readOnly = false)
	public void refund(WechatPayRecord wechatPayRecord, BigDecimal refundFee, String openid ) throws Exception {
		logger.info("------微信退款 WechatRefundService.refund()------");
		logger.debug("wechatPay refund info:[wechatPayRecord.id="+wechatPayRecord.getId()+",refundFee="+refundFee+",openid="+openid+"]");

		// 1、验证参数
		if(wechatPayRecord == null || refundFee == null || StringUtils.isBlank(openid)){
			logger.debug("wechatPay refund exception:微信支付参数有空参数");
			new WechatPayException("WechatPayService:微信支付参数有空参数",Constants.PARAMETER_ERROR);
		}

		// 2、查询微信支付配置
		List<WechatPayConfig> wechatPayConfigs = dao.findList(new WechatPayConfig());
		if(wechatPayConfigs == null || wechatPayConfigs.size() <= 0){
			logger.debug("wechatPay refund exception:未获取到微信支付配置");
			new WechatPayException("WechatPayService:未获取到微信支付配置",Constants.PAY_ERROR);
		}
		WechatPayConfig wechatPayConfig = wechatPayConfigs.get(0);

		// 3、加载证书
		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
		FileInputStream instream = new FileInputStream(new File(WechatPaySysConfig.WX_WEIXIN_CERT_DIR));
		try {
			keyStore.load(instream, WechatPaySysConfig.WX_MCH_ID.toCharArray());
		} finally {
			instream.close();
		}

		// Trust own CA and all self-signed certs
		SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, WechatPaySysConfig.WX_MCH_ID.toCharArray()).build();
		// Allow TLSv1 protocol only
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);



		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();

		try {
			// 4、发送退款请求
			HttpPost httpPost = new HttpPost("https://api.mch.weixin.qq.com/secapi/pay/refund");

			String totalFeeStr = wechatPayRecord.getTotalFee().toString();
			String refundFeeStr = refundFee.multiply(new BigDecimal(100)).toString();
			String xml = getRefundXMLString(wechatPayRecord.getTransactionId(), wechatPayRecord.getRefundNo(),
					totalFeeStr, refundFeeStr,  openid,
					WechatPaySysConfig.WX_REFUND_URL_STRING, wechatPayConfig.getAppid(), wechatPayConfig.getMchId(), WeiXinConfig.D_S_APP_MONEY_SECRET);
			System.out.println(xml);
			logger.info(xml);
			/*List<BasicNameValuePair> parameters = new ArrayList<>();
			parameters.add(new BasicNameValuePair("xml", xml));
			httpPost.setEntity(new UrlEncodedFormEntity(parameters,"UTF-8"));*/
//            // 另一种方式的设置XML实体
//            StringEntity stringEntity = new StringEntity(xml);
//            httpPost.setEntity(stringEntity);
			StringEntity postEntity = new StringEntity(xml,"UTF-8");
			httpPost.setEntity(postEntity);
			logger.info("设置XML实体");

			CloseableHttpResponse response = httpclient.execute(httpPost);		// 发请求

			try {
				// 5、处理返回
				HttpEntity entity = response.getEntity();
				String resultStr = EntityUtils.toString(entity, "UTF-8");
				//EntityUtils.consume(entity);									// 关闭流
				logger.info("关闭流");
				XStream s = new XStream(new DomDriver());
				s.alias("xml", WechatRefundResult.class);
				WechatRefundResult refundResult = (WechatRefundResult) s.fromXML(resultStr);

				if ("SUCCESS".equals(refundResult.getReturn_code())) {
					logger.error("wechatPay refund info:微信退款成功," + refundResult.getRefund_id());
				} else {
					logger.debug("wechatPay refund info:微信退款http请求失败," + refundResult.getReturn_msg() + "," + refundResult.getErr_code()+","+refundResult.getResult_code());
					throw new WechatPayException("WeChatPayService:微信退款失败,Constants", Constants.PAY_ERROR);
				}
			}catch(Exception e){
				logger.debug("wechatPay refund info:微信退款失败,请求错误");
				throw new WechatPayException("WeChatPayService:微信退款失败,请求错误", Constants.PAY_ERROR);
			} finally {
				response.close();
			}
		} catch(Exception e){
			throw new WechatPayException("WeChatPayService:微信退款失败," + e.getMessage(), Constants.PAY_ERROR);
		} finally {
			httpclient.close();
		}
	}

	/**
	 * 封装申请退款参数
	 * @param transactionId	微信支付订单号
	 * @param refundNo		周范退款编号
	 * @param totalFeeStr	订单总金额(单位为分，eg：10305)
	 * @param refundFeeStr	退款金额(单位为分，eg：10304)
	 * @param openid		公众号调起时需要的openid
	 * @param refundUrl		退款申请url
	 * @param appid
	 * @param mchid
	 * @param wxPayKey		商户平台支付秘钥
	 * @return
	 */
	public static synchronized String getRefundXMLString(
			String transactionId,
			String refundNo,
			String totalFeeStr,
			String refundFeeStr,
			String openid,
			String refundUrl,
			String appid,
			String mchid,
			String wxPayKey) throws WechatPayException{

		// 1、验证申请退款参数（公众号调起微信支付的时候，必须要有openID）
		if (StringUtils.isBlank(transactionId)
				|| StringUtils.isBlank(totalFeeStr)
				|| StringUtils.isBlank(refundFeeStr)
				|| StringUtils.isBlank(openid)) {
			logger.error("wechatPay refund error:请求参数不足");
			throw new WechatPayException("请求参数不足");
		}

		double totalFee = 0;	// 微信支付的真实数目
		double refundFee = 0;	// 要退款的真实数目
		try {
			// 进行格式转换异常获取，保证数目正确
			totalFee = Double.parseDouble(totalFeeStr);
			refundFee = Double.parseDouble(refundFeeStr);
		} catch (Exception e) {
			logger.error("wechatPay refund error:订单总金额、退款金额格式错误");
			throw new WechatPayException("订单总金额、退款金额格式错误");
		}
		if (totalFee == 0 || refundFee == 0) {	// 订单总金额、退款金额必须为大于0的int类型，单位为分
			logger.error("wechatPay refund error:订单总金额、退款金额不能为0");
			throw new WechatPayException("订单总金额、退款金额不能为0");
		}
		if (refundFee > totalFee) {				// 退款金额必须小于等于订单总金额
			logger.error("wechatPay refund error:退款金额不能超过订单总金额");
			throw new WechatPayException("退款金额不能超过订单总金额");
		}

		if (StringUtils.isBlank(refundUrl)
				|| StringUtils.isBlank(appid)
				|| StringUtils.isBlank(mchid)
				|| StringUtils.isBlank(wxPayKey)) {
			logger.error("wechatPay refund error:系统配置信息缺失");
			throw new WechatPayException("系统配置信息缺失");
		}

		// 2、生成随机字符串
		UUID uuid = UUID.randomUUID();
		String nonceStr=uuid.toString().replace("-", "");

		// 3、发送报文模板,其中部分字段是可选字段
		String xml = "" +
				"<xml>" +
				"<appid>APPID</appid>" +							// 公众号ID
				"<mch_id>MERCHANT</mch_id>" +						// 微信给的商户ID
				"<nonce_str>noncestr</nonce_str>" +					// 32位随机字符串,不改
				"<op_user_id>OPUSERID</op_user_id>"+				// 操作员
				"<out_refund_no>OUTREFUNDNO</out_refund_no>" +		// 商户退款单号
				"<refund_fee>REFUND</refund_fee>" +					// 退款金额
				"<total_fee>TOTAL</total_fee>" +					// 订单金额
				"<transaction_id>TRANSACTIONID</transaction_id>" +	// 微信订单号
				"<sign>SIGN</sign>" +								// 加密字符串
				"</xml>";


		// 4、xml数据封装
		// APP调起的时候，可能和公众号调起的商户号是不同的，所以需要分开设置
		xml = xml.replace("APPID", appid);
		xml = xml.replace("MERCHANT", mchid);
		xml = xml.replace("noncestr", nonceStr);
		xml = xml.replace("OPUSERID", openid);
		xml = xml.replace("OUTREFUNDNO", refundNo);
		xml = xml.replace("REFUND", (int)refundFee + "");
		xml = xml.replace("TOTAL", (int)totalFee + "");
		xml = xml.replace("TRANSACTIONID", transactionId);


		// 5、加密
		Map<String, String> map = new HashMap<String, String>();
		map.put("appid", appid);
		map.put("mch_id", mchid);
		map.put("nonce_str", nonceStr);
		map.put("op_user_id", openid);
		map.put("out_refund_no", refundNo);
		map.put("refund_fee", (int)refundFee + "");
		map.put("total_fee", (int)totalFee + "");
		map.put("transaction_id", transactionId);

		String sign = SignatureUtils.signature(map, wxPayKey);
		xml = xml.replace("SIGN", sign);

		return xml;
	}


	/**
	 * 查询退款
	 * @param wechatPayRecord   （要退款的）微信支付记录
	 */
	@Transactional(readOnly = false)
	public void refundQuery(WechatPayRecord wechatPayRecord){
		if(wechatPayRecord == null){
			new WechatPayException("WechatPayService:微信退款订单查询参数有空参数",Constants.PARAMETER_ERROR);
		}

		List<WechatPayConfig> wechatPayConfigs = dao.findList(new WechatPayConfig());
		if(wechatPayConfigs == null || wechatPayConfigs.size() <= 0){
			new WechatPayException("WechatPayService:未获取到微信支付配置",Constants.PAY_ERROR);
		}
		WechatPayConfig wechatPayConfig = wechatPayConfigs.get(0);

		WechatRefundQueryResult wrqr=null;
		try{
			wrqr = createRefundQuery(wechatPayConfig.getAppid(), wechatPayConfig.getMchId(), wechatPayRecord.getTransactionId(),
					WechatPaySysConfig.WX_REFUNDQUERY_URL_STRING, WeiXinConfig.D_S_APP_MONEY_SECRET);
			if(wrqr == null || !wrqr.getReturn_code().equals("SUCCESS") || !wrqr.getResult_code().equals("SUCCESS")){
				new WechatPayException("WeChatPayService:微信退款订单查询失败,Constants",Constants.PAY_ERROR);
			}
		}catch(Exception e){
			new WechatPayException("WeChatPayService:微信退款订单查询失败,请求错误",Constants.PAY_ERROR);
		}
	}

	/**
	 * 访问查询退款接口
	 * @param appid
	 * @param mchid
	 * @param transactionid		微信官方支付单ID
	 * @param refundQueryUrl	查询退款URL
	 * @param wxPayKey			商户平台支付秘钥
	 * @return	wechatRefundQueryResult
	 */
	public static synchronized WechatRefundQueryResult createRefundQuery(
			String appid,
			String mchid,
			String transactionid,
			String refundQueryUrl,
			String wxPayKey){
		logger.info("------微信退款查询wechatPayRefundQueryResult------");
		logger.debug("wechatPay refund queryResult info:[appid="+appid+",mchid="+mchid+"]");

		// 1、参数校验
		if (StringUtils.isBlank(appid) || StringUtils.isBlank(mchid) || StringUtils.isBlank(transactionid)) {
			logger.error("微信退款订单查询错误：请求参数不足");
			return null;
		}


		// 2、封装查询退款参数
		UUID uuid = UUID.randomUUID();
		String nonceStr=uuid.toString().replace("-", "");

		// 发送报文模板,其中部分字段是可选字段
		String xml="<xml>"
				+ "<appid>app_id</appid>"
				+ "<mch_id>mchid</mch_id>"
				+ "<nonce_str>noncestr</nonce_str>"
				+ "<transaction_id>transactionid</transaction_id>"
				+ "<sign>_sign</sign>"
				+ "</xml>";

		// xml数据封装
		xml = xml.replace("app_id", appid);
		xml = xml.replace("mchid", mchid);
		xml = xml.replace("noncestr", nonceStr);
		xml = xml.replace("transactionid", transactionid);

		// 加密
		Map<String, String> map = new HashMap<String, String>();
		map.put("appid", appid);
		map.put("mch_id", mchid);
		map.put("transaction_id", transactionid);
		map.put("nonce_str", nonceStr);
		// 签名
		String sign = SignatureUtils.signature(map, wxPayKey);
		xml = xml.replace("_sign", sign);


		// 3、请求
		String response = "";
		try {//注意，此处的httputil一定发送请求的时候一定要注意中文乱码问题，中文乱码问题会导致在客户端加密是正确的，可是微信端返回的是加密错误
			response = HttpTool.post(refundQueryUrl, xml);
		} catch (Exception e) {
			logger.error("微信支付统一下单失败:http请求失败");
			return null;
		}


		// 4、处理请求结果
		XStream s = new XStream(new DomDriver());
		s.alias("xml", WechatRefundResult.class);
		WechatRefundQueryResult wechatRefundQueryResult = (WechatRefundQueryResult) s.fromXML(response);
		return wechatRefundQueryResult;
	}
	/**
	 * 微信退款(新版)
	 * @param wechatPayRecord   （要退款的）微信支付记录
	 * @param refundFee    		退款金额(eg: 103.05)
	 * @param openid    		用户的OPENID
	 */
	@Transactional(readOnly = false)
	public void wxRefund(WechatPayRecord wechatPayRecord, BigDecimal refundFee, String openid ) throws Exception {
		String totalFeeStr = wechatPayRecord.getTotalFee().toString();
		String refundFeeStr = String.valueOf(refundFee.multiply(new BigDecimal(100)).intValue());
		// 2、生成随机字符串
		UUID uuid = UUID.randomUUID();
		String nonceStr=uuid.toString().replace("-", "");

		// 2、查询微信支付配置
		List<WechatPayConfig> wechatPayConfigs = dao.findList(new WechatPayConfig());
		if(wechatPayConfigs == null || wechatPayConfigs.size() <= 0){
			logger.debug("wechatPay refund exception:未获取到微信支付配置");
			new WechatPayException("WechatPayService:未获取到微信支付配置",Constants.PAY_ERROR);
		}
		WechatPayConfig wechatPayConfig = wechatPayConfigs.get(0);
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("appid", wechatPayConfig.getAppid());//appid
		parameters.put("mch_id", wechatPayConfig.getMchId());//商户号
		parameters.put("nonce_str", nonceStr);
		parameters.put("transaction_id", wechatPayRecord.getTransactionId());
		parameters.put("out_refund_no", wechatPayRecord.getRefundNo());//我们自己设定的退款申请号，约束为UK
		parameters.put("total_fee", totalFeeStr) ;//单位为分
		parameters.put("refund_fee", refundFeeStr);//单位为分
		parameters.put("op_user_id", openid);//操作人员,默认为商户账号

		// 签名
		String sign = SignatureUtils.signature(parameters, WeiXinConfig.D_S_APP_MONEY_SECRET);
		parameters.put("sign", sign);

		String reuqestXml = getRequestXml(parameters);
		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
		FileInputStream instream = new FileInputStream(new File(WechatPaySysConfig.WX_WEIXIN_CERT_DIR));//放退款证书的路径
		try {
			keyStore.load(instream, WechatPaySysConfig.WX_MCH_ID.toCharArray());//商户号
		} finally {
			instream.close();
		}
		//加载证书
		SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, WechatPaySysConfig.WX_MCH_ID.toCharArray()).build();//"123456"指的是商户号
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
				sslcontext,
				new String[] { "TLSv1" },
				null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
		try {

			HttpPost httpPost = new HttpPost(WechatPaySysConfig.WX_REFUND_URL_STRING_NEW);//退款接口

			System.out.println("executing request" + httpPost.getRequestLine());
			StringEntity  reqEntity  = new StringEntity(reuqestXml);
			// 设置类型
			reqEntity.setContentType("application/x-www-form-urlencoded");
			httpPost.setEntity(reqEntity);
			CloseableHttpResponse response = httpclient.execute(httpPost);
			try {
				HttpEntity entity = response.getEntity();

				System.out.println("----------------------------------------");
				System.out.println(response.getStatusLine());
				if (entity != null) {
					System.out.println("Response content length: " + entity.getContentLength());
					BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
					String text;
					while ((text = bufferedReader.readLine()) != null) {
						System.out.println(text);
					}

				}
				EntityUtils.consume(entity);
			} finally {
				response.close();
			}
		}catch(Exception e){
			logger.debug("wechatPay refund info:微信退款失败,请求错误");
			throw new WechatPayException("WeChatPayService:微信退款失败,请求错误", Constants.PAY_ERROR);
		} finally {
			httpclient.close();
		}
	}
	public static String getRequestXml(Map<String,String> parameters){
		StringBuffer sb = new StringBuffer();
		sb.append("<xml>");
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while(it.hasNext()) {
			Map.Entry entry = (Map.Entry)it.next();
			String k = (String)entry.getKey();
			String v = (String)entry.getValue();
			if ("attach".equalsIgnoreCase(k)||"body".equalsIgnoreCase(k)||"sign".equalsIgnoreCase(k)) {
				sb.append("<"+k+">"+"<![CDATA["+v+"]]></"+k+">");
			}else {
				sb.append("<"+k+">"+v+"</"+k+">");
			}
		}
		sb.append("</xml>");
		return sb.toString();
	}

}


