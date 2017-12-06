/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ep;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 体验包体验记录Entity
 * @author 舒剑雄
 * @version 2017-08-31
 */
public class ExperiencePackItem extends DataEntity<ExperiencePackItem> {
	
	private static final long serialVersionUID = 1L;
	private String no;		// 支付流水号
	private Member member;		// 会员ID
	private ExperiencePack experiencePack;		// 体验包ID
	private String payType;		// 支付类型（1、免费 2、收费）
	private Date payTime;		// 支付时间
	private String openid;		// 支付人openid
	private String returnResult;		// 支付返回结果
	private Date startDate;		// 启用日期
	private Date endDate;		// 结束日期
	private String  status;		// 状态（1：新建:2：有效:3：失效）
	private Integer useTimes;		//已体验次数


	//experience_pack_status
	public static final String NO_USE	= "3";	// 过期
	public static final String CAN_USE		= "2";	// 有效
	public static final String TO_PAY		= "1";	// 新建
	//experience_pack_pay_type
	public static final String PAY_FREE	= "1";	// 免费
	public static final String PAY_NO_FREE		= "2";	// 收费
	public ExperiencePackItem() {
		super();
	}

	public ExperiencePackItem(String id){
		super(id);
	}

	@Length(min=1, max=64, message="支付流水号长度必须介于 1 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	public ExperiencePack getExperiencePack() {
		return experiencePack;
	}

	public void setExperiencePack(ExperiencePack experiencePack) {
		this.experiencePack = experiencePack;
	}
	
	@Length(min=1, max=2, message="支付类型（1、免费 2、收费）长度必须介于 1 和 2 之间")
	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	
	@Length(min=0, max=100, message="支付人openid长度必须介于 0 和 100 之间")
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	@Length(min=0, max=100, message="支付返回结果长度必须介于 0 和 100 之间")
	public String getReturnResult() {
		return returnResult;
	}

	public void setReturnResult(String returnResult) {
		this.returnResult = returnResult;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="启用日期不能为空")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="结束日期不能为空")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Length(min=1, max=2, message="是否有效长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getUseTimes() {
		return useTimes;
	}

	public void setUseTimes(Integer useTimes) {
		this.useTimes = useTimes;
	}
}