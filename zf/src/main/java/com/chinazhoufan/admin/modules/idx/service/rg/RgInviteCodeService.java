/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.rg;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.ShareCodeUtil;
import com.chinazhoufan.admin.modules.idx.entity.rg.RgInviteCode;
import com.chinazhoufan.admin.modules.idx.dao.rg.RgInviteCodeDao;

/**
 * 注册邀请码Service
 * @author liut
 * @version 2016-11-17
 */
@Service
@Transactional(readOnly = true)
public class RgInviteCodeService extends CrudService<RgInviteCodeDao, RgInviteCode> {

	public RgInviteCode get(String id) {
		return super.get(id);
	}
	
	public List<RgInviteCode> findList(RgInviteCode rgInviteCode) {
		return super.findList(rgInviteCode);
	}
	
	public Page<RgInviteCode> findPage(Page<RgInviteCode> page, RgInviteCode rgInviteCode) {
		return super.findPage(page, rgInviteCode);
	}
	
	@Transactional(readOnly = false)
	public void save(RgInviteCode rgInviteCode) {
		super.save(rgInviteCode);
	}
	
	@Transactional(readOnly = false)
	public void delete(RgInviteCode rgInviteCode) {
		super.delete(rgInviteCode);
	}
	
	@Transactional(readOnly = false)
	public void generateRgInviteCode(Integer num, String remarks) {
		RgInviteCode c = null;
		for(int i = 0; i < num; i++) {
			c = new RgInviteCode();
			c.setInviteCode(ShareCodeUtil.generateSerialCode(ShareCodeUtil.INVITE_CODE_LENGTH, ShareCodeUtil.INVITE_CODE_DATA_TYPE));
			c.setUseFlag(RgInviteCode.FALSE_FLAG);
			c.setRemarks(remarks);
			c.preInsert();
			dao.insert(c);
		}
	}
	
	
}