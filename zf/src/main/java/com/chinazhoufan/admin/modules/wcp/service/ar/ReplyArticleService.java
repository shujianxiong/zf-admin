/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.ar;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.dao.ar.ReplyArticleDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ReplyArticle;

/**
 * 回复图文关联表Service
 * @author liut
 * @version 2016-05-25
 */
@Service
@Transactional(readOnly = true)
public class ReplyArticleService extends CrudService<ReplyArticleDao, ReplyArticle> {

	public ReplyArticle get(String id) {
		return super.get(id);
	}
	
	public List<ReplyArticle> findList(ReplyArticle replyArticle) {
		return super.findList(replyArticle);
	}
	
	public Page<ReplyArticle> findPage(Page<ReplyArticle> page, ReplyArticle replyArticle) {
		return super.findPage(page, replyArticle);
	}
	
	@Transactional(readOnly = false)
	public void save(ReplyArticle replyArticle) {
//		super.save(replyArticle);
		replyArticle.preInsert();
		dao.insert(replyArticle);
	}
	
	@Transactional(readOnly = false)
	public void delete(ReplyArticle replyArticle) {
		super.delete(replyArticle);
	}
	
	@Transactional(readOnly = false)
	public void removeReplyArticleByAutoReplyId(ReplyArticle replyArticle){
		dao.removeReplyArticleByAutoReplyId(replyArticle);
	}
	
	public List<ReplyArticle> listByReply(ReplyArticle replyArticle) {
		return dao.listByReply(replyArticle);
	}
}