/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity.pv;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.common.utils.excel.annotation.ExcelField;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 页面访问记录Entity
 * @author liut
 * @version 2017-03-03
 */
public class PvRecord extends DataEntity<PvRecord> {
	
	private static final long serialVersionUID = 1L; 
	private String pageType;		// 页面类型    字典名称  bas_pv_record_pageType  （首页/场景/搭配列表/搭配详情/商品详情/评论）
	private String pageCategory;	// 页面类别    字典名称  bas_pv_record_pageCategory  （通用/详情）
	private String detailId;		// 详情ID
	private Member member;		// 会员ID
	private Date viewTime;		// 访问时间
	
	private Integer count;   //浏览量
	
	public PvRecord() {
		super();
	}

	public PvRecord(String id){
		super(id);
	}

	@Length(min=1, max=2, message="页面类型长度必须介于 1 和 2 之间")
	@ExcelField(title="页面类型", align=2, sort=1)
	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	
	@Length(min=1, max=2, message="页面类别长度必须介于 1 和 2 之间")
	public String getPageCategory() {
		return pageCategory;
	}

	public void setPageCategory(String pageCategory) {
		this.pageCategory = pageCategory;
	}
	
	@Length(min=0, max=64, message="详情ID长度必须介于 0 和 64 之间")
	public String getDetailId() {
		return detailId;
	}

	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}
	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="访问时间不能为空")
	public Date getViewTime() {
		return viewTime;
	}

	public void setViewTime(Date viewTime) {
		this.viewTime = viewTime;
	}

	@ExcelField(title="访问量", align=2, sort=2)
	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
}