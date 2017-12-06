/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.gd;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.dao.gd.CollocationDao;

/**
 * 搭配Service
 * @author liut
 * @version 2017-03-15
 */
@Service
@Transactional(readOnly = true)
public class CollocationService extends CrudService<CollocationDao, Collocation> {

	@Autowired
	private CollocationGroupService collocationGroupService;
	
	public Collocation get(String id) {
		return super.get(id);
	}
	
	public List<Collocation> findList(Collocation collocation) {
		return super.findList(collocation);
	}
	
	public Page<Collocation> findPage(Page<Collocation> page, Collocation collocation) {
		return super.findPage(page, collocation);
	}
	
	@Transactional(readOnly = false)
	public void save(Collocation collocation) {
		super.save(collocation);
	}
	
	@Transactional(readOnly = false)
	public void delete(Collocation collocation) {
		//先删除搭配分组及关联商品信息
		collocationGroupService.deleteGroupByCollocation(collocation.getId());
		super.delete(collocation);
	}
	
	/**
	 * 根据ID获取完整的搭配信息，包括搭配小分组及其对应的相关商品信息
	 * @param collocation
	 * @return    设定文件
	 * @throws
	 */
	public Collocation getCollocationWithDetail(Collocation collocation) {
		return dao.getCollocationWithDetail(collocation);
	}
	
	
	
	
}