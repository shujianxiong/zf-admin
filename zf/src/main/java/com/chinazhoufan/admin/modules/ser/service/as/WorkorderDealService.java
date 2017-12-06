/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.as;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import com.chinazhoufan.admin.modules.ser.entity.as.WorkorderDeal;
import com.chinazhoufan.admin.modules.ser.dao.as.WorkorderDealDao;

/**
 * 售后工单处理Service
 * @author liut
 * @version 2017-05-18
 */
@Service
@Transactional(readOnly = true)
public class WorkorderDealService extends CrudService<WorkorderDealDao, WorkorderDeal> {

	@Autowired
	private WorkorderService workorderService;
	
	public WorkorderDeal get(String id) {
		return super.get(id);
	}
	
	public List<WorkorderDeal> findList(WorkorderDeal workorderDeal) {
		return super.findList(workorderDeal);
	}
	
	public Page<WorkorderDeal> findPage(Page<WorkorderDeal> page, WorkorderDeal workorderDeal) {
		return super.findPage(page, workorderDeal);
	}
	
	@Transactional(readOnly = false)
	public void save(WorkorderDeal workorderDeal) {
		super.save(workorderDeal);
		
		if(workorderDeal.getNextDealUser() != null && StringUtils.isNotBlank(workorderDeal.getNextDealUser().getId())) {
			WorkorderDeal wd = new WorkorderDeal();
			wd.setAppointedUser(workorderDeal.getNextDealUser());
			wd.setRequiredDealtype(workorderDeal.getRequiredDealtype());
			wd.setRequiredTime(workorderDeal.getRequiredTime());
			wd.setWorkorder(workorderDeal.getWorkorder());
			super.save(wd);
			
			Workorder wo = workorderDeal.getWorkorder();
			wo.setAppointedUser(workorderDeal.getNextDealUser());
			wo.setStatus(Workorder.WORKORDER_STATUS_WAIT);
			workorderService.updateDealUserAndStatusById(wo);
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkorderDeal workorderDeal) {
		super.delete(workorderDeal);
	}
	
	
	public WorkorderDeal findLatestByWorkOrder(WorkorderDeal workorderDeal) {
		return dao.findLatestByWorkOrder(workorderDeal);
	}
}