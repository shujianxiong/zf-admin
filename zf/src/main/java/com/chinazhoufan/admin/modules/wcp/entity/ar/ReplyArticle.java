/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.ar;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 回复图文关联表Entity
 * @author liut
 * @version 2016-05-25
 */
public class ReplyArticle extends DataEntity<ReplyArticle> {
	
	private static final long serialVersionUID = 1L;
	private AutoReply autoReply;		// 自动回复ID
	private ArticleMsg articleMsg;		// 图文ID
	
	public ReplyArticle() {
		super();
	}

	public ReplyArticle(String id){
		super(id);
	}
	
	
	@Length(min=1, max=64, message="自动回复ID长度必须介于 1 和 64 之间")
	public AutoReply getAutoReply() {
		return autoReply;
	}

	public void setAutoReply(AutoReply autoReply) {
		this.autoReply = autoReply;
	}

	
	@Length(min=1, max=64, message="图文ID长度必须介于 1 和 64 之间")
	public ArticleMsg getArticleMsg() {
		return articleMsg;
	}

	public void setArticleMsg(ArticleMsg articleMsg) {
		this.articleMsg = articleMsg;
	}

	
}