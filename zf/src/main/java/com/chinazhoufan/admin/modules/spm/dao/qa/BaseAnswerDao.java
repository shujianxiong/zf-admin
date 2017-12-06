/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.qa;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseAnswer;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseQuestion;

/**
 * 问题答案列表DAO接口
 * @author 贾斌
 * @version 2015-11-17
 */
@MyBatisDao
public interface BaseAnswerDao extends CrudDao<BaseAnswer> {

	public List<BaseAnswer> findBaseQuestionId(BaseQuestion baseQuestion);

	
}