/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ep;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ep.Invitation;
import com.chinazhoufan.admin.modules.spm.dao.ep.InvitationDao;

/**
 * 邀请人Service
 * @author 舒剑雄
 * @version 2017-08-31
 */
@Service
@Transactional(readOnly = true)
public class InvitationService extends CrudService<InvitationDao, Invitation> {

	@Autowired
	private ExperiencePackService experiencePackService;

	public Invitation get(String id) {
		return super.get(id);
	}
	
	public List<Invitation> findList(Invitation invitation) {
		return super.findList(invitation);
	}
	
	public Page<Invitation> findPage(Page<Invitation> page, Invitation invitation) {
		return super.findPage(page, invitation);
	}
	
	@Transactional(readOnly = false)
	public void save(Invitation invitation) {
		super.save(invitation);
	}
	
	@Transactional(readOnly = false)
	public void delete(Invitation invitation) {
		super.delete(invitation);
	}

	@Transactional(readOnly = false)
	public Invitation getByMember(String memberId) {
		return dao.getByMember(memberId);
	}
	/**
	 * 微信接口，分享公众号，更新邀请人数
	 */
	public void updateByWxShare(String memberId) {
		if(memberId == null ){
			throw new ServiceException("没有获取到用户信息");
		}
		Invitation invitation = dao.getByMember(memberId);
		if(invitation == null){
			throw new ServiceException("用户并无邀请人，请核查！");
		}
		invitation.setUpdateDate(new Date());
		invitation.setUpdateBy(UserUtils.getUser());
		//invitation.setHistoryInviteder(invitation.getHistoryInviteder() == null?1:invitation.getHistoryInviteder()+1);
		dao.update(invitation);
	}
	
}