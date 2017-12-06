/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.pd;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;

/**
 * 频道场景关联Entity
 * @author liuxiaodong
 * @version 2017-09-21
 */
public class ChannelScene extends DataEntity<ChannelScene> {
	
	private static final long serialVersionUID = 1L;
	private Channel channel;		// 频道ID
	private Scene scene;		// 场景ID
	private Integer orderNo;		// 排列序号
	private String usableFlag;		// 是否启用
	
	public ChannelScene() {
		super();
	}

	public ChannelScene(String id){
		super(id);
	}

	
	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public Scene getScene() {
		return scene;
	}

	public void setScene(Scene scene) {
		this.scene = scene;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}