package com.chinazhoufan.mobile.index.modules.usercenter.vo;


/**
 * 会员注册信息VO
 * @author 张金俊
 *
 */
public class RegisterVO {
	
	private String openid;		// 微信openid
	private String usercode;	// 注册账号（手机号）
	private String smsCode;		// 短信验证码
	private String inviteCode;	// 活动邀请码
	
	private String inviteFlag;	// 活动邀请码开启状态
	
	
	
	public String getOpenid() {
		return openid;
	}
	
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	public String getUsercode() {
		return usercode;
	}
	
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	
	public String getSmsCode() {
		return smsCode;
	}
	
	public void setSmsCode(String smsCode) {
		this.smsCode = smsCode;
	}
	
	public String getInviteCode() {
		return inviteCode;
	}
	
	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}
	
	public String getInviteFlag() {
		return inviteFlag;
	}
	
	public void setInviteFlag(String inviteFlag) {
		this.inviteFlag = inviteFlag;
	}
	
}
