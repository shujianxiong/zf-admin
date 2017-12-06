/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 货品明细管理Entity
 * @author 陈适
 * @version 2015-10-12
 * 
 * PS：货品因销售或其他原因从公司总库存出去之后，货品对应的删除状态变为“已删除”（del_flag=1，伪删）
 */
public class Product extends DataEntity<Product> {
	
	private static final long serialVersionUID = 1L;
	private Produce produce;			// 产品
	private Goods goods;				// 商品
	private String code;				// 货品编码
	private String scanCode;			// 货品电子码
	private String status;				// 状态		1：正常	2：锁定	3：体验中	4：已售出		5：已移除
	private String updateStatus;		//修改状态 1：可修改，0：不可修改（货品基本参数）
	private String statusLogistics;  	// 物流状态
	private Wareplace wareplace;		// 存放货位编号
	private User holdUser;				// 持有员工编号
	private String factoryCode;			// 原厂编码
	private String certificateNo;		// 证书编号
	private BigDecimal weight;			// 克重
	private BigDecimal pricePurchase;	// 采购价
	private Supplier supplier;          // 来源供应商
	
	private String brokenPhoto;
	
	/************************* 自定义查询参数  **************************/
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;			// 结束 创建时间
	
	/*************************** 常量 ****************************/
	public static final String CODEGENERATE_CODE = "lgt_ps_product_code";		// 货品编号自动生成的业务编码
	public static final String CONFIG_CODE_WEIGHTFLOAT = "weightFloatPermit";	// 克重允许浮动大小（单位：g）
	
	/** 货品状态 lgt_ps_product_status*/
	public static final String STATUS_NORMAL	= "1";  // 正常（正常库存中）
	public static final String STATUS_LOCKED 	= "2";	// 锁定（锁定库存中。维修、调拨、出入库过程中、用户确认收货前，货品锁定。锁定的货品不支持新的体验和销售。）
	public static final String STATUS_HIRING   	= "3";	// 体验中（锁定库存中。系统自动确认收货或用户确认收货时货品进入体验中。体验中的货品不支持新的体验和销售。体验结束质检人员确认收到货品后进入锁定，质检完入库后解锁变为正常）
	public static final String STATUS_SOLD    	= "4";	// 已售出（不占库存。即库存数量不包含已售出的货品。体验单转购买的，体验单完成时，对应购买单完成，购买货品变为已售出。售出的货品保留货品记录）
	public static final String STATUS_REMOVED  	= "5";	// 已移除（不占库存，即库存数量不包含已移除的货品。货品遗失、彻底损坏等状况下，从系统移除。移除的货品保留货品记录，）
	/** 货品修改状态 */
	public static final String STATUS_UPDATE_NO	= "0";  // 不可修改
	public static final String STATUS_UPDATE_YES	= "1";	// 可修改
	/** 货品物流状态 lgt_ps_product_statusLogistics*/
	public static final String STATUS_LGT_IN				= "1";	// 在库
	public static final String STATUS_LGT_WAIT_IN			= "2";	// 待入库
	public static final String STATUS_LGT_PACKAGEING		= "3"; 	// 配货中
	public static final String STATUS_LGT_DELIVERING		= "4"; 	// 发货中
	public static final String STATUS_LGT_EXPRESSING		= "5"; 	// 送货中
	public static final String STATUS_LGT_ARRIVED			= "6"; 	// 已送达
	public static final String STATUS_LGT_BACKING			= "7"; 	// 回货中
	public static final String STATUS_LGT_RECEIVEING		= "8"; 	// 收货中
	public static final String STATUS_LGT_DISASSEMBLEING	= "9";	// 拆包中（拆包人员接单，货品变为拆包中。）
	public static final String STATUS_LGT_WAIT_REPAIR		= "10";	// 待维修（单个租赁货品质检完成后，货品变为对应）
	public static final String STATUS_LGT_REPAIRING			= "11";	// 维修中 
	public static final String STATUS_LGT_WAIT_BACK_FACTORY	= "12";	// 待返厂
	
	// 货品货位变更记录      传值用
	private String preWarehouseFullName;	// 变更前完整的存放位置
	private String postWarehouseFullName;	// 变更后完整的存放位置
	
	private String fullWareplace;//货品完成的存放路径，传值用
	
	private List<String> productStatusList = Lists.newArrayList();	// 货品状态合集，用于以下场景，比如：需要展示可调用的货品数据（上架和下架都属于可调用的数据）
	private List<String> imgs = Lists.newArrayList();	// 图册集合

	public List<String> getImgs() {
		if(getBrokenPhoto() != null){
			String[] photos =getBrokenPhoto().split("\\u007C");
			for(String url:photos){
				imgs.add(url);
			}
		}
		return imgs;
	}
	public void setImgs(List<String> imgs) {
		this.imgs = imgs;
	}

	/** 构造 */
	public Product() {
		super();
	}

	public Product(String id){
		super(id);
	}
	
	
	/** 方法 */
//	@NotEmpty(message="产品不能为空")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
//	@NotEmpty(message="商品不能为空")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Wareplace getWareplace() {
		return wareplace;
	}

	public void setWareplace(Wareplace wareplace) {
		this.wareplace = wareplace;
	}

	public User getHoldUser() {
		return holdUser;
	}

	public void setHoldUser(User holdUser) {
		this.holdUser = holdUser;
	}
	
	@NotEmpty(message="货品编码不能为空")
	@Length(min=0, max=255, message="货品编码长度必须介于 0 和 255 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getScanCode() {
		return scanCode;
	}

	public void setScanCode(String scanCode) {
		this.scanCode = scanCode;
	}

	@Length(min=1, max=2, message="当前状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min=1, max=2, message="当前状态长度必须介于 1 和 2 之间")
	public String getUpdateStatus() {
		return updateStatus;
	}

	public void setUpdateStatus(String updateStatus) {
		this.updateStatus = updateStatus;
	}

	public String getStatusLogistics() {
		return statusLogistics;
	}

	public void setStatusLogistics(String statusLogistics) {
		this.statusLogistics = statusLogistics;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
	
	public BigDecimal getPricePurchase() {
		return pricePurchase;
	}

	public void setPricePurchase(BigDecimal pricePurchase) {
		this.pricePurchase = pricePurchase;
	}

	public String getFactoryCode() {
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}
	
	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getPreWarehouseFullName() {
		return preWarehouseFullName;
	}

	public void setPreWarehouseFullName(String preWarehouseFullName) {
		this.preWarehouseFullName = preWarehouseFullName;
	}

	public String getPostWarehouseFullName() {
		return postWarehouseFullName;
	}

	public void setPostWarehouseFullName(String postWarehouseFullName) {
		this.postWarehouseFullName = postWarehouseFullName;
	}

	public List<String> getProductStatusList() {
		return productStatusList;
	}

	public void setProductStatusList(List<String> productStatusList) {
		this.productStatusList = productStatusList;
	}

	public String getFullWareplace() {
		return fullWareplace;
	}

	public void setFullWareplace(String fullWareplace) {
		this.fullWareplace = fullWareplace;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public String getBrokenPhoto() {
		return brokenPhoto;
	}

	public void setBrokenPhoto(String brokenPhoto) {
		this.brokenPhoto = brokenPhoto;
	}
		
}