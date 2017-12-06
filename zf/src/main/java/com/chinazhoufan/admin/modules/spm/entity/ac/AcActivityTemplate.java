/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ac;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 调研活动模板Entity
 * @author liut
 * @version 2016-05-20
 */
public class AcActivityTemplate extends DataEntity<AcActivityTemplate> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 模板名称
	private String description;		// 模板描述
	private String photo;		// 文件地址
	private String dirPath;
	private String activeFlag;		// 启用状态
	
	
	public AcActivityTemplate() {
		super();
	}

	public AcActivityTemplate(String id){
		super(id);
	}

	@Length(min=1, max=100, message="模板名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=200, message="模板描述长度必须介于 0 和 200 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=200, message="模板样式效果图长度必须介于 0 和 200 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Length(min=0, max=200, message="模板文件路径长度必须介于 0 和 200 之间")
	public String getDirPath() {
		return dirPath;
	}

	public void setDirPath(String dirPath) {
		this.dirPath = dirPath;
	}

	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
}