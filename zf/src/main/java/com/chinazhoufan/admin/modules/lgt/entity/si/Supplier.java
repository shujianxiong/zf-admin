/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.si;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 供应商Entity
 * @author 张金俊
 * @version 2015-10-15
 */
public class Supplier extends DataEntity<Supplier> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 供应商名称
	private String type;		// 供应商类型
	private String level;		// 信誉等级
	private String activeFlag;		// 是否启用(0：不启用   1：启用    默认0)
	private Categories supplierCategory;		// 供应商分类
	private User sysUser;   //供应商关联的用户账号ID
	private List<SupplierContacts> supplierContactsList = Lists.newArrayList();		// 子表列表
	
	private String brandNames;//所属品牌名称汇总字段
	
	private String nickName;//别名
	private String logo;//Logo
	private String country;//国家
	private String brandLevel;//品牌分级
	private String address;//公司地址
	private String tel;//联系方式
	private String fax;//传真
	private String email;//邮箱
	private String website;//公司网址
	private String produceMaterial;//产品主材质
	private String priceRange;//价格区间
	private String purchaseType;//采购方式
	private String cooperateDesire;//合作意愿
	private String description;//供应商描述
	private String displayPhotos;//供应商图片展示
	
	private Integer defaultAccount;//默认账期
	private BigDecimal defaultAccountRate;//默认账期利率
	private Integer returnPeriod;//回货周期
	private Integer creditPoint;//信誉积分
	
	private Area area;  //关联区域实体
	
	private BigDecimal qualifiedScale;//合格率
	
	public static final String ACTIVEFLAGOK = "1";
	
	public Supplier() {
		super();
	}

	public Supplier(String id){
		super(id);
	}

	@Length(min=1, max=100, message="供应商名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="供应商类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=2, message="信誉等级长度必须介于 1 和 2 之间")
	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
	
	public Categories getSupplierCategory() {
		return supplierCategory;
	}

	public void setSupplierCategory(Categories supplierCategory) {
		this.supplierCategory = supplierCategory;
	}
	
	public List<SupplierContacts> getSupplierContactsList() {
		return supplierContactsList;
	}

	public void setSupplierContactsList(List<SupplierContacts> supplierContactsList) {
		this.supplierContactsList = supplierContactsList;
	}

	public User getSysUser() {
		return sysUser;
	}

	public void setSysUser(User sysUser) {
		this.sysUser = sysUser;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getBrandLevel() {
		return brandLevel;
	}

	public void setBrandLevel(String brandLevel) {
		this.brandLevel = brandLevel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getProduceMaterial() {
		return produceMaterial;
	}

	public void setProduceMaterial(String produceMaterial) {
		this.produceMaterial = produceMaterial;
	}

	public String getPriceRange() {
		return priceRange;
	}

	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}

	public String getPurchaseType() {
		return purchaseType;
	}

	public void setPurchaseType(String purchaseType) {
		this.purchaseType = purchaseType;
	}

	public String getCooperateDesire() {
		return cooperateDesire;
	}

	public void setCooperateDesire(String cooperateDesire) {
		this.cooperateDesire = cooperateDesire;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDisplayPhotos() {
		return displayPhotos;
	}

	public void setDisplayPhotos(String displayPhotos) {
		this.displayPhotos = displayPhotos;
	}

	public String getBrandNames() {
		return brandNames;
	}

	public void setBrandNames(String brandNames) {
		this.brandNames = brandNames;
	}

	public Integer getDefaultAccount() {
		return defaultAccount;
	}

	public void setDefaultAccount(Integer defaultAccount) {
		this.defaultAccount = defaultAccount;
	}

	public BigDecimal getDefaultAccountRate() {
		return defaultAccountRate;
	}

	public void setDefaultAccountRate(BigDecimal defaultAccountRate) {
		this.defaultAccountRate = defaultAccountRate;
	}

	public Integer getReturnPeriod() {
		return returnPeriod;
	}

	public void setReturnPeriod(Integer returnPeriod) {
		this.returnPeriod = returnPeriod;
	}

	public Integer getCreditPoint() {
		return creditPoint;
	}

	public void setCreditPoint(Integer creditPoint) {
		this.creditPoint = creditPoint;
	}

	public BigDecimal getQualifiedScale() {
		return qualifiedScale;
	}

	public void setQualifiedScale(BigDecimal qualifiedScale) {
		this.qualifiedScale = qualifiedScale;
	}
	
	
	
}