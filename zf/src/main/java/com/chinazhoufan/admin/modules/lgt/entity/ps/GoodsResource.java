/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品资源Entity
 * @author 陈适
 * @version 2015-10-27
 */
public class GoodsResource extends DataEntity<GoodsResource> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;			// 商品ID
	private String useType;			// 使用类型（0：展示图   	1：图册 2:单品图册）
	private String resourceType;	// 资源类型（0：图片  	1：视频	2：音频 ）
	private String url;				// 资源URL
	private Integer orderBy;  		//排序（针对图册）

	/*************************** 常量 ****************************/
	// 资源类型
	public static final String TYPE_PHOTO="0";		// 图片
	public static final String TYPE_IMGS="3";		// 单品图册
	public GoodsResource() {
		super();
	}

	public GoodsResource(Goods goods, String useType, String resourceType) {
		this.goods = goods;
		this.useType = useType;
		this.resourceType = resourceType;
	}

	public GoodsResource(String id){
		super(id);
	}
	
	public GoodsResource(String resourceType,String useType,String url){
		this.resourceType=resourceType;
		this.useType=useType;
		this.url=url;
	}
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	@Length(min=1, max=2, message="使用类型（icon/展示图等）长度必须介于 1 和 2 之间")
	public String getUseType() {
		return useType;
	}

	public void setUseType(String useType) {
		this.useType = useType;
	}
	
	@Length(min=1, max=2, message="资源类型（图片/视频/音频/脚本）长度必须介于 1 和 2 之间")
	public String getResourceType() {
		return resourceType;
	}

	public void setResourceType(String resourceType) {
		this.resourceType = resourceType;
	}
	
	@Length(min=1, max=255, message="资源URL长度必须介于 1 和 255 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}

	public static final String GOODS_RESOURCES_USE_DEFAULT="0";//展示
	public static final String GOODS_RESOURCES_USE_ATLAS="1";//图册
	public static final String GOODS_RESOURCES_USE_SINGLE_ATLAS="2";//单品图册

	public static final String GOODS_RESOURCES_TYPE_PICTURE="0";//图片
	public static final String GOODS_RESOURCES_TYPE_VIDEO="1";//视频
	public static final String GOODS_RESOURCES_TYPE_AUDIO="2";//音频
}