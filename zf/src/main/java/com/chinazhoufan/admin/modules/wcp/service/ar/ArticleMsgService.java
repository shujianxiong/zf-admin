/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.ar;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.mpsdk4j.vo.api.MediaTemp;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.dao.ar.ArticleMsgDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;

import static com.chinazhoufan.admin.common.persistence.BaseEntity.DEL_FLAG_NORMAL;

/**
 * 图文消息表Service
 * @author liut
 * @version 2016-05-25
 */
@Service
@Transactional(readOnly = true)
public class ArticleMsgService extends CrudService<ArticleMsgDao, ArticleMsg> {

	public ArticleMsg get(String id) {
		return super.get(id);
	}
	
	public List<ArticleMsg> findList(ArticleMsg articleMsg) {
		return super.findList(articleMsg);
	}
	
	public Page<ArticleMsg> findPage(Page<ArticleMsg> page, ArticleMsg articleMsg) {
		return super.findPage(page, articleMsg);
	}
	
	@Transactional(readOnly = false)
	public void save(ArticleMsg articleMsg) {
		super.save(articleMsg);
	}
	
	@Transactional(readOnly = false)
	public void delete(ArticleMsg articleMsg) {
		super.delete(articleMsg);
	}

	@Transactional(readOnly = false)
	public void articleMsgSave(String mediaId ,List<MediaTemp> mediaTemps) {
		//本地图文消息新增
		for (int i = 0;i<mediaTemps.size();i++) {
			ArticleMsg articleMsg = new ArticleMsg();
			articleMsg.setMediaId(mediaId);
			articleMsg.setIndexOf(String.valueOf(i));
			articleMsg.setDescription(mediaTemps.get(i).getContent());
			articleMsg.setLinkUrl(mediaTemps.get(i).getContent_source_url());
			articleMsg.setTitle(mediaTemps.get(i).getTitle());
			articleMsg.setPic(mediaTemps.get(i).getThumb_media_id());
			articleMsg.setName(mediaTemps.get(i).getTitle());
			articleMsg.setCreateBy(UserUtils.getUser());
			articleMsg.setCreateDate(new Date());
			articleMsg.setUpdateBy(UserUtils.getUser());
			articleMsg.setUpdateDate(new Date());
			articleMsg.setDelFlag(DEL_FLAG_NORMAL);
			save(articleMsg);
		}

	}
	@Transactional(readOnly = false)
	public void articleMsgUpdate(MediaTemp mediaTemp) {
		//本地图文消息修改
		ArticleMsg articleMsg = new ArticleMsg();
		articleMsg.setMediaId(mediaTemp.getMediaId());
		articleMsg.setDescription(mediaTemp.getContent());
		articleMsg.setIndexOf(mediaTemp.getIndex());
		articleMsg.setLinkUrl(mediaTemp.getContent_source_url());
		articleMsg.setTitle(mediaTemp.getTitle());
		articleMsg.setPic(mediaTemp.getThumb_media_id());
		articleMsg.setName(mediaTemp.getTitle());
		articleMsg.setCreateBy(UserUtils.getUser());
		articleMsg.setCreateDate(new Date());
		articleMsg.setUpdateBy(UserUtils.getUser());
		articleMsg.setUpdateDate(new Date());
		articleMsg.setDelFlag(DEL_FLAG_NORMAL);
		dao.updateByMedia(articleMsg);

	}
	@Transactional(readOnly = false)
	public void deleteByMediaId(String mediaId) {
		dao.deleteByMediaId(mediaId);
	}

	@Transactional(readOnly = false)
	public ArticleMsg getByMedia(MediaTemp mediaTemp) {
		ArticleMsg articleMsg = new ArticleMsg();
		articleMsg.setMediaId(mediaTemp.getMediaId());
		articleMsg.setIndexOf(mediaTemp.getIndex());
		return dao.getByMedia(articleMsg);
	}
}