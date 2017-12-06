/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.zi;

import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 二维码管理配置Entity
 * @author 舒剑雄
 * @version 2017-09-25
 */
public class QrCode extends DataEntity<QrCode> {

	@Autowired
	private MemberService memberService;
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String summary;		// 简介
	private String qrCode;		// 二维码
	private String openids;		// 关注人openids
	private String randomCode;		// 随机码
	private Integer followTimes;		// 关注次数
	private String activeFlag;		// 启用状态


	private Integer userNum;		// 用户注册人数
	public QrCode() {
		super();
	}

	public QrCode(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	@Length(min=0, max=100, message="二维码长度必须介于 0 和 500 之间")
	public String getQrCode() {
		return qrCode;
	}

	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
	
	@Length(min=1, max=64, message="随机码长度必须介于 1 和 64 之间")
	public String getRandomCode() {
		return randomCode;
	}

	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}
	
	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Integer getFollowTimes() {
		return followTimes;
	}

	public void setFollowTimes(Integer followTimes) {
		this.followTimes = followTimes;
	}

	public String getOpenids() {
		return openids;
	}

	public void setOpenids(String openids) {
		this.openids = openids;
	}

	public Integer getUserNum() {
		if(getOpenids() != null){
			Integer num = 0;
			for(String openId :getOpenids().split(",")){
				Member member = memberService.getByOpenid(openId);
				if(member != null){
					num++;
				}
			}
			userNum = num;
		}
		return userNum;
	}

	public void setUserNum(Integer userNum) {
		this.userNum = userNum;
	}
}