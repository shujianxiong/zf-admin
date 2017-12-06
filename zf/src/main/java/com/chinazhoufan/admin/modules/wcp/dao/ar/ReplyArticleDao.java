/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.dao.ar;


import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ReplyArticle;

/**
 * 回复图文关联表DAO接口
 * @author liut
 * @version 2016-05-25
 */
@MyBatisDao
public interface ReplyArticleDao extends CrudDao<ReplyArticle> {
	
	public void removeReplyArticleByAutoReplyId(ReplyArticle replyArticle);
	
	public List<ReplyArticle> listByReply(ReplyArticle replyArticle);
	
}