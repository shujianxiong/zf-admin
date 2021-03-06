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
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayRecord;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatPayRecordService;

/**
 * 微信支付记录Controller
 * @author 张金俊
 * @version 2017-05-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/wp/wechatPayRecord")
public class WechatPayRecordController extends BaseController {

	@Autowired
	private WechatPayRecordService wechatPayRecordService;
	
	@ModelAttribute
	public WechatPayRecord get(@RequestParam(required=false) String id) {
		WechatPayRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wechatPayRecordService.get(id);
		}
		if (entity == null){
			entity = new WechatPayRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:wp:wechatPayRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(WechatPayRecord wechatPayRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WechatPayRecord> page = wechatPayRecordService.findPage(new Page<WechatPayRecord>(request, response), wechatPayRecord); 
		model.addAttribute("page", page);
		return "modules/bus/wp/wechatPayRecordList";
	}

	@RequiresPermissions("bus:wp:wechatPayRecord:view")
	@RequestMapping(value = "form")
	public String form(WechatPayRecord wechatPayRecord, Model model) {
		model.addAttribute("wechatPayRecord", wechatPayRecord);
		return "modules/bus/wp/wechatPayRecordForm";
	}

	@RequiresPermissions("bus:wp:wechatPayRecord:edit")
	@RequestMapping(value = "save")
	public String save(WechatPayRecord wechatPayRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wechatPayRecord)){
			return form(wechatPayRecord, model);
		}
		wechatPayRecordService.save(wechatPayRecord);
		addMessage(redirectAttributes, "保存微信支付记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatPayRecord/?repage";
	}
	
	@RequiresPermissions("bus:wp:wechatPayRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(WechatPayRecord wechatPayRecord, RedirectAttributes redirectAttributes) {
		wechatPayRecordService.delete(wechatPayRecord);
		addMessage(redirectAttributes, "删除微信支付记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatPayRecord/?repage";
	}

    @RequiresPermissions("bus:wp:wechatPayRecord:view")
    @RequestMapping(value = "info")
    public String info(WechatPayRecord wechatPayRecord, Model model) {
        model.addAttribute("wechatPayRecord", wechatPayRecord);
        return "modules/bus/wp/wechatPayRecordInfo";
    }
}