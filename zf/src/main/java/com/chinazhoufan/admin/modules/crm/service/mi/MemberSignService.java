/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mi;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mi.MemberSign;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberSignDao;

/**
 * 会员签到Service
 * @author liut
 * @version 2016-11-25
 */
@Service
@Transactional(readOnly = true)
public class MemberSignService extends CrudService<MemberSignDao, MemberSign> {

	public MemberSign get(String id) {
		return super.get(id);
	}
	
	public List<MemberSign> findList(MemberSign memberSign) {
		return super.findList(memberSign);
	}
	
	public Page<MemberSign> findPage(Page<MemberSign> page, MemberSign memberSign) {
		return super.findPage(page, memberSign);
	}
	
	@Transactional(readOnly = false)
	public void save(MemberSign memberSign) {
		super.save(memberSign);
	}
	
	@Transactional(readOnly = false)
	public void delete(MemberSign memberSign) {
		super.delete(memberSign);
	}
	
}