/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web.ap;

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
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveRecord;
import com.chinazhoufan.admin.modules.bas.service.ap.ApproveRecordService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 审批记录Controller
 * @author 贾斌
 * @version 2016-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/ap/approveRecord")
public class ApproveRecordController extends BaseController {

	@Autowired
	private ApproveRecordService approveRecordService;
	
	@ModelAttribute
	public ApproveRecord get(@RequestParam(required=false) String id) {
		ApproveRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = approveRecordService.get(id);
		}
		if (entity == null){
			entity = new ApproveRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:ap:approveRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ApproveRecord approveRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ApproveRecord> page = approveRecordService.findAllPage(new Page<ApproveRecord>(request, response), approveRecord); 
		model.addAttribute("page", page);
		return "modules/bas/ap/approveRecordList";
	}

	@RequiresPermissions("bas:ap:approveRecord:view")
	@RequestMapping(value = "myList")
	public String myList(ApproveRecord approveRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		approveRecord.setApproveUser(UserUtils.getUser());
		Page<ApproveRecord> page = approveRecordService.findPage(new Page<ApproveRecord>(request, response), approveRecord); 
		model.addAttribute("page", page);
		return "modules/bas/ap/myApproveRecordList";
	}
	
	@RequiresPermissions("bas:ap:approveRecord:view")
	@RequestMapping(value = "form")
	public String form(ApproveRecord approveRecord, Model model) {
		model.addAttribute("approveRecord", approveRecord);
		return "modules/bas/ap/approveRecordForm";
	}

	@RequiresPermissions("bas:ap:approveRecord:edit")
	@RequestMapping(value = "save")
	public String save(ApproveRecord approveRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, approveRecord)){
			return form(approveRecord, model);
		}
		approveRecordService.save(approveRecord);
		addMessage(redirectAttributes, "保存审批记录成功");
		return "redirect:"+Global.getAdminPath()+"/bas/ap/approveRecord/?repage";
	}
	
	@RequiresPermissions("bas:ap:approveRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(ApproveRecord approveRecord, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(approveRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到审批记录信息！");
			return "error/400";
		}
		approveRecordService.delete(approveRecord);
		addMessage(redirectAttributes, "删除审批记录成功");
		return "redirect:"+Global.getAdminPath()+"/bas/ap/approveRecord/myList?repage";
	}

}