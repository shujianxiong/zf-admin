/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.qa;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.entity.qa.RespondentsAns;

/**
 * 答卷答案列表DAO接口
 * @author 贾斌
 * @version 2015-11-18
 */
@MyBatisDao
public interface RespondentsAnsDao extends CrudDao<RespondentsAns> {

	long getCountByRespondents(Respondents respondents);

	RespondentsAns getByQueAndAns(RespondentsAns respondentsAns);

	void deleteByQueAndAns(RespondentsAns respondentsAns);

	void remove(RespondentsAns respondentsAns);

	
}