/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.PropvalueDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;

/**
 * 属性值Service
 * @author 杨晓辉
 * @version 2015-10-14
 */
@Service
@Transactional(readOnly = true)
public class PropvalueService extends CrudService<PropvalueDao, Propvalue> {
	
	public Propvalue get(String id) {
		return super.get(id);
	}
	
	public List<Propvalue> findList(Propvalue lgtPsPropvalue) {
		return super.findList(lgtPsPropvalue);
	}
	
	public Page<Propvalue> findPage(Page<Propvalue> page, Propvalue lgtPsPropvalue) {
		return super.findPage(page, lgtPsPropvalue);
	}
	
	
	@Transactional(readOnly = false)
	public void save(Propvalue lgtPsPropvalue) {
		super.save(lgtPsPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void delete(Propvalue lgtPsPropvalue) {
		super.delete(lgtPsPropvalue);
	}
	
}