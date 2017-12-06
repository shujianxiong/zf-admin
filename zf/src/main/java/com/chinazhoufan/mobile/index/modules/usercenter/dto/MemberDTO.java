package com.chinazhoufan.mobile.index.modules.usercenter.dto;

import java.io.Serializable;

/**
 * 会员数据传输对象
 * @author 杨晓辉
 *
 */
public class MemberDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String usercode;
	private String wechatOpenid;	// 加密后的会员wechatOpenid属性
	
	
	public MemberDTO() {
		super();
	}
	
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUsercode() {
		return usercode;
	}
	
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getWechatOpenid() {
		return wechatOpenid;
	}
	
	public void setWechatOpenid(String wechatOpenid) {
		this.wechatOpenid = wechatOpenid;
	}
	
}
