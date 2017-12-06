/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ar;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 宣传文章阅读记录Entity
 * @author 刘晓东
 * @version 2016-05-27
 */
public class ArticleRecord extends DataEntity<ArticleRecord> {
	
	private static final long serialVersionUID = 1L;
	private String ip;				// 阅读用户IP（必填）
	private String wechatOpenid;	// 用户openid
	private Member member;			// 会员ID
	private ArArticle article;		// 文章ID（必填）
	private int readCount = 0;		// 阅读次数
	
	public static final String BURN_AFTER_READING_FLAG = "burnAfterReadingFlag"; //阅后即焚开启状态参数编码burnAfterReadingFlag， 参数值：（0：关闭 1：开启）
	
	
	
	public ArticleRecord() {
		super();
	}

	public ArticleRecord(String id){
		super(id);
	}
	
	

	@Length(min=1, max=100, message="阅读用户IP长度必须介于 1 和 100 之间")
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getWechatOpenid() {
		return wechatOpenid;
	}

	public void setWechatOpenid(String wechatOpenid) {
		this.wechatOpenid = wechatOpenid;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Length(min=1, max=64, message="文章ID长度必须介于 1 和 64 之间")
	public ArArticle getArticle() {
		return article;
	}

	public void setArticle(ArArticle article) {
		this.article = article;
	}

}