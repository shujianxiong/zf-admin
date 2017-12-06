/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.wp;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPrepayRecord;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatPrepayRecordService;

/**
 * 微信预支付记录Controller
 * @author 张金俊
 * @version 2017-05-26
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/wp/wechatPrepayRecord")
public class WechatPrepayRecordController extends BaseController {

	@Autowired
	private WechatPrepayRecordService wechatPrepayRecordService;
	
	@ModelAttribute
	public WechatPrepayRecord get(@RequestParam(required=false) String id) {
		WechatPrepayRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wechatPrepayRecordService.get(id);
		}
		if (entity == null){
			entity = new WechatPrepayRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:wp:wechatPrepayRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(WechatPrepayRecord wechatPrepayRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WechatPrepayRecord> page = wechatPrepayRecordService.findPage(new Page<WechatPrepayRecord>(request, response), wechatPrepayRecord); 
		model.addAttribute("page", page);
		return "modules/bus/wp/wechatPrepayRecordList";
	}

	@RequiresPermissions("bus:wp:wechatPrepayRecord:view")
	@RequestMapping(value = "form")
	public String form(WechatPrepayRecord wechatPrepayRecord, Model model) {
		model.addAttribute("wechatPrepayRecord", wechatPrepayRecord);
		return "modules/bus/wp/wechatPrepayRecordForm";
	}

	@RequiresPermissions("bus:wp:wechatPrepayRecord:edit")
	@RequestMapping(value = "save")
	public String save(WechatPrepayRecord wechatPrepayRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wechatPrepayRecord)){
			return form(wechatPrepayRecord, model);
		}
		wechatPrepayRecordService.save(wechatPrepayRecord);
		addMessage(redirectAttributes, "保存微信预支付记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatPrepayRecord/?repage";
	}
	
	@RequiresPermissions("bus:wp:wechatPrepayRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(WechatPrepayRecord wechatPrepayRecord, RedirectAttributes redirectAttributes) {
		wechatPrepayRecordService.delete(wechatPrepayRecord);
		addMessage(redirectAttributes, "删除微信预支付记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatPrepayRecord/?repage";
	}

    @RequiresPermissions("bus:wp:wechatPrepayRecord:view")
    @RequestMapping(value = "info")
    public String info(WechatPrepayRecord wechatPrepayRecord, Model model) {
        model.addAttribute("wechatPrepayRecord", wechatPrepayRecord);
        return "modules/bus/wp/wechatPrepayRecordInfo";
    }
}