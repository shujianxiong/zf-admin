/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pr;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 奖品表Entity
 * @author liut
 * @version 2016-05-19
 */
public class Prize extends DataEntity<Prize> {
	
	private static final long serialVersionUID = 1L;
	private String code;		// 奖品编号
	private String name;		// 奖品名称
	private String type;		// 奖品类型
	private String status;		// 奖品状态（新建发布上下架）
	private String displayPrice;		// 展示金额
	private String introduce;		// 奖品介绍
	private String mainPhoto;		// 主图片
	private String displayPhotos;		// 展示图片
	private String costPoint;		// 所需积分
	private String stockNum;		// 库存数量
	private String usableNum;		// 可用库存数量
	
	//奖品状态
	public static final String PRIZE_NEW = "1";//新建
	public static final String PRIZE_PUBLISH = "2";//发布
	public static final String PRIZE_UP = "3";//上架(会员可以看到的奖品状态)
	public static final String PRIZE_DOWN = "4";//下架
	
	public static final String GENERATECODE_PRIZE = "spm_pr_prize";//合同编码自动生成的业务编码
	
	public Prize() {
		super();
	}

	public Prize(String id){
		super(id);
	}

	@Length(min=1, max=50, message="奖品编号长度必须介于 1 和 50 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=1, max=50, message="奖品名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="奖品类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=2, message="奖品状态（新建发布上下架）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getDisplayPrice() {
		return displayPrice;
	}

	public void setDisplayPrice(String displayPrice) {
		this.displayPrice = displayPrice;
	}
	
	@Length(min=1, max=200, message="奖品介绍长度必须介于 1 和 200 之间")
	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	public String getMainPhoto() {
		return mainPhoto;
	}

	public void setMainPhoto(String mainPhoto) {
		this.mainPhoto = mainPhoto;
	}
	
	public String getDisplayPhotos() {
		return displayPhotos;
	}

	public void setDisplayPhotos(String displayPhotos) {
		this.displayPhotos = displayPhotos;
	}
	
	@Length(min=1, max=11, message="所需积分长度必须介于 1 和 11 之间")
	public String getCostPoint() {
		return costPoint;
	}

	public void setCostPoint(String costPoint) {
		this.costPoint = costPoint;
	}
	
	@Length(min=1, max=11, message="库存数量长度必须介于 1 和 11 之间")
	public String getStockNum() {
		return stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}
	
	@Length(min=1, max=11, message="可用库存数量长度必须介于 1 和 11 之间")
	public String getUsableNum() {
		return usableNum;
	}

	public void setUsableNum(String usableNum) {
		this.usableNum = usableNum;
	}
	
}