/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.ar;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 自动回复表Entity
 * @author liut
 * @version 2016-05-25
 */
public class AutoReply extends DataEntity<AutoReply> {
	
	private static final long serialVersionUID = 1L;
	private String code;    	// 规则编码，用于绑定菜单回复内容消息
	private String name;		// 回复规则名称
	private String keywords;	// 关键字（,分割）
	private String contentType;	// 回复内容类型
	private String text;		// 文字
	private String image;		// 图片地址
	private String voice;		// 音频地址
	private String video;		// 视频地址
	private String activeFlag;	// 启用状态（0不启用/1启用）
	private String orderNo;		// 排列序号
	private String mp;			// 所属公众号
	
	private ReplyArticle replyArticle; 	// 图文回复关联表
//	
	private List<ReplyArticle> replyArticleList = Lists.newArrayList();
	
	//图文消息
	private List<ArticleMsg> articleMsgList = Lists.newArrayList();
	
	private String articleMsgIdList;	// 多个图文消息ID，逗号分隔
	private String articleMsgNameList;	// 多个图文消息的名称，逗号分隔
	
	public static final String CONTENT_TYPE_UNDEFINED	= "undefined";	// 未识别的类型
	public static final String CONTENT_TYPE_TEXT 		= "text";		// 文本
	public static final String CONTENT_TYPE_IMG 		= "img";		// 图片
	public static final String CONTENT_TYPE_VOICE 		= "voice";		// 音频
	public static final String CONTENT_TYPE_VIDEO 		= "video";		// 视频
	public static final String CONTENT_TYPE_NEWS 		= "news";		// 图文消息
	//
	public static final String MP_ZFS	= "1";	// 周范儿公众号
	public static final String MP_ZB 		= "2";		// 周范珠宝公众号
	
	public AutoReply() {
		super();
	}
	
	public AutoReply(String id){
		super(id);
	}

	public AutoReply(String keywords, String code) {
		this.keywords = keywords;
		this.code = code;
	}
	
	@Length(min=1, max=100, message="回复规则名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
//	@Length(min=1, max=100, message="关键字（,分割）长度必须介于 1 和 100 之间")
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	
	@Length(min=1, max=10, message="回复内容类型长度必须介于 1 和 10 之间")
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	@Length(min=0, max=500, message="文字长度必须介于 0 和 500 之间")
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	@Length(min=0, max=255, message="图片地址长度必须介于 0 和 255 之间")
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	@Length(min=0, max=255, message="音频地址长度必须介于 0 和 255 之间")
	public String getVoice() {
		return voice;
	}

	public void setVoice(String voice) {
		this.voice = voice;
	}
	
	@Length(min=0, max=255, message="视频地址长度必须介于 0 和 255 之间")
	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}
	
	@Length(min=1, max=1, message="启用状态（0不启用/1启用）长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public ReplyArticle getReplyArticle() {
		return replyArticle;
	}

	public void setReplyArticle(ReplyArticle replyArticle) {
		this.replyArticle = replyArticle;
	}

	public String getArticleMsgIdList() {
		return articleMsgIdList;
	}

	public void setArticleMsgIdList(String articleMsgIdList) {
		this.articleMsgIdList = articleMsgIdList;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getArticleMsgNameList() {
		return articleMsgNameList;
	}

	public void setArticleMsgNameList(String articleMsgNameList) {
		this.articleMsgNameList = articleMsgNameList;
	}

	public List<ReplyArticle> getReplyArticleList() {
		return replyArticleList;
	}

	public void setReplyArticleList(List<ReplyArticle> replyArticleList) {
		this.replyArticleList = replyArticleList;
	}

	public List<ArticleMsg> getArticleMsgList() {
		return articleMsgList;
	}

	public void setArticleMsgList(List<ArticleMsg> articleMsgList) {
		this.articleMsgList = articleMsgList;
	}

	public String getMp() {
		return mp;
	}

	public void setMp(String mp) {
		this.mp = mp;
	}
}