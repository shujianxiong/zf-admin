/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.service.cc;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.cap.dao.cc.CapitalDao;
import com.chinazhoufan.admin.modules.cap.entity.cc.Capital;

/**
 * 公司资产设备表Service
 * @author 贾斌
 * @version 2015-12-08
 */
@Service
@Transactional(readOnly = true)
public class CapitalService extends CrudService<CapitalDao, Capital> {

	public Capital get(String id) {
		return super.get(id);
	}
	
	public List<Capital> findList(Capital capital) {
		return super.findList(capital);
	}
	
	public Page<Capital> findPage(Page<Capital> page, Capital capital) {
		return super.findPage(page, capital);
	}
	
	@Transactional(readOnly = false)
	public void save(Capital capital) {
		super.save(capital);
	}
	
	@Transactional(readOnly = false)
	public void delete(Capital capital) {
		super.delete(capital);
	}
	
}