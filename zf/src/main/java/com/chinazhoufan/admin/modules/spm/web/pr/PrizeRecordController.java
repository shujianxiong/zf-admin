/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;
import com.chinazhoufan.admin.modules.spm.entity.pr.PrizeRecord;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeRecordService;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeService;

/**
 * 奖品领取记录表Controller
 * @author liut
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pr/prizeRecord")
public class PrizeRecordController extends BaseController {

	@Autowired
	private PrizeRecordService prizeRecordService;
	@Autowired
	private PrizeService prizeService;
	
	@ModelAttribute
	public PrizeRecord get(@RequestParam(required=false) String id) {
		PrizeRecord entity = null;
		if (StringUtils.isNotBlank(id)){
//			entity = prizeRecordService.get(id);
		}
		if (entity == null){
			entity = new PrizeRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pr:prizeRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(PrizeRecord prizeRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PrizeRecord> page = prizeRecordService.findPage(new Page<PrizeRecord>(request, response), prizeRecord); 
		model.addAttribute("page", page);
		return "modules/spm/pr/prizeRecordList";
	}

	@RequiresPermissions("spm:pr:prizeRecord:view")
	@RequestMapping(value = "form")
	public String form(PrizeRecord prizeRecord, Model model) {
		if(StringUtils.isBlank(prizeRecord.getId())) {
			prizeRecord.setReceiveStatus(PrizeRecord.RECEIVE_WAIT);
			model.addAttribute("prizeRecord", prizeRecord);
		} else {
			PrizeRecord pr = prizeRecordService.get(prizeRecord);
			model.addAttribute("prizeRecord", pr);
		}
		return "modules/spm/pr/prizeRecordForm";
	}

	@RequiresPermissions("spm:pr:prizeRecord:edit")
	@RequestMapping(value = "save")
	public String save(PrizeRecord prizeRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, prizeRecord)){
			return form(prizeRecord, model);
		}
		prizeRecordService.save(prizeRecord);
		addMessage(redirectAttributes, "保存奖品领取记录表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pr/prizeRecord/?repage";
	}
	
	@RequiresPermissions("spm:pr:prizeRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(PrizeRecord prizeRecord, RedirectAttributes redirectAttributes) {
		if(prizeRecord == null || StringUtils.isBlank(prizeRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要查看的奖品信息！");
			return "error/400";
		}
		
		prizeRecordService.delete(prizeRecord);
		addMessage(redirectAttributes, "删除奖品领取记录表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pr/prizeRecord/?repage";
	}

	@RequiresPermissions("spm:pr:prizeRecord:view")
	@RequestMapping(value = "info")
	public String info(PrizeRecord prizeRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(prizeRecord == null || StringUtils.isBlank(prizeRecord.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的奖品信息！");
			return "error/400";
		}
		
		PrizeRecord pr = prizeRecordService.get(prizeRecord);
		model.addAttribute("prizeRecord", pr);
		return "modules/spm/pr/prizeRecordInfo";
	}
	
	@RequiresPermissions("spm:pr:prizeRecord:edit")
	@RequestMapping(value = "changeFlag")
	public String changeFlag(PrizeRecord prizeRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(prizeRecord == null || StringUtils.isBlank(prizeRecord.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的奖品信息！");
			return "error/400";
		}
		
		//奖品领取状态 由待领取-> 已领取
		PrizeRecord pr = prizeRecordService.get(prizeRecord);
		pr.setReceiveStatus(PrizeRecord.RECEIVE_PASS);
		Prize prize = prizeService.get(pr.getPrize().getId());
		prize.setUsableNum(""+(Integer.valueOf(prize.getUsableNum()).intValue()-1));
		prizeService.save(prize);
		prizeRecordService.changeFlag(pr);
		return list(prizeRecord, request, response, model);
	}
}