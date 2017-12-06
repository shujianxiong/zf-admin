/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.wp;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 微信支付配置表Entity
 * @author liut
 * @version 2017-05-08
 */
public class WechatPayConfig extends DataEntity<WechatPayConfig> {
	
	private static final long serialVersionUID = 1L;
	private String mchId;		// 商户号
	private String appid;		// 微信公众号Appid
	private String appkey;		// 微信公众号Key
	private String notifyUrl;		// 回调地址
	
	public WechatPayConfig() {
		super();
	}

	public WechatPayConfig(String id){
		super(id);
	}

	@Length(min=1, max=64, message="商户号长度必须介于 1 和 64 之间")
	public String getMchId() {
		return mchId;
	}

	public void setMchId(String mchId) {
		this.mchId = mchId;
	}
	
	@Length(min=1, max=64, message="微信公众号Appid长度必须介于 1 和 64 之间")
	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}
	
	@Length(min=1, max=200, message="微信公众号Key长度必须介于 1 和 200 之间")
	public String getAppkey() {
		return appkey;
	}

	public void setAppkey(String appkey) {
		this.appkey = appkey;
	}
	
	@Length(min=1, max=1000, message="回调地址长度必须介于 1 和 1000 之间")
	public String getNotifyUrl() {
		return notifyUrl;
	}

	public void setNotifyUrl(String notifyUrl) {
		this.notifyUrl = notifyUrl;
	}
	
}