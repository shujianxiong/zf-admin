package com.chinazhoufan.mobile.wechat.service.pay;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
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

import net.sf.json.JSONObject;

/**
 * 微信退款（该service申请退款未使用证书，暂未使用该service）
 * @author  张金俊
 * @date 创建时间：2017年5月16日 下午3:46:31 
 * @version 2.0.0 
 */
@Service
@Transactional(readOnly=true)
public class WechatPayService extends CrudService<WechatPayConfigDao, WechatPayConfig>{
	
	private static Logger logger = LoggerFactory.getLogger(PropertiesLoader.class);

	
	/**
	 * 微信退款 
	 * @param wechatPayRecord   （要退款的）微信支付记录
     * @param refundFee    		退款金额(eg: 103.05)
     * @param openid    		用户的OPENID
	 */
	@Transactional(readOnly = false, propagation = Propagation.NEVER)
	public void refund(WechatPayRecord wechatPayRecord, BigDecimal refundFee, String openid ){
		logger.info("------微信退款wechatPayRefund------");
		logger.debug("wechatPay refund info:[wechatPayRecord.id="+wechatPayRecord.getId()+",refundFee="+refundFee+",openid="+openid+"]");
		
		if(wechatPayRecord == null || refundFee == null || StringUtils.isBlank(openid)){
			logger.debug("wechatPay refund info:微信支付参数有空参数");
			new WechatPayException("WechatPayService:微信支付参数有空参数",Constants.PARAMETER_ERROR);
		}
		
		List<WechatPayConfig> wechatPayConfigs = dao.findList(new WechatPayConfig());
		if(wechatPayConfigs == null || wechatPayConfigs.size() <= 0){
			logger.debug("wechatPay refund info:未获取到微信支付配置");
			new WechatPayException("WechatPayService:未获取到微信支付配置",Constants.PAY_ERROR);
		}
		WechatPayConfig wechatPayConfig = wechatPayConfigs.get(0);
		
		JSONObject jsonObject=null;
		String totalFeeStr = wechatPayRecord.getTotalFee().toString();
		String refundFeeStr = refundFee.multiply(new BigDecimal(100)).toString();
		try{
			jsonObject = createRefundOrder(wechatPayRecord.getTransactionId(), wechatPayRecord.getRefundNo(),
					totalFeeStr, refundFeeStr,  openid, 
					WechatPaySysConfig.WX_REFUND_URL_STRING, wechatPayConfig.getAppid(), wechatPayConfig.getMchId(), WeiXinConfig.D_S_APP_MONEY_SECRET);
			jsonObject = jsonObject.getJSONObject("obj");
			if(jsonObject == null || !jsonObject.get("status").equals("success")){
				logger.debug("wechatPay refund info:微信退款失败");
				new WechatPayException("WeChatPayService:微信退款失败,Constants",Constants.PAY_ERROR);
			}
		}catch(Exception e){
			logger.debug("wechatPay refund info:微信退款失败,请求错误");
			new WechatPayException("WeChatPayService:微信退款失败,请求错误",Constants.PAY_ERROR);
		}
	}
	
    
    /**
	 * 申请退款
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
	 * @throws UnsupportedEncodingException
	 */
    public static synchronized JSONObject createRefundOrder( 
    		String transactionId,
    		String refundNo,
    		String totalFeeStr, 
    		String refundFeeStr,
    		String openid, 
    		String refundUrl,
    		String appid,
    		String mchid,
    		String wxPayKey) throws UnsupportedEncodingException {

        JSONObject result = new JSONObject();

        // 1、参数校验(公众号调起微信支付的时候，必须要有openID)
        if (StringUtils.isBlank(transactionId)
        		|| StringUtils.isBlank(totalFeeStr)
        		|| StringUtils.isBlank(refundFeeStr)
        		|| StringUtils.isBlank(openid)) {
        	logger.error("微信支付申请退款请求错误：请求参数不足");
            result.put("status", "error");
            result.put("msg", "请求参数不足");
            result.put("obj", null);
            return result;
        }

        double totalFee = 0;	// 微信支付的真实数目
        double refundFee = 0;	// 要退款的真实数目
        try {
        	// 进行格式转换异常获取，保证数目正确
        	totalFee = Double.parseDouble(totalFeeStr);
        	refundFee = Double.parseDouble(refundFeeStr);
        } catch (Exception e) {
        	logger.error("微信支付申请退款请求错误：订单总金额、退款金额格式错误");
            result.put("status", "error");
            result.put("msg", "订单总金额、退款金额格式错误");
            result.put("obj", null);
            return result;
        }
        if (totalFee == 0 || refundFee == 0) {	// 订单总金额、退款金额必须为大于0的int类型，单位为分
        	logger.error("微信支付申请退款请求错误：订单总金额、退款金额不能为0");
            result.put("status", "error");
            result.put("msg", "订单总金额、退款金额不能为0");
            result.put("obj", null);
            return result;
        }
        if (refundFee > totalFee) {				// 退款金额必须小于等于订单总金额
        	logger.error("微信支付申请退款请求错误：退款金额不能超过订单总金额");
            result.put("status", "error");
            result.put("msg", "退款金额不能超过订单总金额");
            result.put("obj", null);
            return result;
        }

        if (StringUtils.isBlank(refundUrl) 
        		|| StringUtils.isBlank(appid) 
        		|| StringUtils.isBlank(mchid) 
        		|| StringUtils.isBlank(wxPayKey)) {
        	logger.error("微信支付申请退款请求错误：系统配置信息缺失");
            result.put("status", "error");
            result.put("msg", "系统配置信息缺失");
            result.put("obj", null);
            return result;
        }
        
        
        // 2、获取申请退款参数
        String xml = getRefundXMLString(transactionId, refundNo, totalFeeStr, refundFeeStr, openid, refundUrl, appid, mchid, wxPayKey);

        
        // 3、发送请求
        String response = "";
        try {//注意，此处的httputil一定发送请求的时候一定要注意中文乱码问题，中文乱码问题会导致在客户端加密是正确的，可是微信端返回的是加密错误
            response = HttpTool.post(refundUrl, xml);
        } catch (Exception e) {
        	logger.error("微信支付申请退款失败:http请求失败");
            result.put("status", "error");
            result.put("msg", "http请求失败");
            result.put("obj", null);
            return result;
        }


        // 4、处理请求结果
        XStream s = new XStream(new DomDriver());
        s.alias("xml", WechatRefundResult.class);
        WechatRefundResult refundResult = (WechatRefundResult) s.fromXML(response);

        if ("SUCCESS".equals(refundResult.getReturn_code()) && "SUCCESS".equals(refundResult.getResult_code())) {
        	logger.error("微信支付申请退款请求成功：" + refundResult.getRefund_id());
        	result.put("status", "success");
        	result.put("msg", "退款成功");
        	result.put("obj", refundResult);
        	return result;
        } else {
        	logger.error("微信支付申请退款请求错误：" + refundResult.getReturn_msg() + refundResult.getErr_code());
            result.put("status", "error");
            result.put("msg", "http请求失败");
            result.put("obj", null);
            return result;
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
    		String wxPayKey) {

        double totalFee = Double.parseDouble(totalFeeStr);	// 微信支付的真实数目
        double refundFee = Double.parseDouble(refundFeeStr);	// 要退款的真实数目
        
        UUID uuid = UUID.randomUUID();
    	String nonceStr=uuid.toString().replace("-", "");
    	
        // 1、发送报文模板,其中部分字段是可选字段
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

        
        // 2、xml数据封装
        // APP调起的时候，可能和公众号调起的商户号是不同的，所以需要分开设置
        xml = xml.replace("APPID", appid);
        xml = xml.replace("MERCHANT", mchid);
        xml = xml.replace("noncestr", nonceStr);
        xml = xml.replace("OPUSERID", openid);
        xml = xml.replace("OUTREFUNDNO", refundNo);
        xml = xml.replace("REFUND", (int)refundFee + "");
        xml = xml.replace("TOTAL", (int)totalFee + "");
        xml = xml.replace("TRANSACTIONID", transactionId);
        
        
        // 3、加密
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
    @Transactional(readOnly = false, propagation = Propagation.NEVER)
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
     * 查询退款
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
    	String xml = getRefundQueryXMLString(appid, mchid, transactionid, refundQueryUrl, wxPayKey);
        
        
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
     * 封装查询退款参数
     * @param appid		
     * @param mchid
     * @param transactionid		微信官方支付单ID
     * @param refundQueryUrl	查询退款URL
     * @param wxPayKey			商户平台支付秘钥
     * @return	wechatRefundQueryResult
     */
    public static synchronized String getRefundQueryXMLString(
    		String appid, 
    		String mchid, 
    		String transactionid, 
    		String refundQueryUrl, 
    		String wxPayKey){
    	logger.info("------微信退款查询wechatPayRefundQueryResult------");
		logger.debug("wechatPay refund queryResult info:[appid="+appid+",mchid="+mchid+"]");
    	
        UUID uuid = UUID.randomUUID();
    	String nonceStr=uuid.toString().replace("-", "");
        
    	
    	// 1、发送报文模板,其中部分字段是可选字段
    	String xml="<xml>"
				+ "<appid>app_id</appid>"
				+ "<mch_id>mchid</mch_id>"
				+ "<nonce_str>noncestr</nonce_str>"
				+ "<transaction_id>transactionid</transaction_id>"
				+ "<sign>_sign</sign>"
				+ "</xml>";
    	
    	
    	// 2、xml数据封装
    	xml = xml.replace("app_id", appid);
    	xml = xml.replace("mchid", mchid);
    	xml = xml.replace("noncestr", nonceStr);
    	xml = xml.replace("transactionid", transactionid);
    	
    	
    	// 3、加密
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("appid", appid);
    	map.put("mch_id", mchid);
    	map.put("transaction_id", transactionid);
    	map.put("nonce_str", nonceStr);
    	//签名
    	String sign = SignatureUtils.signature(map, wxPayKey);
        xml = xml.replace("_sign", sign);
        
        return xml;
    }
}

