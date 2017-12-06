/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.oe;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceProduceDao;
import com.google.common.collect.Maps;

/**
 * 体验产品Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class ExperienceProduceService extends CrudService<ExperienceProduceDao, ExperienceProduce> {

	public ExperienceProduce get(String id) {
		return super.get(id);
	}
	
	public List<ExperienceProduce> findList(ExperienceProduce experienceProduce) {
		return super.findList(experienceProduce);
	}
	
	public Page<ExperienceProduce> findPage(Page<ExperienceProduce> page, ExperienceProduce experienceProduce) {
		return super.findPage(page, experienceProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(ExperienceProduce experienceProduce) {
		super.save(experienceProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExperienceProduce experienceProduce) {
		super.delete(experienceProduce);
	}

	public List<ExperienceProduce> getByExperienceOrder(String experienceOrderId) {
		return dao.getByExperienceOrder(experienceOrderId);
	}
	@Transactional(readOnly = false)
	public void updateStatus(ExperienceProduce experienceProduce) {
		dao.updateStatus(experienceProduce);
	}
}