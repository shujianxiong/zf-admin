/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pm;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 积分商品Entity
 * @author 张金俊
 * @version 2016-12-02
 */
public class PointGoods extends DataEntity<PointGoods> {
	
	private static final long serialVersionUID = 1L;
	private String code;			// 编号
	private String name;			// 名称
	private String upFlag;			// 上架标记
	private String srcType;			// 来源类型
	private String srcId;			// 来源ID
	private String gainType;		// 获取限制类型
	private String listPhoto;		// 列表图片
	private String mainPhoto;		// 主图片
	private BigDecimal displayPrice;// 展示金额
	private String introduce;		// 奖品介绍
	private Integer point;			// 所需积分
	private Integer totalNum;		// 总库存数量
	private Integer usableNum;		// 可用库存数量
	
	// 来源类型 [spm_pm_point_goods_srcType]
	public static final String SRCTYPE_COUPON = "1";		// 优惠券
	// 获取限制类型 [spm_pm_point_goods_gainType]

	public static final String GAINTYPE_UNLIMITED = "1";	// 无限制
	public static final String GAINTYPE_REALNAMED = "2";	// 认证会员专属
	
	private String displayName; //展示来源名称，临时字段
	
	public PointGoods() {
		super();
	}

	public PointGoods(String id){
		super(id);
	}
	

	@Length(min=1, max=50, message="编号长度必须介于 1 和 50 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=1, max=50, message="名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="上架标记长度必须介于 1 和 1 之间")
	public String getUpFlag() {
		return upFlag;
	}

	public void setUpFlag(String upFlag) {
		this.upFlag = upFlag;
	}
	
	@Length(min=1, max=2, message="来源类型长度必须介于 1 和 2 之间")
	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}
	
	@Length(min=1, max=64, message="来源ID长度必须介于 1 和 64 之间")
	public String getSrcId() {
		return srcId;
	}

	public void setSrcId(String srcId) {
		this.srcId = srcId;
	}
	
	@Length(min=1, max=2, message="获取限制类型长度必须介于 1 和 2 之间")
	public String getGainType() {
		return gainType;
	}

	public void setGainType(String gainType) {
		this.gainType = gainType;
	}
	
	@Length(min=1, max=255, message="列表图片长度必须介于 1 和 255 之间")
	public String getListPhoto() {
		return listPhoto;
	}

	public void setListPhoto(String listPhoto) {
		this.listPhoto = listPhoto;
	}
	
	@Length(min=1, max=255, message="主图片长度必须介于 1 和 255 之间")
	public String getMainPhoto() {
		return mainPhoto;
	}

	public void setMainPhoto(String mainPhoto) {
		this.mainPhoto = mainPhoto;
	}
	
	@NotNull(message="展示金额不能为空")
	public BigDecimal getDisplayPrice() {
		return displayPrice;
	}

	public void setDisplayPrice(BigDecimal displayPrice) {
		this.displayPrice = displayPrice;
	}
	
	@Length(min=1, max=2000, message="奖品介绍长度必须介于 1 和 2000 之间")
	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	@NotNull(message="所需积分不能为空")
	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}
	
	@NotNull(message="总库存数量不能为空")
	public Integer getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	
	public Integer getUsableNum() {
		return usableNum;
	}

	public void setUsableNum(Integer usableNum) {
		this.usableNum = usableNum;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	
}