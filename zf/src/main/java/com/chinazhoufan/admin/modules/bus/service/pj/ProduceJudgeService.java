/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.pj;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.dao.pj.ProduceJudgeDao;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudge;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 产品评价Service
 * @author liut
 * @version 2017-07-28
 */
@Service
@Transactional(readOnly = true)
public class ProduceJudgeService extends CrudService<ProduceJudgeDao, ProduceJudge> {

	
	@Autowired
	ExperienceOrderService experienceOrderService;
	
	public ProduceJudge get(String id) {
		return super.get(id);
	}

	/**
	 * 通过体验单ID查询评价
	 * @param experienceOrderId
	 * @return
	 */
	public ProduceJudge getByExperienceOrderId(String experienceOrderId) {
		return dao.getByExperienceOrderId(experienceOrderId);
	}
	
	public List<ProduceJudge> findList(ProduceJudge produceJudge) {
		return super.findList(produceJudge);
	}
	
	public Page<ProduceJudge> findPage(Page<ProduceJudge> page, ProduceJudge produceJudge) {
		return super.findPage(page, produceJudge);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceJudge produceJudge) {
		super.save(produceJudge);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceJudge produceJudge) {
		super.delete(produceJudge);
	}
	
	@Transactional(readOnly = false)
	public void checkProduceJudge(ProduceJudge produceJudge) {
		produceJudge.setCheckBy(UserUtils.getUser());
		produceJudge.setCheckTime(new Date());
		super.save(produceJudge);
	}
	
}