/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.dao.qa.RespondentsAnsDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.entity.qa.RespondentsAns;

/**
 * 答卷答案列表Service
 * @author 贾斌
 * @version 2015-11-18
 */
@Service
@Transactional(readOnly = true)
public class RespondentsAnsService extends CrudService<RespondentsAnsDao, RespondentsAns> {

	
	public RespondentsAns get(String id) {
		return super.get(id);
	}
	
	public List<RespondentsAns> findList(RespondentsAns respondentsAns) {
		return super.findList(respondentsAns);
	}
	
	public Page<RespondentsAns> findPage(Page<RespondentsAns> page, RespondentsAns respondentsAns) {
		return super.findPage(page, respondentsAns);
	}
	
	@Transactional(readOnly = false)
	public void save(RespondentsAns respondentsAns) {
		super.save(respondentsAns);
	}
	
	@Transactional(readOnly = false)
	public void delete(RespondentsAns respondentsAns) {
		super.delete(respondentsAns);
	}

	public long getCountByRespondents(Respondents respondents) {
		return dao.getCountByRespondents(respondents);
	}

	/**
	 * 删除答题记录
	 * 真删
	 */
	@Transactional(readOnly = false)
	public void remove(RespondentsAns respondentsAns) {
		dao.remove(respondentsAns);
	}
	/**
	 * 根据问题和答案
	 * 查询已有的答题记录
	 * @param respondentsAns
	 * @return
	 */
	public RespondentsAns getByQueAndAns(RespondentsAns respondentsAns) {
		return dao.getByQueAndAns(respondentsAns);
	}
	
	/**
	 * 如果已有答题记录则删除
	 * @param respondentsAns
	 */
	@Transactional(readOnly = false)
	public void removeExistAnswer(RespondentsAns respondentsAns) {
		RespondentsAns respondentsAnsOld = getByQueAndAns(respondentsAns);
		if (respondentsAnsOld != null && StringUtils.isNotBlank(respondentsAnsOld.getId())) {
			dao.delete(respondentsAnsOld);
		}
	}

	/**
	 * 调研活动答题
	 * @param respondentsAns
	 */
	@Transactional(readOnly = false)
	public void respondentsAns(RespondentsAns respondentsAns) {
		RespondentsAns respondentsAnsOld = getByQueAndAns(respondentsAns);
		if (respondentsAnsOld != null && StringUtils.isNotBlank(respondentsAnsOld.getId())) {
			remove(respondentsAnsOld);
		}else {
			save(respondentsAns);
		}
	}
	
}