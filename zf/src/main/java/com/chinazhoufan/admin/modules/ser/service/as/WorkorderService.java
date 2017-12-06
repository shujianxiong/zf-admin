/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.as;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import com.chinazhoufan.admin.modules.ser.entity.as.WorkorderDeal;
import com.chinazhoufan.admin.modules.ser.dao.as.WorkorderDao;

/**
 * 售后工单Service
 * @author liut
 * @version 2017-05-18
 */
@Service
@Transactional(readOnly = true)
public class WorkorderService extends CrudService<WorkorderDao, Workorder> {

	@Autowired
	private WorkorderDealService workorderDealService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	
	public Workorder get(String id) {
		return super.get(id);
	}
	
	public List<Workorder> findList(Workorder workorder) {
		return super.findList(workorder);
	}
	
	public Page<Workorder> findPage(Page<Workorder> page, Workorder workorder) {
		return super.findPage(page, workorder);
	}
	
	@Transactional(readOnly = false)
	public void save(Workorder workorder) {
		if(StringUtils.isBlank(workorder.getId())) {
			workorder.setWorkorderNo(codeGeneratorService.generateCode(Workorder.GENERATECODE_WORKORDERNO));
		}
		
		super.save(workorder);
		
		WorkorderDeal workorderDeal = workorder.getWorkorderDeal();
		if(workorderDeal != null){
			workorderDeal.setWorkorder(workorder);
			workorderDeal.setAppointedUser(workorder.getAppointedUser());
			workorderDealService.save(workorderDeal);
		}

	}
	
	@Transactional(readOnly = false)
	public void delete(Workorder workorder) {
		super.delete(workorder);
	}
	
	public Workorder find(Workorder workOrder) {
		return dao.find(workOrder);
	}
	
	/**
	 * 根据ID更新工单状态
	 * @param workOrder
	 */
	@Transactional(readOnly = false)
	public void updateStatusById(Workorder workOrder) {
		dao.updateStatusById(workOrder);
	}
	
	
	/**
	 * 根据ID更新下一个处理人和工单状态
	 * @param workOrder
	 */
	@Transactional(readOnly = false)
	public void updateDealUserAndStatusById(Workorder workOrder) {
		dao.updateDealUserAndStatusById(workOrder);
	}

	/**
	 * 根据ORDERID更新工单状态
	 * @param workOrder
	 */
	@Transactional(readOnly = false)
	public void updateStatusByOrderId(Workorder workOrder) {
		dao.updateStatusByOrderId(workOrder);
	}
}