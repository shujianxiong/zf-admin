/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ar;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArArticle;

/**
 * 宣传文章DAO接口
 * @author 张金俊
 * @version 2016-05-19
 */
@MyBatisDao
public interface ArArticleDao extends CrudDao<ArArticle> {
	
}