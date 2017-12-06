/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ac;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.spm.dao.ac.ActivityResearchDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearch;
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearchRc;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;
import com.chinazhoufan.admin.modules.spm.service.ic.InviteCodeService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

/**
 * 调研活动表Service
 * @author liut
 * @version 2016-05-25
 */
@Service
@Transactional(readOnly = true)
public class ActivityResearchService extends CrudService<ActivityResearchDao, ActivityResearch> {

	@Autowired
	private AcActivityService acActivityService;
	@Autowired
	private QuestionnaireService questionnaireService;
	@Autowired
	private InviteCodeService inviteCodeService;
	@Autowired
	private ActivityResearchRcService activityResearchRcService;
	
	/**
	 * 查询出调研活动、活动、奖品、活动模板、调研问卷
	 * @param id	调研活动ID
	 */
	public ActivityResearch get(String id) {
		return super.get(id);
	}
	
	public List<ActivityResearch> findList(ActivityResearch activityResearch) {
		return super.findList(activityResearch);
	}
	
	public Page<ActivityResearch> findPage(Page<ActivityResearch> page, ActivityResearch activityResearch) {
		return super.findPage(page, activityResearch);
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityResearch activityResearch) {
		//第一步，保存活动基本信息
		acActivityService.save(activityResearch.getActivity());
		
		//第二步保存活动，问卷关联表
		super.save(activityResearch);
		
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityResearch activityResearch) {
		acActivityService.delete(activityResearch.getActivity());
		super.delete(activityResearch);
	}
	
	/**
	 * 前端查询获取活动内容及问卷内容
	 * @param activityResearch
	 * @return
	 */
	public ActivityResearch getForIndex(ActivityResearch activityResearch) {
		
		List<ActivityResearch> list = dao.getByActivity(activityResearch);
		if(list != null &&!list.isEmpty()){
			activityResearch = list.get(0);
			activityResearch.setActivity(acActivityService.get(activityResearch.getActivity().getId()));
			activityResearch.setQuestionnaire(questionnaireService.getInfoById(activityResearch.getQuestionnaire().getId()));
		}
		return activityResearch;
	}
	
	/**
	 * 使用邀请码参与活动，更新活动邀请码数据（邀请码使用记录）、创建调研活动参与记录，检测活动参与数量
	 * @param member		会员
	 * @param inviteCode	邀请码
	 * @param arId			调研活动ID
	 * @param arInvolveLimitHandle	允许参与活动的数量参数句柄
	 */
	@Transactional(readOnly = false)
	public void involveActivityResearch(Member member, String inviteCode, String arId, String arInvolveLimitHandle){
		// 更新活动邀请码数据
		InviteCode inviteCodeObj = inviteCodeService.getByInviteCode(inviteCode); 
		inviteCodeObj.setUseFlag(InviteCode.USEFLAG_YES);
		inviteCodeObj.setUseMember(member);
		inviteCodeObj.setUseTime(new Date());
		inviteCodeService.save(inviteCodeObj);			
		
		// 创建调研活动参与记录
		ActivityResearchRc activityResearchRc = new ActivityResearchRc();
		activityResearchRc.setMember(member);
		activityResearchRc.setActivityResearch(new ActivityResearch(arId));
		activityResearchRc.setStatus(ActivityResearchRc.STATUS_INVOLVING);	// 参与中
		activityResearchRcService.save(activityResearchRc);
		
		// 查询调研活动参与记录数量，当活动参与记录状态为已完成达到设定条数（1000条）时，则活动关闭
		Integer arRcCount = activityResearchRcService.getCountByArIdAndStatus(arId, ActivityResearchRc.STATUS_FINISH);	// 调研活动参与记录（已完成状态）数量
		Integer arInvolveLimitNum = new Integer(ConfigUtils.getConfig(arInvolveLimitHandle).getConfigValue());	// 系统设置参与上限（系统业务参数设置功能中）
		if(arRcCount >= arInvolveLimitNum){
			// 关闭活动
			ActivityResearch activityResearch = this.get(arId);
			AcActivity acActivity = acActivityService.get(activityResearch.getActivity().getId());
			acActivity.setActiveFlag(AcActivity.FALSE_FLAG);
			acActivityService.save(acActivity);
		}
	}
	
}