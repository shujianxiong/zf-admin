/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.pd;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.google.common.collect.Lists;

/**
 * 频道Entity
 * @author 张金俊
 * @version 2016-08-12
 */
public class Channel extends DataEntity<Channel> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 频道名称
	private String type;		// 频道类型（菜单/推荐）
	private String displayArea;	// 展示区域（首页/场景详情/商品详情）
	private String icon;		// 图标
	private String bgPhoto;		// 背景图
	private Scene scene;		// 关联场景
	private String url;			// 链接地址
	private String orderNo;		// 排列序号
	private String usableFlag;	// 是否启用
	
	private List<ChannelScene> channelSceneList = Lists.newArrayList();
	
	
	public Channel() {
		super();
	}

	public Channel(String id){
		super(id);
	}

	@Length(min=1, max=50, message="频道名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=10, message="频道类型长度必须介于 1 和 10 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=10, message="展示区域长度必须介于 1 和 10 之间")
	public String getDisplayArea() {
		return displayArea;
	}

	public void setDisplayArea(String displayArea) {
		this.displayArea = displayArea;
	}
	
	@Length(min=0, max=255, message="图标长度必须介于 0 和 255 之间")
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	@Length(min=0, max=255, message="背景图长度必须介于 0 和 255 之间")
	public String getBgPhoto() {
		return bgPhoto;
	}

	public void setBgPhoto(String bgPhoto) {
		this.bgPhoto = bgPhoto;
	}
	
	public Scene getScene() {
		return scene;
	}

	public void setScene(Scene scene) {
		this.scene = scene;
	}
	
	@Length(min=0, max=255, message="链接地址长度必须介于 0 和 255 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public List<ChannelScene> getChannelSceneList() {
		return channelSceneList;
	}

	public void setChannelSceneList(List<ChannelScene> channelSceneList) {
		this.channelSceneList = channelSceneList;
	}
	
}