/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.ar;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 图文内置图片Entity
 * @author 舒剑雄
 * @version 2017-09-20
 */
public class MsgImg extends DataEntity<MsgImg> {
	
	private static final long serialVersionUID = 1L;
	private String msgId;		// 图文消息外键
	private String photoName;		// 图片名称
	private String photoUrl;		// 图片路径
	
	public MsgImg() {
		super();
	}

	public MsgImg(String id){
		super(id);
	}

	@Length(min=0, max=64, message="图文消息外键长度必须介于 0 和 64 之间")
	public String getMsgId() {
		return msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	
	@Length(min=1, max=64, message="图片名称长度必须介于 1 和 64 之间")
	public String getPhotoName() {
		return photoName;
	}

	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	
	@Length(min=1, max=200, message="图片路径长度必须介于 1 和 200 之间")
	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
}