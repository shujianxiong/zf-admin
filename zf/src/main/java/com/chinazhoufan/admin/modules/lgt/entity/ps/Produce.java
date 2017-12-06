/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 产品Entity
 * @author 陈适
 * @version 2015-10-12
 */
public class Produce extends DataEntity<Produce> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;					// 所属商品
	private String code;					// 产品编码
	private String factoryCode;         	// 产品原厂编码
	private String name;					// 产品名称
	
	private String title;                   // 展示标题
	
	private String styleType;				// 风格类型   字典：lgt_ps_produce_styleType
	private String status;					// 产品状态
	private BigDecimal standardWeight;		// 标准克重
	
	private BigDecimal pricePurchase;		// 采购价
	private BigDecimal priceOperation;		// 运算成本价
	private BigDecimal ratioOperation;		// 运算加价系数
	private BigDecimal priceSrc;			// 销售价（即体验价）
	private BigDecimal scaleExperienceFee;		// 体验费收取比例
	
	private BigDecimal scaleExperienceDeposit;  // 体验押金比例
	private BigDecimal priceDecPoint;           // 积分可低金额
	
	private BigDecimal discountPrice;		// 促销特价
	private BigDecimal discountScale;		// 促销折扣
	private BigDecimal discountFilterScale;	// 促销筛选折扣
	private Date discountFilterStart;		// 促销筛选生效时间
	private Date discountFilterEnd;			// 促销筛选失效时间
	
	private String isBuy;					// 是否可购买（2017-3-14  新增字段）
	private String isExperience;			// 是否可体验
	private String isForeBuy;				// 是否可预购
	private String isForeExperience;		// 是否可预约体验
	private String isForeexperienceDate;	// 是否可预约体验日期
	
	private Integer sellNum;				// 销量（2017-3-27）
	
	private String propertyStr;             // 产品全属性字符串集合
	private String propertySkuStr;          // 产品属性字符串集合

	private String isStock;                //有无库存

	private BigDecimal experiencePackScale;
	
	/***************************************** 自定义关联对象  ******************************************/
	private List<ProducePropvalue> producePropValues=Lists.newArrayList();	// 产品组合属性
	private List<Product> products=Lists.newArrayList();					// 产品关联货品
	
	/***************************************** 自定义查询条件属性  ******************************************/
	/**产品库存属性**/
	private Integer stockNormal;		// 正常库存
	private Integer stockLock;			// 锁定库存
	private Integer stockSellUnlocked;	// 销售未锁定库存
	private Integer stockStandard;		// 标准库存
	private Integer stockSafe;			// 安全库存
	private Integer stockWarning;		// 警戒库存
	private Integer stockDebt;			//负债库存
	/**产品查询条件**/
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;			// 结束 创建时间
	/**产品所属仓库**/
	private Warehouse warehouse;		// 产品所属仓库
	
	/**********仅做传输字段使用************/
	private String fullWareplace;		    // 产品对应的货品具体的存放路径，传值用
	private Integer num;         		    // 数量
	private String pickNo;       		    // 对应拣货单里的序号
	
	private String propvalueArr;            // 产品促销筛选条件ID集合(格式：A=B&C&D,A2=B2&C2.....)
	
	private String experienceFee;           // 体验费
	private String experienceDepositFee;    // 体验押金
	
	private String plateNo;                 // 产品存放托盘的编号
	
	private Integer minPrice;                 // 价格区间 最小值
	private Integer maxPrice;                 // 价格区间 最大值
	
	/******************************************** 自定义常量  *********************************************/
	public static final String CODEGENERATE_CODE = "lgt_ps_produce_code";			// 产品编号自动生成的业务编码
	/**系统业务参数 sys_config*/
	public static final String PRICE_BUY_RATIO 			= "priceBuyRatio";			// 购买价格计算系数
	public static final String DISCOUNT_SCALE_PLATFORM 	= "discountScalePlatform";	// 平台折扣
	/**产品状态 lgt_ps_produce_status*/
	public static final String STATUS_NEW		="1";	// 新建
	public static final String STATUS_UP		="2";	// 上架
	public static final String STATUS_DOWN		="3";	// 下架
	public static final String STATUS_FREEZE	="4";	// 冻结
	
	/**产品出入库状态*/
	public static final String OUT_SALE 		= "10"; // 销售出库 (租赁、卖出)
	public static final String OUT_AFTERMARKET 	= "11";	// 售后出库(退换)
	public static final String OUT_TRANSFER 	= "12"; // 调货出库
	public static final String OUT_INVENTORY 	= "13"; // 库存盘点出库
	public static final String IN_SALE 			= "20"; // 采购入库
	public static final String IN_AFTERMARKET 	= "21";	// 售后入库
	public static final String IN_TRANSFER 		= "22"; // 调货入库
	public static final String IN_INVENTORY 	= "23"; // 库存盘点入库
	
	/**风格类型 lgt_ps_produce_styleType**/
	public static final String ELITE_EDITION_STYLE 	= "1"; //精华服饰版
	public static final String DELUXE_EDITION_STYPE = "2"; //奢华服饰版
	
	
	
	/**
	 * 构造函数Constructor
	 */
	public Produce() {
		super();
	}

	public Produce(String id){
		super(id);
	}

	public Produce(Goods goods) {
		this.goods = goods;
	}

	public Produce(String goodsId, String name, String status, List<ProducePropvalue> producePropValues) {
		this.goods = new Goods(goodsId);
		this.name = name;
		this.status = status;
		this.producePropValues = producePropValues;
	}
	
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	@Length(min=1, max=100, message="产品编码长度必须介于 1 和 100 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=1, max=100, message="产品名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="产品状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public BigDecimal getPriceOperation() {
		return priceOperation;
	}

	public void setPriceOperation(BigDecimal priceOperation) {
		this.priceOperation = priceOperation;
	}

	public BigDecimal getPriceSrc() {
		return priceSrc;
	}

	public void setPriceSrc(BigDecimal priceSrc) {
		this.priceSrc = priceSrc;
	}

	public BigDecimal getRatioOperation() {
		return ratioOperation;
	}

	public void setRatioOperation(BigDecimal ratioOperation) {
		this.ratioOperation = ratioOperation;
	}

	public BigDecimal getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(BigDecimal discountPrice) {
		this.discountPrice = discountPrice;
	}

	public BigDecimal getDiscountScale() {
		return discountScale;
	}

	public void setDiscountScale(BigDecimal discountScale) {
		this.discountScale = discountScale;
	}

	public BigDecimal getDiscountFilterScale() {
		return discountFilterScale;
	}

	public void setDiscountFilterScale(BigDecimal discountFilterScale) {
		this.discountFilterScale = discountFilterScale;
	}

	public Date getDiscountFilterStart() {
		return discountFilterStart;
	}

	public void setDiscountFilterStart(Date discountFilterStart) {
		this.discountFilterStart = discountFilterStart;
	}

	public Date getDiscountFilterEnd() {
		return discountFilterEnd;
	}

	public void setDiscountFilterEnd(Date discountFilterEnd) {
		this.discountFilterEnd = discountFilterEnd;
	}

	public String getIsForeexperienceDate() {
		return isForeexperienceDate;
	}

	public void setIsForeexperienceDate(String isForeexperienceDate) {
		this.isForeexperienceDate = isForeexperienceDate;
	}
	
	public BigDecimal getScaleExperienceFee() {
		return scaleExperienceFee;
	}

	public void setScaleExperienceFee(BigDecimal scaleExperienceFee) {
		this.scaleExperienceFee = scaleExperienceFee;
	}

	public BigDecimal getScaleExperienceDeposit() {
		return scaleExperienceDeposit;
	}

	public void setScaleExperienceDeposit(BigDecimal scaleExperienceDeposit) {
		this.scaleExperienceDeposit = scaleExperienceDeposit;
	}

	public BigDecimal getStandardWeight() {
		return standardWeight;
	}

	public void setStandardWeight(BigDecimal standardWeight) {
		this.standardWeight = standardWeight;
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
	
	public List<ProducePropvalue> getProducePropValues() {
		return producePropValues;
	}

	public void setProducePropValues(List<ProducePropvalue> producePropValues) {
		this.producePropValues = producePropValues;
	}
	
	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Integer getStockStandard() {
		return stockStandard;
	}

	public void setStockStandard(Integer stockStandard) {
		this.stockStandard = stockStandard;
	}

	public Integer getStockSafe() {
		return stockSafe;
	}

	public void setStockSafe(Integer stockSafe) {
		this.stockSafe = stockSafe;
	}

	public Integer getStockWarning() {
		return stockWarning;
	}

	public void setStockWarning(Integer stockWarning) {
		this.stockWarning = stockWarning;
	}

	public Integer getStockNormal() {
		return stockNormal;
	}

	public void setStockNormal(Integer stockNormal) {
		this.stockNormal = stockNormal;
	}

	public Integer getStockLock() {
		return stockLock;
	}

	public void setStockLock(Integer stockLock) {
		this.stockLock = stockLock;
	}

	public Integer getStockSellUnlocked() {
		return stockSellUnlocked;
	}

	public void setStockSellUnlocked(Integer stockSellUnlocked) {
		this.stockSellUnlocked = stockSellUnlocked;
	}

	public Integer getStockDebt() {
		return stockDebt;
	}

	public void setStockDebt(Integer stockDebt) {
		this.stockDebt = stockDebt;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	public String getIsBuy() {
		return isBuy;
	}

	public void setIsBuy(String isBuy) {
		this.isBuy = isBuy;
	}

	public String getIsExperience() {
		return isExperience;
	}

	public void setIsExperience(String isExperience) {
		this.isExperience = isExperience;
	}

	public String getIsForeBuy() {
		return isForeBuy;
	}

	public void setIsForeBuy(String isForeBuy) {
		this.isForeBuy = isForeBuy;
	}

	public String getIsForeExperience() {
		return isForeExperience;
	}

	public void setIsForeExperience(String isForeExperience) {
		this.isForeExperience = isForeExperience;
	}

	public String getStyleType() {
		return styleType;
	}

	public void setStyleType(String styleType) {
		this.styleType = styleType;
	}

	public Integer getSellNum() {
		return sellNum;
	}

	public void setSellNum(Integer sellNum) {
		this.sellNum = sellNum;
	}

	public String getFullWareplace() {
		return fullWareplace;
	}

	public void setFullWareplace(String fullWareplace) {
		this.fullWareplace = fullWareplace;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getPickNo() {
		return pickNo;
	}

	public void setPickNo(String pickNo) {
		this.pickNo = pickNo;
	}

	public String getPropvalueArr() {
		return propvalueArr;
	}

	public void setPropvalueArr(String propvalueArr) {
		this.propvalueArr = propvalueArr;
	}

	public String getPropertyStr() {
		return propertyStr;
	}

	public void setPropertyStr(String propertyStr) {
		this.propertyStr = propertyStr;
	}

	public String getPropertySkuStr() {
		return propertySkuStr;
	}

	public void setPropertySkuStr(String propertySkuStr) {
		this.propertySkuStr = propertySkuStr;
	}

	public BigDecimal getPriceDecPoint() {
		return priceDecPoint;
	}

	public void setPriceDecPoint(BigDecimal priceDecPoint) {
		this.priceDecPoint = priceDecPoint;
	}

	public String getExperienceFee() {
		return experienceFee;
	}

	public void setExperienceFee(String experienceFee) {
		this.experienceFee = experienceFee;
	}

	public String getExperienceDepositFee() {
		return experienceDepositFee;
	}

	public void setExperienceDepositFee(String experienceDepositFee) {
		this.experienceDepositFee = experienceDepositFee;
	}

	public String getPlateNo() {
		return plateNo;
	}

	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(Integer minPrice) {
		this.minPrice = minPrice;
	}

	public Integer getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(Integer maxPrice) {
		this.maxPrice = maxPrice;
	}

	public BigDecimal getExperiencePackScale() {
		return experiencePackScale;
	}

	public void setExperiencePackScale(BigDecimal experiencePackScale) {
		this.experiencePackScale = experiencePackScale;
	}

	public String getIsStock() {
		return isStock;
	}

	public void setIsStock(String isStock) {
		this.isStock = isStock;
	}
	
}