/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.dao.qa.QuestionnaireDao;
import com.chinazhoufan.admin.modules.spm.dao.qa.QuestionnaireQueDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.entity.qa.QuestionnaireQue;
import com.google.common.collect.Maps;

/**
 * 问卷列表Service
 * @author 贾斌
 * @version 2015-11-17
 */
@Service
@Transactional(readOnly = true)
public class QuestionnaireService extends CrudService<QuestionnaireDao, Questionnaire> {

	@Autowired
	QuestionnaireQueDao questionnaireQueDao;
	
	public Questionnaire get(String id) {
		Questionnaire questionnaire = super.get(id);
		questionnaire.setQuestionnaireQueList(questionnaireQueDao.findList(new QuestionnaireQue(questionnaire)));
		return questionnaire;
	}
	
	public List<Questionnaire> findList(Questionnaire questionnaire) {
		return super.findList(questionnaire);
	}
	
	public Page<Questionnaire> findPage(Page<Questionnaire> page, Questionnaire questionnaire) {
		return super.findPage(page, questionnaire);
	}
	
	@Transactional(readOnly = false)
	public void save(Questionnaire questionnaire) {
		if (StringUtils.isBlank(questionnaire.getId())) {
			questionnaire.setStatus(Questionnaire.STATUS_NEW); //设置为新建状态
		}
		super.save(questionnaire);
	}
	
	@Transactional(readOnly = false)
	public void delete(Questionnaire questionnaire) {
		super.delete(questionnaire);
	}
	
	@Transactional(readOnly =false)
	public void remove(String questionnaireId, String baseQuestionId,String queId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("baseQuestionId", baseQuestionId);
		map.put("questionnaireId", questionnaireId);
		map.put("id", queId);
		dao.remove(map);
	}

	public Questionnaire findNavCateBaseQuestion(Questionnaire questionnaire) {
		if(null != questionnaire.getQuestionnaireQueList()&& questionnaire.getQuestionnaireQueList().size() !=0)
			return dao.findNavCateBaseQuestion(questionnaire);
		return null;
	}

	/**
	 * 根据答卷ID，获取答卷对应的问卷（包含问卷问题、答卷答案）
	 * @param respondentsId 答卷ID
	 * @return
	 */
	public Questionnaire getInfoByRespondentsId(String id) {
		return dao.getInfoByRespondentsId(id);
	}

	/**
	 * 根据问卷ID，获取对应的问卷（包含问卷问题、问卷答案）
	 * @param id 问卷ID
	 * @return
	 */
	public Questionnaire getInfoById(String id) {
		return dao.getInfoById(id);
	}
	
	/**
	 * 保存问卷问题
	 * @param questionnaire
	 */
	@Transactional(readOnly=false)
	public void saveQuestion(Questionnaire questionnaire) {
		List<QuestionnaireQue> list = questionnaire.getQuestionnaireQueList();
		for (QuestionnaireQue questionnaireQue : list) {
			if(Questionnaire.DEL_FLAG_NORMAL.equals(questionnaireQue.getDelFlag())){
				questionnaireQue.setQuestionnaire(questionnaire);
				if (StringUtils.isBlank(questionnaireQue.getId())) {
					questionnaireQue.preInsert();
					questionnaireQueDao.insert(questionnaireQue);
				}else {
					questionnaireQue.preUpdate();
					questionnaireQueDao.update(questionnaireQue);
				}
			}else {
				questionnaireQueDao.delete(questionnaireQue);
			}
		}
	}

	/**
	 * 查询问卷问题数
	 * @param id
	 * @return
	 */
	public long getQueNum(String id) {
		return dao.getQueNum(id);
	}

	/**
	 * 查询问卷总分数
	 * @param id
	 * @return
	 */
	public long getQuePoint(String id) {
		return dao.getQuePoint(id);
	}
	
}