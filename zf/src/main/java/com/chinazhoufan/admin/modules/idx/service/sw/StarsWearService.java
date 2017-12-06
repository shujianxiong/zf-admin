/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.sw;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.sw.StarsWear;
import com.chinazhoufan.admin.modules.idx.dao.sw.StarsWearDao;

/**
 * 明星穿搭Service
 * @author 张金俊
 * @version 2017-07-31
 */
@Service
@Transactional(readOnly = true)
public class StarsWearService extends CrudService<StarsWearDao, StarsWear> {

	public StarsWear get(String id) {
		return super.get(id);
	}
	
	public List<StarsWear> findList(StarsWear starsWear) {
		return super.findList(starsWear);
	}
	
	public Page<StarsWear> findPage(Page<StarsWear> page, StarsWear starsWear) {
		return super.findPage(page, starsWear);
	}
	
	@Transactional(readOnly = false)
	public void save(StarsWear starsWear) {
		super.save(starsWear);
	}
	
	@Transactional(readOnly = false)
	public void delete(StarsWear starsWear) {
		super.delete(starsWear);
	}
	
}