/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.service.cc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.cap.dao.cc.CapitalChangeDao;
import com.chinazhoufan.admin.modules.cap.dao.cc.CapitalDao;
import com.chinazhoufan.admin.modules.cap.entity.cc.Capital;
import com.chinazhoufan.admin.modules.cap.entity.cc.CapitalChange;

/**
 * 资产设备变动记录Service
 * @author 贾斌
 * @version 2015-12-08
 */
@Service
@Transactional(readOnly = true)
public class CapitalChangeService extends CrudService<CapitalChangeDao, CapitalChange> {

	@Autowired
	private CapitalDao capitalDao;
	public CapitalChange get(String id) {
		return super.get(id);
	}
	
	public List<CapitalChange> findList(CapitalChange capitalChange) {
		return super.findList(capitalChange);
	}
	
	public Page<CapitalChange> findPage(Page<CapitalChange> page, CapitalChange capitalChange) {
		return super.findPage(page, capitalChange);
	}
	
	@Transactional(readOnly = false)
	public void save(CapitalChange capitalChange) {
		Capital capital = capitalDao.get(capitalChange.getCapital().getId());
		capital.setCapitalNo(capitalChange.getNewCapitalNo());
		capital.setNum(capitalChange.getNewNum());
		capitalDao.update(capital);
//		capitalChange.setOldNum(capital.getNum());
//		capitalChange.setOldCapitalNo(capital.getCapitalNo());
		super.save(capitalChange);
	}
	
	@Transactional(readOnly = false)
	public void delete(CapitalChange capitalChange) {
		super.delete(capitalChange);
	}
	
}