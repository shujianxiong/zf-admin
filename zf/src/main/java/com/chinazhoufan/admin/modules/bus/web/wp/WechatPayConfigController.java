/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.wp;

import java.util.List;

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
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayConfig;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatPayConfigService;

/**
 * 微信支付配置表Controller
 * @author liut
 * @version 2017-05-08
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/wp/wechatPayConfig")
public class WechatPayConfigController extends BaseController {

	@Autowired
	private WechatPayConfigService wechatPayConfigService;
	
	@ModelAttribute
	public WechatPayConfig get(@RequestParam(required=false) String id) {
		WechatPayConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wechatPayConfigService.get(id);
		}
		if (entity == null){
			entity = new WechatPayConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:wp:wechatPayConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(WechatPayConfig wechatPayConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WechatPayConfig> page = wechatPayConfigService.findPage(new Page<WechatPayConfig>(request, response), wechatPayConfig); 
		model.addAttribute("page", page);
		return "modules/bus/wp/wechatPayConfigList";
	}

	@RequiresPermissions("bus:wp:wechatPayConfig:view")
	@RequestMapping(value = "form")
	public String form(WechatPayConfig wechatPayConfig, Model model) {
		if(StringUtils.isBlank(wechatPayConfig.getId())) {
			List<WechatPayConfig> list = wechatPayConfigService.findList(wechatPayConfig);
			if(list != null && list.size() > 0) {
				wechatPayConfig = list.get(0);
			}
		}
		
		model.addAttribute("wechatPayConfig", wechatPayConfig);
		return "modules/bus/wp/wechatPayConfigForm";
	}

	@RequiresPermissions("bus:wp:wechatPayConfig:edit")
	@RequestMapping(value = "save")
	public String save(WechatPayConfig wechatPayConfig, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wechatPayConfig)){
			return form(wechatPayConfig, model);
		}
		wechatPayConfigService.save(wechatPayConfig);
		addMessage(model, "保存微信支付配置项成功");
		return form(wechatPayConfig, model);
	}
	
	@RequiresPermissions("bus:wp:wechatPayConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(WechatPayConfig wechatPayConfig, RedirectAttributes redirectAttributes) {
		wechatPayConfigService.delete(wechatPayConfig);
		addMessage(redirectAttributes, "删除微信支付配置项成功");
		return "redirect:"+Global.getAdminPath()+"/bus/wp/wechatPayConfig/?repage";
	}

    @RequiresPermissions("bus:wp:wechatPayConfig:view")
    @RequestMapping(value = "info")
    public String info(WechatPayConfig wechatPayConfig, Model model) {
        model.addAttribute("wechatPayConfig", wechatPayConfig);
        return "modules/bus/wp/wechatPayConfigInfo";
    }
}