/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ic;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.ShareCodeUtil;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.dao.ac.AcActivityDao;
import com.chinazhoufan.admin.modules.spm.dao.ic.InviteCodeDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;

/**
 * 会员邀请码表Service
 * @author 刘晓东
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class InviteCodeService extends CrudService<InviteCodeDao, InviteCode> {

	@Autowired
	AcActivityDao acActivityDao;
	
	public InviteCode get(String id) {
		return super.get(id);
	}
	
	/**
	 * 根据邀请码查询具体对象
	 * @param inviteCode
	 * @return
	 */
	public InviteCode getByInviteCode(String inviteCode) {
		return dao.getByInviteCode(inviteCode);
	}
	
	/**
	 * 根据创建人ID和活动ID，查询该创建人为该活动已创建的邀请码数量
	 * @param createrId		创建人ID
	 * @param activityId	活动ID
	 * @return
	 */
	public Integer getCountByCreaterAndActivity(String createrId, String activityId){
		return dao.getCountByCreaterAndActivity(createrId, activityId);
	}
	
	public List<InviteCode> findList(InviteCode inviteCode) {
		return super.findList(inviteCode);
	}
	
	public Page<InviteCode> findPage(Page<InviteCode> page, InviteCode inviteCode) {
		return super.findPage(page, inviteCode);
	}
	
	@Transactional(readOnly = false)
	public void save(InviteCode inviteCode) {
		super.save(inviteCode);
	}
	
	@Transactional(readOnly = false)
	public void delete(InviteCode inviteCode) {
		super.delete(inviteCode);
	}
	
	/**
	 * 判断邀请码是否有效
	 * @param inviteCode
	 * @return
	 */
	public Boolean isValid(String inviteCode) {
		InviteCode inviteCodeObj = dao.getByInviteCode(inviteCode);
		if(inviteCodeObj != null && StringUtils.isNotBlank(inviteCodeObj.getId())){
			AcActivity activity = acActivityDao.get(inviteCodeObj.getActivity().getId());
			if(AcActivity.TRUE_FLAG.equals(activity.getActiveFlag())){
				if(DateUtils.compare_date(new Date(), activity.getStartTime())==1 && DateUtils.compare_date(new Date(), activity.getEndTime())<0){
					return true;
				}
			}
		}
		return false;
	}
	
	/**
	 * 查询会员邀请码
	 * @param inviteCode
	 * @return
	 */
	public List<InviteCode> findMemberInviteCodeList(InviteCode inviteCode){
		return dao.findMemberInviteCodeList(inviteCode);
	}

	/**
	 * 
	 * @param activityId 活动ID
	 * @param memberId 会员ID
	 * @return
	 */
	public InviteCode getByActivityAndMember(String activityId, String memberId) {
		return dao.getByActivityAndMember(activityId, memberId);
	}

	/**
	 * 会员生成邀请码
	 * @param activityId
	 * @param createId
	 * @param createNum
	 */
	@Transactional(readOnly=false)
	public void createInviteCode(String activityId, String createrId, Integer createNum) {
		for(int i=0;i<createNum;i++){
			InviteCode inviteCode = new InviteCode();
			inviteCode.setCreaterType(InviteCode.CREATERTYPE_MEMBER);
			inviteCode.setCreaterId(createrId);
			inviteCode.setInviteCode(ShareCodeUtil.generateSerialCode(ShareCodeUtil.INVITE_CODE_LENGTH, ShareCodeUtil.INVITE_CODE_DATA_TYPE));
			inviteCode.setActivity(new AcActivity(activityId));
			inviteCode.setUseFlag(InviteCode.USEFLAG_NO);
			save(inviteCode);
		}
	}
	
}