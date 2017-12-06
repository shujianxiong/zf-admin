/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.rg;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 注册邀请码Entity
 * @author liut
 * @version 2016-11-17
 */
public class RgInviteCode extends DataEntity<RgInviteCode> {
	
	private static final long serialVersionUID = 1L;
	private String inviteCode;		// 邀请码
	private String useFlag;		// 使用标记（0：未使用）
	private Member useMember;		// 使用会员ID
	private Date useTime;		// 使用时间
	
	/**
	 * 临时时间查询字段
	 */
	private Date beginTimeTemp;
	private Date endTimeTemp;
	
	public RgInviteCode() {
		super();
	}

	public RgInviteCode(String id){
		super(id);
	}

	
	@Length(min=1, max=50, message="邀请码长度必须介于 1 和 50 之间")
	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}
	
	@Length(min=1, max=1, message="使用标记（0：未使用）长度必须介于 1 和 1 之间")
	public String getUseFlag() {
		return useFlag;
	}

	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	
	@Length(min=0, max=64, message="使用会员ID长度必须介于 0 和 64 之间")
	public Member getUseMember() {
		return useMember;
	}

	public void setUseMember(Member useMember) {
		this.useMember = useMember;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}

	public Date getBeginTimeTemp() {
		return beginTimeTemp;
	}

	public void setBeginTimeTemp(Date beginTimeTemp) {
		this.beginTimeTemp = beginTimeTemp;
	}

	public Date getEndTimeTemp() {
		return endTimeTemp;
	}

	public void setEndTimeTemp(Date endTimeTemp) {
		this.endTimeTemp = endTimeTemp;
	}
	
}