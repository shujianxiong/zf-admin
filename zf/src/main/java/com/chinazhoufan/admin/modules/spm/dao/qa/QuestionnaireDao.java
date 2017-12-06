/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.qa;

import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;

/**
 * 问卷列表DAO接口
 * @author 贾斌
 * @version 2015-11-17
 */
@MyBatisDao
public interface QuestionnaireDao extends CrudDao<Questionnaire> {

	public void remove(Map<String, Object> map);

	public Questionnaire findNavCateBaseQuestion(Questionnaire questionnaire);

	/**
	 * 根据答卷ID，获取答卷对应的问卷（包含问卷问题、答卷答案）
	 * @param respondentsId 答卷ID
	 * @return
	 */
	public Questionnaire getInfoByRespondentsId(String respondentsId);

	/**
	 * 根据问卷ID，获取对应的问卷（包含问卷问题、问卷答案）
	 * @param id 问卷ID
	 * @return
	 */
	public Questionnaire getInfoById(String id);

	/**
	 * 查询问卷问题数
	 * @param id
	 * @return
	 */
	public long getQueNum(String id);

	/**
	 * 查询问卷总分数
	 * @param id
	 * @return
	 */
	public long getQuePoint(String id);
}