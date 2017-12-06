/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.ar;

import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.dao.ar.AutoReplyDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ReplyArticle;

/**
 * 自动回复表Service
 * @author liut
 * @version 2016-05-25
 */
@Service
@Transactional(readOnly = true)
public class AutoReplyService extends CrudService<AutoReplyDao, AutoReply> {

	@Autowired
	private ReplyArticleService replyArticleService;
	
	public AutoReply get(String id) {
		return super.get(id);
	}
	
	/**
	 * 根据规则代码查询自动回复规则
	 * @param code
	 * @return
	 */
	public AutoReply getActivityByCode(AutoReply autoReply) {
		return dao.getActivityByCode(autoReply);
	}
	
	/**
	 * 根据关键字查询自动回复规则
	 * @param keyword
	 * @return
	 */
	public List<AutoReply> getActivityByKeywords(AutoReply autoReply) {
		return dao.getActivityByKeywords(autoReply);
	}
	
	public List<AutoReply> findList(AutoReply autoReply) {
		return super.findList(autoReply);
	}
	
	public Page<AutoReply> findPage(Page<AutoReply> page, AutoReply autoReply) {
		return super.findPage(page, autoReply);
	}
	
	@Transactional(readOnly = false)
	public void save(AutoReply autoReply) {
		//分两步，第一步保存自动消息回复，第二步，保存回复消息和图文消息的关联关系
		if (AutoReply.CONTENT_TYPE_TEXT.equals(autoReply.getContentType())) {
			autoReply.setText(StringEscapeUtils.unescapeHtml4(autoReply.getText()));
		}
		super.save(autoReply);
		//先删除原来的关联图文消息，然后在重新保存，物理删除
		String idList = autoReply.getArticleMsgIdList();
		if(!StringUtils.isBlank(idList)) {
			ReplyArticle ar = new ReplyArticle();
			ar.setAutoReply(autoReply);
			replyArticleService.removeReplyArticleByAutoReplyId(ar);
			ArticleMsg articleMsg = null;
			String[] ids = idList.split(",");
			for(String id : ids) {
				if(!StringUtils.isBlank(id)) {
					articleMsg = new ArticleMsg();
					articleMsg.setId(id);
					ar.setArticleMsg(articleMsg);
					replyArticleService.save(ar);
				}
			}
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(AutoReply autoReply) {
		super.delete(autoReply);
	}
	
	@Transactional(readOnly = false)
	public void updateStatus(AutoReply autoReply) {
		autoReply.preUpdate();
		dao.update(autoReply);
	}
	
	@Transactional(readOnly = false)
	public void remove(AutoReply autoReply) {
		dao.remove(autoReply);
	}
}