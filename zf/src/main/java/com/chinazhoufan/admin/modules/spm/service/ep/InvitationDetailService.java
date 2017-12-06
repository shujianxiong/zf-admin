/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ep;

import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ep.InvitationDetail;
import com.chinazhoufan.admin.modules.spm.dao.ep.InvitationDetailDao;

/**
 * 邀请人记录Service
 * @author 舒剑雄
 * @version 2017-09-04
 */
@Service
@Transactional(readOnly = true)
public class InvitationDetailService extends CrudService<InvitationDetailDao, InvitationDetail> {

	public InvitationDetail get(String id) {
		return super.get(id);
	}
	
	public List<InvitationDetail> findList(InvitationDetail invitationDetail) {
		return super.findList(invitationDetail);
	}
	
	public Page<InvitationDetail> findPage(Page<InvitationDetail> page, InvitationDetail invitationDetail) {
		return super.findPage(page, invitationDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(InvitationDetail invitationDetail) {
		super.save(invitationDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(InvitationDetail invitationDetail) {
		super.delete(invitationDetail);
	}

	public int countByMember(String memberId, String orderFlag){
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("orderFlag", orderFlag);
		return dao.countByMember(map);
	}


	/**
	 * 查询邀请会员IDList
	 * @param memberId
	 * @return
	 */
	public List<String> getInviteMemberIds(String memberId){
		return dao.getInviteMemberIds(memberId);
	}
	
}