/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.sa;

import com.chinazhoufan.admin.modules.bas.entity.Video;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 周范秀场Entity
 * @author 张金俊
 * @version 2017-08-07
 */
public class ShowArea extends DataEntity<ShowArea> {
	
	private static final long serialVersionUID = 1L;
	private Member member;			// 会员
	private String video;			// 视频
	private String title;			// 标题
	private Date displayTime;		// 展示时间
	private Integer playNum;		// 播放次数
	private String usableFlag;		// 是否启用

	private Video deo;		// 所属视频对象

	public Video getDeo() {
		return deo;
	}

	public void setDeo(Video deo) {
		this.deo = deo;
	}

	public ShowArea() {
		super();
	}

	public ShowArea(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Length(min=1, max=255, message="视频长度必须介于 1 和 255 之间")
	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	@Length(min=1, max=100, message="标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="展示时间不能为空")
	public Date getDisplayTime() {
		return displayTime;
	}

	public void setDisplayTime(Date displayTime) {
		this.displayTime = displayTime;
	}
	
	@NotNull(message="播放次数不能为空")
	public Integer getPlayNum() {
		return playNum;
	}

	public void setPlayNum(Integer playNum) {
		this.playNum = playNum;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}