/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.gd;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.modules.bas.entity.Video;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.google.common.collect.Lists;

/**
 * 搭配分组Entity
 * @author liut
 * @version 2017-03-15
 */
public class CollocationGroup extends DataEntity<CollocationGroup> {
	
	private static final long serialVersionUID = 1L;
	private Collocation collocation;	// 所属搭配ID
	private Categories category;		// 所属分类ID
	private String title;				// 展示标题
	private String photo;				// 展示图
	private String video;				// 展示视频
	private String usableFlag;			// 是否启用
	private Integer orderNo;			// 排序序号
	
	private String relatGoodIds;//关联的商品ID集合

	private Video deo;		// 所属视频对象

	public Video getDeo() {
		return deo;
	}

	public void setDeo(Video deo) {
		this.deo = deo;
	}
	
	//搭配分组管理的商品
	private List<GroupGoods> ggList = Lists.newArrayList();
	
	public CollocationGroup() {
		super();
	}

	public CollocationGroup(String id){
		super(id);
	}

	@NotNull(message="所属搭配ID不能为空")
	public Collocation getCollocation() {
		return collocation;
	}

	public void setCollocation(Collocation collocation) {
		this.collocation = collocation;
	}
	
	@NotNull(message="所属分类ID不能为空")
	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}
	
	@Length(min=1, max=255, message="展示图不能为空")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public List<GroupGoods> getGgList() {
		return ggList;
	}

	public void setGgList(List<GroupGoods> ggList) {
		this.ggList = ggList;
	}

	public String getRelatGoodIds() {
		return relatGoodIds;
	}

	public void setRelatGoodIds(String relatGoodIds) {
		this.relatGoodIds = relatGoodIds;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
	
	
}