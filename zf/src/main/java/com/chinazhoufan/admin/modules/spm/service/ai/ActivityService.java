/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ai;

import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ai.Activity;
import com.chinazhoufan.admin.modules.spm.dao.ai.ActivityDao;

/**
 * 活动表Service
 * @author 张金俊
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class ActivityService extends CrudService<ActivityDao, Activity> {

	public Activity get(String id) {
		return super.get(id);
	}
	
	public List<Activity> findList(Activity activity) {
		return super.findList(activity);
	}
	
	public Page<Activity> findPage(Page<Activity> page, Activity activity) {
		return super.findPage(page, activity);
	}
	
	@Transactional(readOnly = false)
	public void save(Activity activity) {
		if (StringUtils.isNotBlank(activity.getId()) && Activity.TRUE_FLAG.equals(activity.getActiveFlag())){
			throw new ServiceException("修改失败，请先停用活动后再修改！");
		}
		if (StringUtils.isBlank(activity.getId())){
			activity.setActiveFlag(Activity.FALSE_FLAG); /*默认未停用*/
		}
		super.save(activity);
	}
	
	@Transactional(readOnly = false)
	public void delete(Activity activity) {
		super.delete(activity);
	}
	
}