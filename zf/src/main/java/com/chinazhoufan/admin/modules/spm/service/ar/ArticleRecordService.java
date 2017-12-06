/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ar;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.ar.ArticleRecordDao;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArticleRecord;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

/**
 * 宣传文章阅读记录Service
 * @author 刘晓东
 * @version 2016-05-27
 */
@Service
@Transactional(readOnly = true)
public class ArticleRecordService extends CrudService<ArticleRecordDao, ArticleRecord> {

	public ArticleRecord get(String id) {
		return super.get(id);
	}
	
	public List<ArticleRecord> findList(ArticleRecord articleRecord) {
		return super.findList(articleRecord);
	}
	
	public Page<ArticleRecord> findPage(Page<ArticleRecord> page, ArticleRecord articleRecord) {
		return super.findPage(page, articleRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(ArticleRecord articleRecord) {
		super.save(articleRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ArticleRecord articleRecord) {
		super.delete(articleRecord);
	}
	
	@Transactional(readOnly = false)
	public ArticleRecord saveReadCount(ArticleRecord articleRecord) {
		Config config = ConfigUtils.getConfig(ArticleRecord.BURN_AFTER_READING_FLAG);
        if(config != null) {
        	if("1".equals(config.getConfigValue())) {//1表示阅后即焚开启
        		int c = dao.hasArticleRecord(articleRecord);
        		if(c > 0) return null;
        		articleRecord.setReadCount(articleRecord.getReadCount()+1);
        		this.save(articleRecord);
        	} else {//未开启的话，直接在原来的阅读数量上加1
        		ArticleRecord ar = dao.getArticleRecord(articleRecord);
        		if(ar == null) {
        			ar = articleRecord;
        			ar.setReadCount(1);
        		} else {
        			ar.setReadCount(ar.getReadCount()+1);
        		}
        		this.save(ar);
        	}
        } else {
        	logger.info("未获取到阅后即焚的配置项，请联系管理员，检查系统业务参数配置");
        }
		return articleRecord;
	}
	
}