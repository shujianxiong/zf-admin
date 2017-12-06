/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.bs;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 品牌管理Entity
 * @author 贾斌
 * @version 2015-11-04
 */
public class Brand extends DataEntity<Brand> {
	
	private static final long serialVersionUID = 1L;
	private String name;				// 品牌名称
	private String type;                // 品牌类型
	private String companyName;			// 品牌公司名称
	private String logo;				// 品牌LOGO
	private String introduction;		// 品牌简介
	private String brandStatus;			// 品牌状态(0停用,1启用)
	
	private String topPhoto;            // 品牌头部图
	
	
	public Brand() {
		super();
	}

	public Brand(String id){
		super(id);
	}

	@NotBlank(message="品牌名称不能为空")
	@Length(min=1, max=50, message="品牌名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotBlank(message="品牌公司名称不能为空")
	@Length(min=1, max=50, message="品牌公司名称长度必须介于 1 和 50 之间")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@NotBlank(message="品牌LOGO不能为空")
	@Length(min=0, max=255, message="品牌LOGO长度必须介于 0 和 255 之间")
	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	@NotBlank(message="品牌类型不能为空")
	@Length(min=1, max=2, message="品牌类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@NotBlank(message="品牌状态不能为空")
	@Length(min=1, max=2, message="品牌状态长度必须介于 1 和 2 之间")
	public String getBrandStatus() {
		return brandStatus;
	}

	public void setBrandStatus(String brandStatus) {
		this.brandStatus = brandStatus;
	}

	public String getTopPhoto() {
		return topPhoto;
	}

	public void setTopPhoto(String topPhoto) {
		this.topPhoto = topPhoto;
	}
	
	
	
}