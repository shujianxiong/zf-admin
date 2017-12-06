/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.cl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.cl.CollocationCollect;
import com.chinazhoufan.admin.modules.crm.dao.cl.CollocationCollectDao;

/**
 * 会员搭配收藏Service
 * @author 张金俊
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class CollocationCollectService extends CrudService<CollocationCollectDao, CollocationCollect> {

	public CollocationCollect get(String id) {
		return super.get(id);
	}
	
	public List<CollocationCollect> findList(CollocationCollect collocationCollect) {
		return super.findList(collocationCollect);
	}
	
	public Page<CollocationCollect> findPage(Page<CollocationCollect> page, CollocationCollect collocationCollect) {
		return super.findPage(page, collocationCollect);
	}
	
	@Transactional(readOnly = false)
	public void save(CollocationCollect collocationCollect) {
		super.save(collocationCollect);
	}
	
	@Transactional(readOnly = false)
	public void delete(CollocationCollect collocationCollect) {
		super.delete(collocationCollect);
	}
	
}