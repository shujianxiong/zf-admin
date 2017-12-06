/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.sl;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 短信链接模块Entity
 * @author 舒剑雄
 * @version 2017-09-26
 */
public class SmsLink extends DataEntity<SmsLink> {
	
	private static final long serialVersionUID = 1L;
	private String context;		// 内容
	private String link;		// 链接
	private String parameter;		// 参数
	private Integer clickRate;		// 点击率
	private String type;		// 类型
	private String memberCodes;		// 发送用户
	private String activeFlag;		// 启用状态

	/******************************************** 自定义常量  *********************************************/

	private String[] sendUserCodes ;
	private String[] memberusercodes;
	//sms_link_type
	public SmsLink() {
		super();
	}

	public SmsLink(String id){
		super(id);
	}

	@Length(min=0, max=500, message="内容长度必须介于 0 和 500 之间")
	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}
	
	@Length(min=0, max=500, message="链接长度必须介于 0 和 500 之间")
	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}
	
	@Length(min=1, max=64, message="参数长度必须介于 1 和 64 之间")
	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	
	public Integer getClickRate() {
		return clickRate;
	}

	public void setClickRate(Integer clickRate) {
		this.clickRate = clickRate;
	}

	@Length(min=1, max=1, message="类型长度必须介于 0 和 64 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=3000, message="发送用户长度必须介于 1 和 3000 之间")
	public String getMemberCodes() {
		return memberCodes;
	}

	public void setMemberCodes(String memberCodes) {
		this.memberCodes = memberCodes;
	}
	
	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public String[] getMemberusercodes() {
		return memberusercodes;
	}

	public void setMemberusercodes(String[] memberusercodes) {
		this.memberusercodes = memberusercodes;
	}

	public String[] getSendUserCodes() {
		return sendUserCodes;
	}

	public void setSendUserCodes(String[] sendUserCodes) {
		this.sendUserCodes = sendUserCodes;
	}
	
	
}