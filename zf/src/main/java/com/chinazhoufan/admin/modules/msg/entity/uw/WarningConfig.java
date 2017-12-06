/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.entity.uw;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 报警发送设置Entity
 * @author 刘晓东
 * @version 2015-12-11
 */
public class WarningConfig extends DataEntity<WarningConfig> {
	
	private static final long serialVersionUID = 1L;
	private String category;		// 警报类别（库存监控/物流调货）
	private String type;		// 警报类型（库存超标/到货延迟/低于安全库存/低于警报库存）
	private String title;		// 标题
	private String contentModel;		// 内容文本模型（%s您好，%s已超标）
	private String receiveType;		// 接收类型（系统指派/设置指派）
	private User receiveUser;		// 接收人ID（系统指派时为空）
	private String usableFlag;		// 启用标记（0：停用 1：启用）
	private String monitorFlag;		// 监控标记（是否监控执行过程）
	
	//警报类别  msg_uw_warning_config_category
	public static final String CATEGORY_STOCK 	= "0";	// 库存监控
	public static final String CATEGORY_TRANSFER= "1";	// 物流调货

	//警报类型  	msg_uw_warning_config_type
	public static final String TYPE_OVER 		= "0";	// 库存超标
	public static final String TYPE_DELAY 		= "1";	// 到货延迟.
	public static final String TYPE_SAFETY 		= "2";	// 低于安全库存
	public static final String TYPE_AlARM 		= "3";	// 低于警报库存
	public final static String TYPE_WEIGHT 		= "4";	// 克重异常
	
	//接收类型    msg_uw_warning_config_receiveType
	public final static String RECEIVETYPE_SYSTEM = "0"; //系统指派
	public final static String RECEIVETYPE_USER = "1"; //设置指派
	
	
	public WarningConfig() {
	}

	public WarningConfig(String category, String type, String usableFlag) {
		this.category = category;
		this.type = type;
		this.usableFlag = usableFlag;
	}

	public WarningConfig(String id){
		super(id);
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
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
	
	@Length(min=1, max=2, message="接收类型（系统指派/设置指派）长度必须介于 1 和 2 之间")
	public String getReceiveType() {
		return receiveType;
	}

	public void setReceiveType(String receiveType) {
		this.receiveType = receiveType;
	}
	
	public User getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(User receiveUser) {
		this.receiveUser = receiveUser;
	}
	
	@Length(min=1, max=1, message="启用标记（0：停用 1：启用）长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
	@Length(min=1, max=1, message="监控标记（是否监控执行过程）长度必须介于 1 和 1 之间")
	public String getMonitorFlag() {
		return monitorFlag;
	}

	public void setMonitorFlag(String monitorFlag) {
		this.monitorFlag = monitorFlag;
	}
	
}