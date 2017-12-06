/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ac;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.spm.dao.ac.ActivityResearchRcDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearchRc;

/**
 * 调研活动参与记录Service
 * @author 刘晓东
 * @version 2016-05-27
 */
@Service
@Transactional(readOnly = true)
public class ActivityResearchRcService extends CrudService<ActivityResearchRcDao, ActivityResearchRc> {

	public ActivityResearchRc get(String id) {
		return super.get(id);
	}
	
	/**
	 * 根据调研活动ID，查询该调研活动的参与记录数量
	 * @param arId		调研活动ID
	 * @param status	参与记录状态
	 * @return
	 */
	public Integer getCountByArIdAndStatus(String arId, String status) {
		return dao.getCountByArIdAndStatus(arId, status);
	}
	
	/**
	 * 根据会员和调研活动，查询调研活动参与记录
	 * @param memberId	会员ID
	 * @param arId		调研活动ID
	 * @return
	 */
	public ActivityResearchRc findByMemberAndAr(String memberId, String arId) {
		List<ActivityResearchRc> arRcList = dao.findByMemberAndAr(memberId, arId);
		return arRcList==null||arRcList.size()==0 ? null : arRcList.get(0);
	}
	
	public List<ActivityResearchRc> findList(ActivityResearchRc activityResearchRc) {
		return super.findList(activityResearchRc);
	}
	
	public Page<ActivityResearchRc> findPage(Page<ActivityResearchRc> page, ActivityResearchRc activityResearchRc) {
		return super.findPage(page, activityResearchRc);
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityResearchRc activityResearchRc) {
		super.save(activityResearchRc);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityResearchRc activityResearchRc) {
		super.delete(activityResearchRc);
	}

	/**
	 * 参与记录完成
	 * @param activityId 活动ID
	 * @param memberId 会员ID
	 */
	@Transactional(readOnly = false)
	public void finish(String activityId, String memberId) {
		ActivityResearchRc activityResearchRc = findByMemberAndAr(memberId,activityId);
		if (activityResearchRc == null) {
			throw new ServiceException("警告：未获取到对应参与记录！");
		}else if (ActivityResearchRc.STATUS_FINISH.equals(activityResearchRc.getStatus())) {
			throw new ServiceException("警告：该参与记录已经完成！");
		}else {
			activityResearchRc.setStatus(ActivityResearchRc.STATUS_FINISH);
			save(activityResearchRc);
		}
	}
	
}