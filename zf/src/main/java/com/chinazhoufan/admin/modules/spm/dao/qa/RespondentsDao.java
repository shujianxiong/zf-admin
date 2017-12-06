/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.qa;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;

/**
 * 答卷列表DAO接口
 * @author 贾斌
 * @version 2015-11-18
 */
@MyBatisDao
public interface RespondentsDao extends CrudDao<Respondents> {

	int getCount(Respondents respondents);
	
	/**
	 * 根据问卷和答题会员，查询会员的答卷
	 * @param questionnaireId	问卷ID
	 * @param memberId			会员ID
	 * @return
	 */
	public Respondents getByQuestionnaireAndMember(@Param("questionnaireId")String questionnaireId, @Param("memberId")String memberId);
	
}