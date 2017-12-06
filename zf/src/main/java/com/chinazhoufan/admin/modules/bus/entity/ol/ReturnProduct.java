/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 退货货品Entity
 * @author 张金俊
 * @version 2017-04-19
 */
public class ReturnProduct extends DataEntity<ReturnProduct> {
	
	private static final long serialVersionUID = 1L;
	private ReturnOrder returnOrder;		// 退货单
	private ReturnProduce returnProduce;	// 退货产品
	private Product product;				// 货品
	private String damageType;				// 损坏类型
	private BigDecimal decMoney;			// 扣减金额
	private String responsibilityType;		// 责任人类型
	private String brokenPhotos;			// 损坏图片

	private String inStatus;			// 入库状态
	private User inBy;			// 入库人
	private Date inStartTime;			// 入库接单时间
	private Date inEndTime;			// 入库完成时间
	private String inWareplace;			// 入库货位
	private Date qualityTime;		//质检时间
	private String problemDescription; //损坏类型描述
	/******************************************** 自定义常量  *********************************************/
	private String expressNo;           // 退货物流单号 供查询使用
	private String preStatus;           // 变更前状态
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginQualityTime;			// 开始质检时间
	private Date endQualityTime;			// 结束质检时间
	private BigDecimal priceSrc;			// 产品销售价
	private List<String> imgs = Lists.newArrayList();	// 图册集合
	private Goods goods;
	public List<String> getImgs() {
		if(getBrokenPhotos() != null){
			String[] photos =getBrokenPhotos().split("\\u007C");
			for(String url:photos){
				imgs.add(url);
			}
		}
		return imgs;
	}
	
	// 退货货品损坏类型 bus_or_repair_order_breakdownType
	public static final String Dt_1	= "1";	// 轻微损坏
	public static final String Dt_2	= "2";	// 重度损坏扣款
	public static final String Dt_3	= "3";	// 重度损坏换新
	public static final String Dt_4	= "4";	// 正常
	public static final String Dt_5	= "5";	// 货品遗失
	public static final String Dt_7	= "7";	// 辅钻遗失
	//  入库状态bus_ol_return_product_inStatus
	public static final String STATUS_TOWARE		= "1";	// 待入库
	public static final String STATUS_WARE		= "2";	// 入库中
	public static final String STATUS_FINISH		= "3";	// 入库完成
	// 退货货品损坏责任人类型 bus_ol_return_product_responsibilityType
	public static final String RT_MEMBER		= "M";	// 会员责任
	public static final String RT_COMPANY		= "C";	// 我方责任
	public static final String RT_EXPRESS		= "E";	// 快递责任
	public static final String RT_NOPERSON		= "N";	// 无责任
	// 退货货品损坏类型 bus_or_repair_order_breakdownType_description
	public static final String Description_1	= "1";	// 轻微损坏
	// 构造
	public ReturnProduct() {
		super();
	}

	public ReturnProduct(String id){
		super(id);
	}
	
	
	// 方法
	public ReturnOrder getReturnOrder() {
		return returnOrder;
	}

	public void setReturnOrder(ReturnOrder returnOrder) {
		this.returnOrder = returnOrder;
	}

	public ReturnProduce getReturnProduce() {
		return returnProduce;
	}

	public void setReturnProduce(ReturnProduce returnProduce) {
		this.returnProduce = returnProduce;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getDamageType() {
		return damageType;
	}

	public void setDamageType(String damageType) {
		this.damageType = damageType;
	}

	public BigDecimal getDecMoney() {
		return decMoney;
	}

	public void setDecMoney(BigDecimal decMoney) {
		this.decMoney = decMoney;
	}

	public String getResponsibilityType() {
		return responsibilityType;
	}

	public void setResponsibilityType(String responsibilityType) {
		this.responsibilityType = responsibilityType;
	}

	public String getBrokenPhotos() {
		return brokenPhotos;
	}

	public void setBrokenPhotos(String brokenPhotos) {
		this.brokenPhotos = brokenPhotos;
	}

	public String getExpressNo() {
		return expressNo;
	}

	public void setExpressNo(String expressNo) {
		this.expressNo = expressNo;
	}

	public String getPreStatus() {
		return preStatus;
	}

	public void setPreStatus(String preStatus) {
		this.preStatus = preStatus;
	}

	public String getInStatus() {
		return inStatus;
	}

	public void setInStatus(String inStatus) {
		this.inStatus = inStatus;
	}

	public User getInBy() {
		return inBy;
	}

	public void setInBy(User inBy) {
		this.inBy = inBy;
	}

	public Date getInStartTime() {
		return inStartTime;
	}

	public void setInStartTime(Date inStartTime) {
		this.inStartTime = inStartTime;
	}

	public Date getInEndTime() {
		return inEndTime;
	}

	public void setInEndTime(Date inEndTime) {
		this.inEndTime = inEndTime;
	}

	public String getInWareplace() {
		return inWareplace;
	}

	public void setInWareplace(String inWareplace) {
		this.inWareplace = inWareplace;
	}

	public BigDecimal getPriceSrc() {
		return priceSrc;
	}

	public void setPriceSrc(BigDecimal priceSrc) {
		this.priceSrc = priceSrc;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginQualityTime() {
		return beginQualityTime;
	}

	public void setBeginQualityTime(Date beginQualityTime) {
		this.beginQualityTime = beginQualityTime;
	}


	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndQualityTime() {
		return endQualityTime;
	}

	public void setEndQualityTime(Date endQualityTime) {
		this.endQualityTime = endQualityTime;
	}


	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getQualityTime() {
		return qualityTime;
	}

	public void setQualityTime(Date qualityTime) {
		this.qualityTime = qualityTime;
	}

	public String getProblemDescription() {
		return problemDescription;
	}

	public void setProblemDescription(String problemDescription) {
		this.problemDescription = problemDescription;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	
}