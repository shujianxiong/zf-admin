/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ai;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ai.ActivityRecord;
import com.chinazhoufan.admin.modules.spm.dao.ai.ActivityRecordDao;

/**
 * 活动参与记录Service
 * @author 张金俊
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class ActivityRecordService extends CrudService<ActivityRecordDao, ActivityRecord> {

	public ActivityRecord get(String id) {
		return super.get(id);
	}
	
	public List<ActivityRecord> findList(ActivityRecord activityRecord) {
		return super.findList(activityRecord);
	}
	
	public Page<ActivityRecord> findPage(Page<ActivityRecord> page, ActivityRecord activityRecord) {
		return super.findPage(page, activityRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityRecord activityRecord) {
		super.save(activityRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityRecord activityRecord) {
		super.delete(activityRecord);
	}
	
}