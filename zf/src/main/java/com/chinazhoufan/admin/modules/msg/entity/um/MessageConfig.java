/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.entity.um;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Role;

/**
 * 员工消息发送设置Entity
 * @author 刘晓东
 * @version 2015-12-11
 */
public class MessageConfig extends DataEntity<MessageConfig> {
	
	private static final long serialVersionUID = 1L;
	private String category;		// 消息类别（消息/通知/提示）
	private String type;		// 消息类型（个人消息/部门通知/系统预警）
	private String title;		// 标题
	private String contentModel;		// 内容文本模型（${name}您好，${stock}已超标）
	private Role receiveRole;		// 接收角色ID
	private String usableFlag;		// 启用标记（0：停用 1：启用）
	
	
	public MessageConfig() {
		super();
	}

	public MessageConfig(String id){
		super(id);
	}

	@Length(min=1, max=2, message="消息类别（消息/通知/提示）长度必须介于 1 和 2 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=2, message="消息类型（个人消息/部门通知/系统预警）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=50, message="标题长度必须介于 1 和 50 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContentModel() {
		return contentModel;
	}

	public void setContentModel(String contentModel) {
		this.contentModel = contentModel;
	}
	
	public Role getReceiveRole() {
		return receiveRole;
	}

	public void setReceiveRole(Role receiveRole) {
		this.receiveRole = receiveRole;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
	@Length(min=1, max=1, message="启用标记（0：停用 1：启用）长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

}