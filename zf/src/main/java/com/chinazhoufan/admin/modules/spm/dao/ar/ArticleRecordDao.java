/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ar;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArticleRecord;

/**
 * 宣传文章阅读记录DAO接口
 * @author 刘晓东
 * @version 2016-05-27
 */
@MyBatisDao
public interface ArticleRecordDao extends CrudDao<ArticleRecord> {
	
	/**
	 * 根据ip或者openId,或者会员member,id来查找当前文章的阅读记录，该用户是否已阅本条消息
	 * @param articleRecord
	 * @return
	 */
	public int hasArticleRecord(ArticleRecord articleRecord); 
	
	/**
	 * 根据IP和文章ID，累计同一人阅读次数
	 * @param articleRecord
	 * @return
	 */
	public ArticleRecord getArticleRecord(ArticleRecord articleRecord);
}