/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarecounterDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;
import com.google.common.collect.Maps;

/**
 * 货架列表Service
 * @author 贾斌
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class WarecounterService extends CrudService<WarecounterDao, Warecounter> {

	
	@Autowired
	private WarecounterDao warecounterDao;
	public Warecounter get(String id) {
		return super.get(id);
	}
	
	public List<Warecounter> findList(Warecounter warecounter) {
		return super.findList(warecounter);
	}
	
	public List<Warecounter> findList() {
		return warecounterDao.findAllList(new Warecounter());
	}
	
	public Page<Warecounter> findPage(Page<Warecounter> page, Warecounter warecounter) {
		return super.findPage(page, warecounter);
	}
	
	@Transactional(readOnly = false)
	public void save(Warecounter warecounter) {
		super.save(warecounter);
	}
	
	@Transactional(readOnly = false)
	public void delete(Warecounter warecounter) {
		super.delete(warecounter);
	}
	
	public int countByWarearea(String wareareaId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("wareareaId", wareareaId);
		map.put("DEL_FLAG_NORMAL", Warecounter.DEL_FLAG_NORMAL);
		return dao.countByWarearea(map);
	}
	
	
}