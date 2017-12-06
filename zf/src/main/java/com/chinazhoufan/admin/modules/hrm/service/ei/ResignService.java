/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.ei;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.dao.ei.ResignDao;
import com.chinazhoufan.admin.modules.hrm.entity.ei.Resign;

/**
 * 员工离职记录Service
 * @author 陈适
 * @version 2015-12-09
 */
@Service
@Transactional(readOnly = true)
public class ResignService extends CrudService<ResignDao, Resign> {

	public Resign get(String id) {
		return super.get(id);
	}
	
	public List<Resign> findList(Resign resign) {
		return super.findList(resign);
	}
	
	public Page<Resign> findPage(Page<Resign> page, Resign resign) {
		return super.findPage(page, resign);
	}
	
	@Transactional(readOnly = false)
	public void save(Resign resign) {
		super.save(resign);
	}
	
	@Transactional(readOnly = false)
	public void delete(Resign resign) {
		super.delete(resign);
	}
	
}