/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mi;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 会员签到Entity
 * @author liut
 * @version 2016-11-25
 */
public class MemberSign extends DataEntity<MemberSign> {
	
	private static final long serialVersionUID = 1L;
	private Member member;			// 会员
	private Date lastSignDate;		// 最后签到日期
	private Integer timesSeries;	// 累计连续签到次数
	private Integer timesTotal;		// 累计签到次数
	
	public MemberSign() {
		super();
	}

	public MemberSign(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="会员ID不能为空")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="最后签到日期不能为空")
	public Date getLastSignDate() {
		return lastSignDate;
	}

	

	public void setLastSignDate(Date lastSignDate) {
		this.lastSignDate = lastSignDate;
	}
	
	@Length(min=1, max=11, message="累计连续签到次数长度必须介于 1 和 11 之间")
	public Integer getTimesSeries() {
		return timesSeries;
	}

	public void setTimesSeries(Integer timesSeries) {
		this.timesSeries = timesSeries;
	}
	
	@Length(min=1, max=11, message="累计签到次数长度必须介于 1 和 11 之间")
	public Integer getTimesTotal() {
		return timesTotal;
	}

	public void setTimesTotal(Integer timesTotal) {
		this.timesTotal = timesTotal;
	}
	
}