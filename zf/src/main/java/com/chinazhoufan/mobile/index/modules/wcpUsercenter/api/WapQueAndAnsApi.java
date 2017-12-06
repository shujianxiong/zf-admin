/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.wcpUsercenter.api;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.mi.PointDetailService;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearch;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.entity.qa.RespondentsAns;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityService;
import com.chinazhoufan.admin.modules.spm.service.ac.ActivityResearchRcService;
import com.chinazhoufan.admin.modules.spm.service.ac.ActivityResearchService;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeRecordService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireService;
import com.chinazhoufan.admin.modules.spm.service.qa.RespondentsAnsService;
import com.chinazhoufan.admin.modules.spm.service.qa.RespondentsService;
import com.chinazhoufan.mobile.index.modules.activity.vo.QueAndAnsVO;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 调研问卷及答卷Api
 * @author 刘晓东
 * @version 2016-06-06
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapQueAndAnsApi extends BaseController {
	
	@Autowired
	MemberService wapMemberService;
	@Autowired
	QuestionnaireService questionnaireService;
	@Autowired
	RespondentsService respondentsService;
	@Autowired
	private ActivityResearchService activityResearchService;
	@Autowired
	private RespondentsAnsService respondentsAnsService;
	@Autowired
	private ActivityResearchRcService activityResearchRcService;
	@Autowired
	private PrizeRecordService prizeRecordService;
	@Autowired
	private AcActivityService acActivityService;
	@Autowired
	private PointDetailService pointDetailService;
	
	/**
	 * 查询问卷及会员答卷记录
	 * @param questionnaireId 问卷ID
	 * @return
	 */
	@SuppressWarnings("null")
	@RequestMapping(value = "/queAndAns",method=RequestMethod.POST)
	public @ResponseBody
	String queAndAns(@RequestParam(value="activityId",required=true)String activityId,HttpServletRequest request){
		Echos echos = null;
		try {
			ActivityResearch activityResearch = activityResearchService.getForIndex(new ActivityResearch(activityId));
			String questionnaireId = activityResearch.getQuestionnaire().getId();
			Questionnaire questionnaire = questionnaireService.getInfoById(questionnaireId); //查询问卷信息
			MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
			// 查询是否有答卷记录
			Respondents respondents = respondentsService.getByQuestionnaireAndMember(questionnaireId, memberDTO.getId());
			//无答卷信息则直接返回问卷信息
			if (respondents == null && StringUtils.isBlank(respondents.getId())) {
				echos = new Echos(Constants.SUCCESS, new QueAndAnsVO(questionnaire));
			}else {
				echos = new Echos(Constants.SUCCESS, new QueAndAnsVO(questionnaire,respondentsService.get(respondents.getId())));
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 答题
	 * @param respondentsAns
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/respondentsAns",method=RequestMethod.POST)
	public @ResponseBody
	String respondentsAns(RespondentsAns respondentsAns, HttpServletRequest request) {
		Echos echos = null;
		try {
			respondentsAnsService.respondentsAns(respondentsAns); //如果已有对应答题记录则删除
//			if (StringUtils.isNotBlank(respondentsAns.getAnswerText()) || StringUtils.isNotBlank(respondentsAns.getBaseAnswer().getId())) {
//				respondentsAnsService.save(respondentsAns); //保存答题记录
//			}
			echos = new Echos(Constants.SUCCESS, respondentsAns);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 提交答卷
	 * @param respondents
	 * @param activityId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/answerSubmit", method=RequestMethod.POST)
	public @ResponseBody
	String answerSubmit(Respondents respondents, @RequestParam(value="activityId",required=true)String activityId,HttpServletRequest request){

		Echos echos = null;
		Respondents respondentsOld = respondentsService.get(respondents.getId()); //获取到对应答题记录
		long queNum = questionnaireService.getQueNum(respondentsOld.getQuestionnaire().getId()); //题目总数
		//判断是否已答完
		if(respondentsAnsService.getCountByRespondents(respondents) == queNum){
			MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
			//更新答卷记录
			respondentsOld.setEndTime(new Date()); //答题结束时间
			respondentsOld.setPoint((int)questionnaireService.getQuePoint(respondentsOld.getQuestionnaire().getId())); //分数
			respondentsService.save(respondentsOld);
			//更新活动参与记录
			activityResearchRcService.finish(activityId,memberDTO.getId());
			//判断是否有积分奖励,有则生成默认积分奖励记录
			AcActivity acActivity = acActivityService.get(activityId);
			
			if (acActivity.getRewardPoint() != null) {
				Member member = wapMemberService.get(memberDTO.getId());
				member.setPoint(member.getPoint()+acActivityService.get(activityId).getRewardPoint());
				wapMemberService.save(member);
				pointDetailService.addPoint(acActivityService.get(activityId).getRewardPoint(), memberDTO.getId(), PointDetail.CRT_A_ACTIVITY, PointDetail.OPERATER_TYPE_SYS);
				echos = new Echos(Constants.SUCCESS,String.valueOf(acActivity.getRewardPoint()),true);
			}else {
				echos = new Echos(Constants.SUCCESS, true);
			}
		}else {
			echos = new Echos(Constants.SUCCESS, false);
		}
		return JsonMapper.toJsonString(echos);
	}
}