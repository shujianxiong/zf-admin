package com.chinazhoufan.mobile.index.modules.activity.vo;


/**
 * 调研活动邀请验证信息VO
 * @author 张金俊
 *
 */
public class ArValidateVO {
	
	private String phone;		// 手机号（注册账号）
	private String smsCode;		// 短信验证码
	private String inviteCode;	// 活动邀请码
	
	private String arId;		// 调研活动ID
	
	
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
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

	public String getArId() {
		return arId;
	}

	public void setArId(String arId) {
		this.arId = arId;
	}
	
}
