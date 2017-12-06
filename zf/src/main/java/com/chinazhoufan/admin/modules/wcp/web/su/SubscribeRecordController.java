/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.su;

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
import com.chinazhoufan.admin.modules.wcp.entity.su.SubscribeRecord;
import com.chinazhoufan.admin.modules.wcp.service.su.SubscribeRecordService;

/**
 * 公众号订阅记录Controller
 * @author 张金俊
 * @version 2016-05-24
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/wc/subscribeRecord")
public class SubscribeRecordController extends BaseController {

	@Autowired
	private SubscribeRecordService subscribeRecordService;
	
	@ModelAttribute
	public SubscribeRecord get(@RequestParam(required=false) String id) {
		SubscribeRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = subscribeRecordService.get(id);
		}
		if (entity == null){
			entity = new SubscribeRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:wc:subscribeRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(SubscribeRecord subscribeRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SubscribeRecord> page = subscribeRecordService.findPage(new Page<SubscribeRecord>(request, response), subscribeRecord); 
		model.addAttribute("page", page);
		return "modules/spm/wc/subscribeRecordList";
	}

	@RequiresPermissions("spm:wc:subscribeRecord:view")
	@RequestMapping(value = "form")
	public String form(SubscribeRecord subscribeRecord, Model model) {
		model.addAttribute("subscribeRecord", subscribeRecord);
		return "modules/spm/wc/subscribeRecordForm";
	}

	@RequiresPermissions("spm:wc:subscribeRecord:edit")
	@RequestMapping(value = "save")
	public String save(SubscribeRecord subscribeRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, subscribeRecord)){
			return form(subscribeRecord, model);
		}
		subscribeRecordService.save(subscribeRecord);
		addMessage(redirectAttributes, "保存公众号订阅记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/wc/subscribeRecord/?repage";
	}
	
	@RequiresPermissions("spm:wc:subscribeRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(SubscribeRecord subscribeRecord, RedirectAttributes redirectAttributes) {
		subscribeRecordService.delete(subscribeRecord);
		addMessage(redirectAttributes, "删除公众号订阅记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/wc/subscribeRecord/?repage";
	}

}