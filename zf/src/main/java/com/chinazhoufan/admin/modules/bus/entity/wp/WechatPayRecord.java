/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.wp;

import java.math.BigDecimal;
import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 微信支付记录Entity
 * @author 张金俊
 * @version 2017-05-12
 */
public class WechatPayRecord extends DataEntity<WechatPayRecord> {
	
	private static final long serialVersionUID = 1L;
	private String appid;				// 公众账号ID
	private String mchId;				// 商户号
	private String deviceInfo;			// 设备号
	private String nonceStr;			// 随机字符串
	private String signType;			// 签名类型
	private String resultCode;			// 业务结果
	private String errCode;				// 错误代码
	private String errCodeDes;			// 错误代码描述
	private String openid;				// 用户标识
	private String isSubscribe;			// 是否关注公众账号
	private String tradeType;			// 交易类型
	private String bankType;			// 付款银行
	private Integer totalFee;			// 订单金额
	private Integer settlementTotalFee;	// 应结订单金额
	private String feeType;				// 货币种类
	private Integer cashFee;			// 现金支付金额
	private String cashFeeType;			// 现金支付货币类型
	private Integer couponFee;			// 总代金券金额
	private Integer couponCount;		// 代金券使用数量
	private Integer couponType$n;		// 代金券类型
	private String transactionId;		// 微信支付订单号
	private Integer couponFee$n;		// 单个代金券支付金额
	private String outTradeNo;			// 商户订单号
	private String attach;				// 商家数据包
	private String timeEnd;				// 支付完成时间
	private String sign;				// 签名
	private String couponId$n;			// 代金券ID
	// 退款相关信息
	private String refundNo;					// 退款编号
	private String refundAutoStatus;			// 自动退款状态
	private BigDecimal refundAutoMoney;			// 自动退款金额
	private Date refundAutoTime;				// 自动退款时间
	private String refundArtificialStatus;		// 人工退款状态
	private BigDecimal refundArtificialMoney;	// 人工退款金额
	private Date refundArtificialTime;			// 人工退款时间
	
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_REFUNDNO = "bus_wp_refundNo";	// 获取微信退款单编号 字段
	
	// 自动退款状态 bus_wp_wechat_pay_record_refundAutoStatus
	public static final String STATUS_AUTO_REFUNDING	= "2";	// 退款中（开始退款时，自动退款状态由空变为2退款中）
	public static final String STATUS_AUTO_SUCCESS		= "3";	// 退款成功
	public static final String STATUS_AUTO_FALSE		= "4";	// 退款失败
	// 人工退款状态 bus_wp_wechat_pay_record_refundArtificialStatus
	public static final String STATUS_ARTI_TOREFUND		= "1";	// 待退款
	public static final String STATUS_ARTI_REFUNDING	= "2";	// 退款中
	public static final String STATUS_ARTI_SUCCESS		= "3";	// 退款成功
	public static final String STATUS_ARTI_FALSE		= "4";	// 退款失败
	
	
	
	public WechatPayRecord() {
		super();
	}

	public WechatPayRecord(String id){
		super(id);
	}

	
	@Length(min=0, max=32, message="公众账号ID长度必须介于 0 和 32 之间")
	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}
	
	@Length(min=0, max=32, message="商户号长度必须介于 0 和 32 之间")
	public String getMchId() {
		return mchId;
	}

	public void setMchId(String mchId) {
		this.mchId = mchId;
	}
	
	@Length(min=0, max=32, message="设备号长度必须介于 0 和 32 之间")
	public String getDeviceInfo() {
		return deviceInfo;
	}

	public void setDeviceInfo(String deviceInfo) {
		this.deviceInfo = deviceInfo;
	}
	
	@Length(min=0, max=32, message="随机字符串长度必须介于 0 和 32 之间")
	public String getNonceStr() {
		return nonceStr;
	}

	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}
	
	@Length(min=0, max=32, message="签名类型长度必须介于 0 和 32 之间")
	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}
	
	@Length(min=0, max=16, message="业务结果长度必须介于 0 和 16 之间")
	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	
	@Length(min=0, max=32, message="错误代码长度必须介于 0 和 32 之间")
	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	
	@Length(min=0, max=128, message="错误代码描述长度必须介于 0 和 128 之间")
	public String getErrCodeDes() {
		return errCodeDes;
	}

	public void setErrCodeDes(String errCodeDes) {
		this.errCodeDes = errCodeDes;
	}
	
	@Length(min=0, max=128, message="用户标识长度必须介于 0 和 128 之间")
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	@Length(min=0, max=1, message="是否关注公众账号长度必须介于 0 和 1 之间")
	public String getIsSubscribe() {
		return isSubscribe;
	}

	public void setIsSubscribe(String isSubscribe) {
		this.isSubscribe = isSubscribe;
	}
	
	@Length(min=0, max=16, message="交易类型长度必须介于 0 和 16 之间")
	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	
	@Length(min=0, max=16, message="付款银行长度必须介于 0 和 16 之间")
	public String getBankType() {
		return bankType;
	}

	public void setBankType(String bankType) {
		this.bankType = bankType;
	}
	
	public Integer getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(Integer totalFee) {
		this.totalFee = totalFee;
	}
	
	public Integer getSettlementTotalFee() {
		return settlementTotalFee;
	}

	public void setSettlementTotalFee(Integer settlementTotalFee) {
		this.settlementTotalFee = settlementTotalFee;
	}
	
	@Length(min=0, max=8, message="货币种类长度必须介于 0 和 8 之间")
	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}
	
	public Integer getCashFee() {
		return cashFee;
	}

	public void setCashFee(Integer cashFee) {
		this.cashFee = cashFee;
	}
	
	@Length(min=0, max=16, message="现金支付货币类型长度必须介于 0 和 16 之间")
	public String getCashFeeType() {
		return cashFeeType;
	}

	public void setCashFeeType(String cashFeeType) {
		this.cashFeeType = cashFeeType;
	}
	
	public Integer getCouponFee() {
		return couponFee;
	}

	public void setCouponFee(Integer couponFee) {
		this.couponFee = couponFee;
	}
	
	public Integer getCouponCount() {
		return couponCount;
	}

	public void setCouponCount(Integer couponCount) {
		this.couponCount = couponCount;
	}
	
	public Integer getCouponType$n() {
		return couponType$n;
	}

	public void setCouponType$n(Integer couponType$n) {
		this.couponType$n = couponType$n;
	}
	
	@Length(min=0, max=32, message="微信支付订单号长度必须介于 0 和 32 之间")
	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	
	public Integer getCouponFee$n() {
		return couponFee$n;
	}

	public void setCouponFee$n(Integer couponFee$n) {
		this.couponFee$n = couponFee$n;
	}
	
	@Length(min=0, max=32, message="商户订单号长度必须介于 0 和 32 之间")
	public String getOutTradeNo() {
		return outTradeNo;
	}

	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	
	@Length(min=0, max=128, message="商家数据包长度必须介于 0 和 128 之间")
	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}
	
	@Length(min=0, max=14, message="支付完成时间长度必须介于 0 和 14 之间")
	public String getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}
	
	@Length(min=0, max=32, message="签名长度必须介于 0 和 32 之间")
	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
	
	@Length(min=0, max=20, message="代金券ID长度必须介于 0 和 20 之间")
	public String getCouponId$n() {
		return couponId$n;
	}

	public void setCouponId$n(String couponId$n) {
		this.couponId$n = couponId$n;
	}

	public String getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
	}

	public String getRefundAutoStatus() {
		return refundAutoStatus;
	}

	public void setRefundAutoStatus(String refundAutoStatus) {
		this.refundAutoStatus = refundAutoStatus;
	}

	public BigDecimal getRefundAutoMoney() {
		return refundAutoMoney;
	}

	public void setRefundAutoMoney(BigDecimal refundAutoMoney) {
		this.refundAutoMoney = refundAutoMoney;
	}

	public Date getRefundAutoTime() {
		return refundAutoTime;
	}

	public void setRefundAutoTime(Date refundAutoTime) {
		this.refundAutoTime = refundAutoTime;
	}

	public String getRefundArtificialStatus() {
		return refundArtificialStatus;
	}

	public void setRefundArtificialStatus(String refundArtificialStatus) {
		this.refundArtificialStatus = refundArtificialStatus;
	}

	public BigDecimal getRefundArtificialMoney() {
		return refundArtificialMoney;
	}

	public void setRefundArtificialMoney(BigDecimal refundArtificialMoney) {
		this.refundArtificialMoney = refundArtificialMoney;
	}

	public Date getRefundArtificialTime() {
		return refundArtificialTime;
	}

	public void setRefundArtificialTime(Date refundArtificialTime) {
		this.refundArtificialTime = refundArtificialTime;
	}
	
}