/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.spm.dao.qa.RespondentsAnsDao;
import com.chinazhoufan.admin.modules.spm.dao.qa.RespondentsDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.entity.qa.RespondentsAns;

/**
 * 答卷列表Service
 * @author 贾斌
 * @version 2015-11-18
 */
@Service
@Transactional(readOnly = true)
public class RespondentsService extends CrudService<RespondentsDao, Respondents> {

	@Autowired
	RespondentsAnsDao respondentsAnsDao;
	
	public Respondents get(String id) {
		Respondents respondents = super.get(id);
		respondents.setRespondentsAnsList(respondentsAnsDao.findList(new RespondentsAns(respondents)));
		return respondents;
	}
	
	/**
	 * 根据问卷和答题会员，查询会员的答卷
	 * @param questionnaireId	问卷ID
	 * @param memberId			会员ID
	 * @return
	 */
	public Respondents getByQuestionnaireAndMember(String questionnaireId, String memberId){
		return dao.getByQuestionnaireAndMember(questionnaireId, memberId);
	}
	
	public List<Respondents> findList(Respondents respondents) {
		return super.findList(respondents);
	}
	
	public Page<Respondents> findPage(Page<Respondents> page, Respondents respondents) {
		return super.findPage(page, respondents);
	}
	
	@Transactional(readOnly = false)
	public void save(Respondents respondents) {
		super.save(respondents);
	}
	
	@Transactional(readOnly = false)
	public void delete(Respondents respondents) {
		super.delete(respondents);
	}

	/**
	 * 查询会员问卷答卷数
	 * @param member
	 * @param questionnaire
	 * @return
	 */
	public int getCount(Member member, Questionnaire questionnaire) {
		Respondents respondents = new Respondents();
		respondents.setMember(member);
		respondents.setQuestionnaire(questionnaire);
		return dao.getCount(respondents);
	}
	
}