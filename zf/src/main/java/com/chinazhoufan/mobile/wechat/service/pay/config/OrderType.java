package com.chinazhoufan.mobile.wechat.service.pay.config;
/**
 * @author  杨晓辉
 * @date 创建时间：2017年5月8日 上午11:52:17 
 * @version 2.0.0 
 */
public enum OrderType {
	
	EXPERIENCE("1"),				// 体验
	APPOINTEXPERIENCE("2"),			// 预约体验
	BUY("3"),						// 购买
	APPOINTBUY("4");				// 预约购买
	
	private String type;
	
	private OrderType(String type){
		this.type=type;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}
