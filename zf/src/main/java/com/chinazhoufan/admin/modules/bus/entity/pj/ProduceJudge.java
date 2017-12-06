/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.pj;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 产品评价Entity
 * @author liut
 * @version 2017-07-28
 */
public class ProduceJudge extends DataEntity<ProduceJudge> {
	
	private static final long serialVersionUID = 1L;
	private ExperienceOrder experienceOrder;		// 体验订单ID
	private Goods goods;		// 商品ID
	private Produce produce;		// 产品ID
	private Member member;		// 会员ID
	private String produceLevel;		// 产品评价等级
	private String serviceLevel;		// 服务评价等级
	private String expressLevel;		// 物流评价等级
	 
	private String checkStatus;       // 审核状态   check_status
	private User checkBy;           // 审核人
	private Date checkTime;           // 审核时间
	
	
	/******************************************** 自定义关联对象  *********************************************/
	private List<ProduceJudgePhoto> photoList = Lists.newArrayList();
	private List<ProduceJudgeSummary> summaryList = Lists.newArrayList();
	
	/******************************************** 自定义常量  *********************************************/
	public static final String CHECKSTATUS_TO_CHECK    = "1";			// 待审核
	public static final String CHECKSTATUS_PASS        = "2";			// 审核通过
	public static final String CHECKSTATUS_REFUSED     = "3";			// 审核拒绝
	
	public ProduceJudge() {
		super();
	}

	public ProduceJudge(String id){
		super(id);
	}

	@Length(min=1, max=64, message="商品ID长度必须介于 1 和 64 之间")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	@Length(min=1, max=64, message="产品ID长度必须介于 1 和 64 之间")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=2, message="产品评价等级长度必须介于 1 和 2 之间")
	public String getProduceLevel() {
		return produceLevel;
	}

	public void setProduceLevel(String produceLevel) {
		this.produceLevel = produceLevel;
	}
	
	@Length(min=1, max=2, message="服务评价等级长度必须介于 1 和 2 之间")
	public String getServiceLevel() {
		return serviceLevel;
	}

	public void setServiceLevel(String serviceLevel) {
		this.serviceLevel = serviceLevel;
	}
	
	@Length(min=1, max=2, message="物流评价等级长度必须介于 1 和 2 之间")
	public String getExpressLevel() {
		return expressLevel;
	}

	public void setExpressLevel(String expressLevel) {
		this.expressLevel = expressLevel;
	}

	@Length(min=1, max=64, message="订单ID长度必须介于 1 和 64 之间")
	public ExperienceOrder getExperienceOrder() {
		return experienceOrder;
	}

	public void setExperienceOrder(ExperienceOrder experienceOrder) {
		this.experienceOrder = experienceOrder;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public User getCheckBy() {
		return checkBy;
	}

	public void setCheckBy(User checkBy) {
		this.checkBy = checkBy;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public List<ProduceJudgePhoto> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(List<ProduceJudgePhoto> photoList) {
		this.photoList = photoList;
	}

	public List<ProduceJudgeSummary> getSummaryList() {
		return summaryList;
	}

	public void setSummeryList(List<ProduceJudgeSummary> summaryList) {
		this.summaryList = summaryList;
	}
	
	
}