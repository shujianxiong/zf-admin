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
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatRefundRecord;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatRefundRecordService;

/**
 * 微信退款记录Controller
 * @author 舒剑雄
 * @version 2017-09-06
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/wp/wechatRefundRecord")
public class WechatRefundRecordController extends BaseController {

	@Autowired
	private WechatRefundRecordService wechatRefundRecordService;
	
	@ModelAttribute
	public WechatRefundRecord get(@RequestParam(required=false) String id) {
		WechatRefundRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wechatRefundRecordService.get(id);
		}
		if (entity == null){
			entity = new WechatRefundRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:wp:wechatRefundRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(WechatRefundRecord wechatRefundRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WechatRefundRecord> page = wechatRefundRecordService.findPage(new Page<WechatRefundRecord>(request, response), wechatRefundRecord); 
		model.addAttribute("page", page);
		return "modules/bus/wp/wechatRefundRecordList";
	}

	@RequiresPermissions("bus:wp:wechatRefundRecord:view")
	@RequestMapping(value = "form")
	public String form(WechatRefundRecord wechatRefundRecord, Model model) {
		model.addAttribute("wechatRefundRecord", wechatRefundRecord);
		return "modules/bus/wp/wechatRefundRecordForm";
	}

	@RequiresPermissions("bus:wp:wechatRefundRecord:edit")
	@RequestMapping(value = "save")
	public String save(WechatRefundRecord wechatRefundRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wechatRefundRecord)){
			return form(wechatRefundRecord, model);
		}
		wechatRefundRecordService.save(wechatRefundRecord);
		addMessage(redirectAttributes, "保存微信退款记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatRefundRecord/?repage";
	}
	
	@RequiresPermissions("bus:wp:wechatRefundRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(WechatRefundRecord wechatRefundRecord, RedirectAttributes redirectAttributes) {
		wechatRefundRecordService.delete(wechatRefundRecord);
		addMessage(redirectAttributes, "删除微信退款记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatRefundRecord/?repage";
	}

    @RequiresPermissions("bus:wp:wechatRefundRecord:view")
    @RequestMapping(value = "info")
    public String info(WechatRefundRecord wechatRefundRecord, Model model) {
        model.addAttribute("wechatRefundRecord", wechatRefundRecord);
        return "modules/bus/wp/wechatRefundRecordInfo";
    }
}