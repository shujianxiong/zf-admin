/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ac;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.ac.AcActivityDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;

/**
 * 调研活动表Service
 * @author liut
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class AcActivityService extends CrudService<AcActivityDao, AcActivity> {

	public AcActivity get(String id) {
		return super.get(id);
	}
	
	public List<AcActivity> findList(AcActivity acActivity) {
		return super.findList(acActivity);
	}
	
	public Page<AcActivity> findPage(Page<AcActivity> page, AcActivity acActivity) {
		return super.findPage(page, acActivity);
	}
	
	@Transactional(readOnly = false)
	public void save(AcActivity acActivity) {
		super.save(acActivity);
	}
	
	@Transactional(readOnly = false)
	public void delete(AcActivity acActivity) {
		super.delete(acActivity);
	}
	
	public Prize getPrizeByActivityId(String activityId) {
		List<Prize> list = dao.getPrizeByActivityId(activityId);
		return list==null||list.isEmpty()?null:list.get(0);
	}
	
}