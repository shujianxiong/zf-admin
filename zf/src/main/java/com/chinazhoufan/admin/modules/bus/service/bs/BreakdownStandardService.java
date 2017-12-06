/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.bs;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.bus.dao.bs.BreakdownStandardDao;

/**
 * 货品定损标准Service
 * @author liut
 * @version 2016-11-19
 */
@Service
@Transactional(readOnly = true)
public class BreakdownStandardService extends CrudService<BreakdownStandardDao, BreakdownStandard> {

	public BreakdownStandard get(String id) {
		return super.get(id);
	}
	
	public List<BreakdownStandard> findList(BreakdownStandard breakdownStandard) {
		return super.findList(breakdownStandard);
	}
	
	public Page<BreakdownStandard> findPage(Page<BreakdownStandard> page, BreakdownStandard breakdownStandard) {
		return super.findPage(page, breakdownStandard);
	}
	
	@Transactional(readOnly = false)
	public void save(BreakdownStandard breakdownStandard) {
		super.save(breakdownStandard);
	}
	
	@Transactional(readOnly = false)
	public void delete(BreakdownStandard breakdownStandard) {
		super.delete(breakdownStandard);
	}


	public Boolean getByType(String breakdownType) {
		BreakdownStandard breakdownStandard =dao.getByType(breakdownType);
		if(breakdownStandard == null){
			return false;
		}
		if(BreakdownStandard.BEANS_YES.equals(breakdownStandard.getBeansDecFlag().toString())){
			return true;
		}
		return false;
	}
}