/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;

/**
 * 任务表Service
 * @author 刘晓东
 * @version 2015-10-22
 */
@Service
@Transactional(readOnly = true)
public class BasMissionService<D extends BasMissionDao<T>, T extends BasMission<T>> extends CrudService<D, T> {
	@Autowired
	private BasMissionDao basMissionDao;
	public T get(String id) {
		return super.get(id);
	}
	
	public List<T> findList(T t) {
		if("BasMission".equals(t.getClass().getSimpleName())){
			return basMissionDao.findList(t);
		}
		return super.findList(t);
	}
	
	public Page<T> findPage(Page<T> page, T t) {
		if("BasMission".equals(t.getClass().getSimpleName())){
			t.setPage(page);
			return page.setList(basMissionDao.findList(t));
		}
		return super.findPage(page, t);
	}    
	
	@Transactional(readOnly = false)
	public void save(T t) {
		super.save(t);
	}
	@Transactional(readOnly = false) 
	public void update(T t) {
		t.preUpdate();
		basMissionDao.update(t);
	}
	
	@Transactional(readOnly = false)
	public void delete(T t) {
		super.delete(t);
	}
	
}