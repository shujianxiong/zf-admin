/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.wcpUsercenter.web.prize;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;
import com.chinazhoufan.admin.modules.spm.entity.pr.PrizeRecord;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityService;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeRecordService;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 兑换奖品表Controller
 * @author 刘晓东
 * @version 2016-06-07
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapPrizeController extends BaseController {

	@Autowired
	private AcActivityService acActivityService;
	@Autowired
	private PrizeService prizeService;
	@Autowired
	private PrizeRecordService prizeRecordService;
	
	/**
	 * 跳转到兑换页面
	 * @param model
	 * @param request
	 * @param activityId
	 * @return
	 */
	@RequestMapping(value = "/getPrize")
	public String getPrize(Model model,HttpServletRequest request,String activityId){
		Prize prize = acActivityService.getPrizeByActivityId(activityId);
		prize = prizeService.get(prize.getId());
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		prizeRecordService.save(memberDTO.getId(),prize.getId(),PrizeRecord.REASONTYPE_ACTIVITY);
		model.addAttribute("prize", prize);
		return "mobile/wechat/wcpUsercenter/prize/getPrize";
	}
	
	/**
	 * 兑换奖品
	 * @return
	 */
	@RequestMapping(value = "/exchange", method = RequestMethod.POST)
	public String exchange(@RequestParam(value = "prizeId",required = true)String prizeId ,HttpServletRequest request){
		Echos echos = null;
		try {
			MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
			PrizeRecord prizeRecord = prizeRecordService.getByPrizeAndMember(prizeId, memberDTO.getId());
			if (PrizeRecord.RECEIVE_PASS.equals(prizeRecord.getReceiveStatus())) {
				echos=new Echos(Constants.SUCCESS,"您已兑换该奖品");
				return "邀请页";
			}else {
				prizeRecord.setReceiveStatus(PrizeRecord.RECEIVE_PASS);
				prizeRecord.setReceiveTime(new Date());
				prizeRecordService.save(prizeRecord);
				echos = new Echos(Constants.SUCCESS);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
}