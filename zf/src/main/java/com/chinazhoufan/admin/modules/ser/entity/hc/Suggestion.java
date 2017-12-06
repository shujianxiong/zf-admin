/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.hc;

import com.google.common.collect.Lists;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

import java.util.List;

/**
 * 帮助中心建议Entity
 * @author 张金俊
 * @version 2017-07-31
 */
public class Suggestion extends DataEntity<Suggestion> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员
	private String content;		// 内容
	private String photoUrls;	// 图片URL（|分割）
	private String tel;			// 联系电话
	private String dealStatus;	// 处理状态

	/******************************************** 自定义常量  *********************************************/
	// 建议处理状态 ser_hc_suggestion_dealStatus
	public static final String DEALSTATUS_TODEL	= "1";	// 待处理
	public static final String DEALSTATUS_DELING	= "2";	// 处理中
	public static final String DEALSTATUS_DELED	= "3";	// 已处理

	/******************************************** 自定义变量  *********************************************/

	private List<String> imgs = Lists.newArrayList();	// 图册集合

	public List<String> getImgs() {
		if(getPhotoUrls() != null){
			String[] photos =getPhotoUrls().split("\\u007C");
			for(String url:photos){
				imgs.add(url);
			}
		}
		return imgs;
	}

	public void setImgs(List<String> imgs) {
		this.imgs = imgs;
	}

	public Suggestion() {
		super();
	}

	public Suggestion(String id){
		super(id);
	}

	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=500, message="内容长度必须介于 1 和 500 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=2000, message="图片URL长度必须介于 1 和 2000 之间")
	public String getPhotoUrls() {
		return photoUrls;
	}

	public void setPhotoUrls(String photoUrls) {
		this.photoUrls = photoUrls;
	}
	
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Length(min=1, max=2, message="处理状态长度必须介于 1 和 2 之间")
	public String getDealStatus() {
		return dealStatus;
	}

	public void setDealStatus(String dealStatus) {
		this.dealStatus = dealStatus;
	}
	
}