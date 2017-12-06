/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.zi;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.spm.entity.zi.Zmxy;
import com.chinazhoufan.admin.modules.spm.dao.zi.ZmxyDao;

/**
 * 芝麻信用配置Service
 * @author liuxiaodong
 * @version 2017-09-23
 */
@Service
@Transactional(readOnly = true)
public class ZmxyService extends CrudService<ZmxyDao, Zmxy> {

	public Zmxy get(String id) {
		return super.get(id);
	}
	
	public List<Zmxy> findList(Zmxy zmxy) {
		return super.findList(zmxy);
	}
	
	public Page<Zmxy> findPage(Page<Zmxy> page, Zmxy zmxy) {
		return super.findPage(page, zmxy);
	}
	
	@Transactional(readOnly = false)
	public void save(Zmxy zmxy) {
		if (zmxy.getScoreMax() < zmxy.getScoreMin()) {
			throw new ServiceException("分值上线不得低于分值下线");
		}
		super.save(zmxy);
	}
	
	@Transactional(readOnly = false)
	public void delete(Zmxy zmxy) {
		super.delete(zmxy);
	}
	
}