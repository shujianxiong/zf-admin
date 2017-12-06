/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.math.BigDecimal;
import java.util.List;

import com.chinazhoufan.admin.modules.bas.entity.Video;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Designer;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.google.common.collect.Lists;

/**
 * 商品表Entity
 * @author 张金俊
 * @version 2015-10-12
 */
public class Goods extends DataEntity<Goods> {
	
	private static final long serialVersionUID = 1L;
	
	private Categories category = new Categories();	// 关联分类
	private Brand brand;				// 品牌
	private Designer designer;			// 设计师
	private String code;			// 商品编码
	private String factoryCode;		// 商品原厂编码
	private String name;			// 商品名称
	private String englishName;		// 商品英文名称
	private String status;			// 商品状态
	private String title;			// 展示标题
	private BigDecimal price;		// 展示价格
	private String icon;			// 商品icon（缩略图 url地址）
	private String photo;			// 商品photo（大图）
	private String story;			// 展示故事
	private String introduction;	// 展示介绍
	private String showVideo;		// 展示视频
	private String isCouponUsable;	// 是否可用优惠券
	private String isRecommend;		// 是否推荐

	private String useRange;//使用范围   字典：useRange
	private String modelPhoto;//模特图
	
	private String certificatePhoto;//商品证书图
	
	
	private String samplePhoto;     // 商品样图
	private String singlePhoto;		// 单品列表图


	private String origin;			// 产地

	private String propertyStr;     // 商品属性字符串集合（2017-07-11）
	
	private int sellNum;			// 商品销量
	private String relateGoodsIds;	// 关联商品ID
	private List<String> goodsListids = Lists.newArrayList();		// 关联商品
	
	/************************* 自定义关联对象  **************************/
	private List<GoodsProp> goodsProp=Lists.newArrayList();			// 商品属性集合
	
	private List<Produce> produces=Lists.newArrayList();			// 商品关联产品
	
	private List<GoodsResource> goodsResources=Lists.newArrayList();// 展示图册

	private List<GoodsResource> singleResources=Lists.newArrayList();// 单品图册
	
	private List<Tags> tagss = Lists.newArrayList();				// 商品关联标签
	
	private List<Supplier> supplierList = Lists.newArrayList();      //关联供应商集合

	private Video deo;		// 所属视频对象
	/************************* 自定义参数  **************************/
	private int judgesCount = 0;	// 商品评价数量
	private String minBuyPrice;		// 购买最低价//del
	private String maxBuyPrice; 	// 购买最高价//del
	private String originalPrice; 	// 原价
	private String hirePrice; 		// 租赁最低价格
	private int allExistStock; 		// 总库存 produce 库存的和//del
	private List<GoodsPropvalue> goodsPropvalue = Lists.newArrayList();	// 属性值集合（前端查询传参用）
	private String goodsResourcesUrlStr;	// 商品图册URL拼接字符串 |分割
	private String singleResourcesUrlStr;	// 单品图册URL拼接字符串 |分割
	//----便于查询赋值，新增参数
	private String produceId;		// 关联产品ID
	private String warehouseId;		// 关联仓库ID
	
	private Tags tags;     //商品标签
	
	private String isSelectedGoods; //主要用于商品选择器查询非新建状态的商品
	
	/*************************** 常量 ****************************/
	public static final String CODEGENERATE_CODE = "lgt_ps_goods_code";//商品编码自动生成的业务编码
	// 商品状态
	public static final String STATUS_NEW="1";		// 新建
	public static final String STATUS_UP="2";		// 上架
	public static final String STATUS_DOWN="3";		// 下架
	
	/**
	 * 构造函数Constructor
	 */
	public Goods() {
		super();
	}
	
	public Goods(String id){
		super(id);
	}
	
	public Goods(Categories category) {
		super();
		this.category = category;
	}
	
	public Goods(List<Tags> tags, String goodsId) {
		this.tagss = tags;
		this.id = goodsId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=1, max=100, message="商品名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}

	@Length(min=1, max=2, message="商品状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=255, message="展示标题长度必须介于 1 和 255 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	public String getIsCouponUsable() {
		return isCouponUsable;
	}

	public void setIsCouponUsable(String isCouponUsable) {
		this.isCouponUsable = isCouponUsable;
	}
	
	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public List<GoodsProp> getGoodsProp() {
		return goodsProp;
	}

	public void setGoodsProp(List<GoodsProp> goodsProp) {
		this.goodsProp = goodsProp;
	}
	
	
	public List<Produce> getProduces() {
		return produces;
	}

	public void setProduces(List<Produce> produces) {
		this.produces = produces;
	}

	public List<GoodsResource> getGoodsResources() {
		return goodsResources;
	}

	public void setGoodsResources(List<GoodsResource> goodsResources) {
		this.goodsResources = goodsResources;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public int getSellNum() {
		return sellNum;
	}

	public void setSellNum(int sellNum) {
		this.sellNum = sellNum;
	}
	
	public List<String> getGoodsListids() {
		return goodsListids;
	}

	public void setGoodsListids(List<String> goodsListids) {
		this.goodsListids = goodsListids;
	}

	public List<Tags> getTagss() {
		return tagss;
	}

	public void setTagss(List<Tags> tagss) {
		this.tagss = tagss;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Designer getDesigner() {
		return designer;
	}

	public void setDesigner(Designer designer) {
		this.designer = designer;
	}

	public String getIsRecommend() {
		return isRecommend;
	}

	public void setIsRecommend(String isRecommend) {
		this.isRecommend = isRecommend;
	}

	public String getFactoryCode() {
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}

	public String getRelateGoodsIds() {
		return relateGoodsIds;
	}

	public void setRelateGoodsIds(String relateGoodsIds) {
		this.relateGoodsIds = relateGoodsIds;
	}
	
	/*******************自定义参数get()、set()方法******************************/
	
	public int getJudgesCount() {
		return judgesCount;
	}

	public void setJudgesCount(int judgesCount) {
		this.judgesCount = judgesCount;
	}

	public String getMinBuyPrice() {
		return minBuyPrice;
	}
	
	public int getAllExistStock() {
		return allExistStock;
	}

	public void setAllExistStock(int allExistStock) {
		this.allExistStock = allExistStock;
	}

	public void setMinBuyPrice(String minBuyPrice) {
		this.minBuyPrice = minBuyPrice;
	}

	public String getMaxBuyPrice() {
		return maxBuyPrice;
	}

	public void setMaxBuyPrice(String maxBuyPrice) {
		this.maxBuyPrice = maxBuyPrice;
	}

	public List<GoodsPropvalue> getGoodsPropvalue() {
		return goodsPropvalue;
	}

	public void setGoodsPropvalue(List<GoodsPropvalue> goodsPropvalue) {
		this.goodsPropvalue = goodsPropvalue;
	}

	public String getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}

	public String getHirePrice() {
		return hirePrice;
	}

	public void setHirePrice(String hirePrice) {
		this.hirePrice = hirePrice;
	}

	public String getGoodsResourcesUrlStr() {
		return goodsResourcesUrlStr;
	}

	public void setGoodsResourcesUrlStr(String goodsResourcesUrlStr) {
		this.goodsResourcesUrlStr = goodsResourcesUrlStr;
	}

	public String getProduceId() {
		return produceId;
	}

	public void setProduceId(String produceId) {
		this.produceId = produceId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	public Tags getTags() {
		return tags;
	}

	public void setTags(Tags tags) {
		this.tags = tags;
	}

	public String getIsSelectedGoods() {
		return isSelectedGoods;
	}

	public void setIsSelectedGoods(String isSelectedGoods) {
		this.isSelectedGoods = isSelectedGoods;
	}

	public String getUseRange() {
		return useRange;
	}

	public void setUseRange(String useRange) {
		this.useRange = useRange;
	}

	public String getModelPhoto() {
		return modelPhoto;
	}

	public void setModelPhoto(String modelPhoto) {
		this.modelPhoto = modelPhoto;
	}

	public String getCertificatePhoto() {
		return certificatePhoto;
	}

	public void setCertificatePhoto(String certificatePhoto) {
		this.certificatePhoto = certificatePhoto;
	}

	public List<Supplier> getSupplierList() {
		return supplierList;
	}

	public void setSupplierList(List<Supplier> supplierList) {
		this.supplierList = supplierList;
	}

	public String getSamplePhoto() {
		return samplePhoto;
	}

	public void setSamplePhoto(String samplePhoto) {
		this.samplePhoto = samplePhoto;
	}

	public String getPropertyStr() {
		return propertyStr;
	}

	public void setPropertyStr(String propertyStr) {
		this.propertyStr = propertyStr;
	}

	public String getShowVideo() {
		return showVideo;
	}

	public void setShowVideo(String showVideo) {
		this.showVideo = showVideo;
	}

	public Video getDeo() {
		return deo;
	}

	public void setDeo(Video deo) {
		this.deo = deo;
	}

	public String getSinglePhoto() {
		return singlePhoto;
	}

	public void setSinglePhoto(String singlePhoto) {
		this.singlePhoto = singlePhoto;
	}

	public String getSingleResourcesUrlStr() {
		return singleResourcesUrlStr;
	}

	public void setSingleResourcesUrlStr(String singleResourcesUrlStr) {
		this.singleResourcesUrlStr = singleResourcesUrlStr;
	}

	public List<GoodsResource> getSingleResources() {
		return singleResources;
	}

	public void setSingleResources(List<GoodsResource> singleResources) {
		this.singleResources = singleResources;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}
}