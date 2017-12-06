/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.bs;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Designer;
import com.chinazhoufan.admin.modules.lgt.dao.bs.DesignerDao;

/**
 * 设计师Service
 * @author 张金俊
 * @version 2016-08-17
 */
@Service
@Transactional(readOnly = true)
public class DesignerService extends CrudService<DesignerDao, Designer> {

	public Designer get(String id) {
		return super.get(id);
	}
	
	public List<Designer> findList(Designer designer) {
		return super.findList(designer);
	}
	
	public Page<Designer> findPage(Page<Designer> page, Designer designer) {
		return super.findPage(page, designer);
	}
	
	@Transactional(readOnly = false)
	public void save(Designer designer) {
		super.save(designer);
	}
	
	@Transactional(readOnly = false)
	public void delete(Designer designer) {
		super.delete(designer);
	}
	
}