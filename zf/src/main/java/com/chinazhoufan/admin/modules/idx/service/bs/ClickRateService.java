/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.bs;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.bs.ClickRate;
import com.chinazhoufan.admin.modules.idx.dao.bs.ClickRateDao;

/**
 * 频道场景点击量Service
 * @author liut
 * @version 2016-11-28
 */
@Service
@Transactional(readOnly = true)
public class ClickRateService extends CrudService<ClickRateDao, ClickRate> {

	public ClickRate get(String id) {
		return super.get(id);
	}
	
	public List<ClickRate> findList(ClickRate clickRate) {
		return super.findList(clickRate);
	}
	
	public Page<ClickRate> findPage(Page<ClickRate> page, ClickRate clickRate) {
		return super.findPage(page, clickRate);
	}
	
	@Transactional(readOnly = false)
	public void save(ClickRate clickRate) {
		super.save(clickRate);
	}
	
	@Transactional(readOnly = false)
	public void delete(ClickRate clickRate) {
		super.delete(clickRate);
	}
	
}