/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.ar;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 图文消息表Entity
 * @author liut
 * @version 2016-05-25
 */
public class ArticleMsg extends DataEntity<ArticleMsg> {
	
	private static final long serialVersionUID = 1L;
	private String mediaId;		// 图文素材id
	private String name;		// 名称
	private String title;		// 图文消息标题
	private String description;	// 图文消息描述
	private String indexOf;		// 图文消息下标
	private String pic;			// 图片
	private String linkUrl;		// 跳转链接
	private String orderWeight;	// 排序权重
	
	public ArticleMsg() {
		super();
	}

	public ArticleMsg(String id){
		super(id);
	}

	public String getMediaId() {
		return mediaId;
	}

	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=100, message="图文消息标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIndexOf() {
		return indexOf;
	}

	public void setIndexOf(String indexOf) {
		this.indexOf = indexOf;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}
	
	@Length(min=1, max=255, message="跳转链接长度必须介于 1 和 255 之间")
	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	
	@Length(min=0, max=11, message="排序权重长度必须介于 0 和 11 之间")
	public String getOrderWeight() {
		return orderWeight;
	}

	public void setOrderWeight(String orderWeight) {
		this.orderWeight = orderWeight;
	}
	
}