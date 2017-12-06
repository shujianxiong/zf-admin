/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.sw;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 明星穿搭Entity
 * @author 张金俊
 * @version 2017-07-31
 */
public class StarsWear extends DataEntity<StarsWear> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 标题
	private Date displayDate;		// 展示日期
	private String listPhoto;		// 列表图
	private String detailPhoto;		// 详情图
	private String summary;		// 简介
	private String content;		// 内容
	private String usableFlag;		// 是否启用
	
	public StarsWear() {
		super();
	}

	public StarsWear(String id){
		super(id);
	}

	@Length(min=1, max=100, message="标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="展示日期不能为空")
	public Date getDisplayDate() {
		return displayDate;
	}

	public void setDisplayDate(Date displayDate) {
		this.displayDate = displayDate;
	}
	
	@Length(min=1, max=255, message="列表图长度必须介于 1 和 255 之间")
	public String getListPhoto() {
		return listPhoto;
	}

	public void setListPhoto(String listPhoto) {
		this.listPhoto = listPhoto;
	}
	
	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getSummary() {
		return summary;
	}
	@Length(min=1, max=255, message="详情图长度必须介于 1 和 255 之间")
	public String getDetailPhoto() {
		return detailPhoto;
	}

	public void setDetailPhoto(String detailPhoto) {
		this.detailPhoto = detailPhoto;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}