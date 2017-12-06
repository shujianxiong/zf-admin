/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.rg;

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
import com.chinazhoufan.admin.modules.idx.entity.rg.RgInviteCode;
import com.chinazhoufan.admin.modules.idx.service.rg.RgInviteCodeService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

/**
 * 注册邀请码Controller
 * @author liut
 * @version 2016-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/rg/rgInviteCode")
public class RgInviteCodeController extends BaseController {

	@Autowired
	private RgInviteCodeService rgInviteCodeService;
	@Autowired
	private ConfigService configService;
	
	@ModelAttribute
	public RgInviteCode get(@RequestParam(required=false) String id) {
		RgInviteCode entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rgInviteCodeService.get(id);
		}
		if (entity == null){
			entity = new RgInviteCode();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:rg:rgInviteCode:view")
	@RequestMapping(value = {"list", ""})
	public String list(RgInviteCode rgInviteCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RgInviteCode> page = rgInviteCodeService.findPage(new Page<RgInviteCode>(request, response), rgInviteCode); 
		model.addAttribute("page", page);
		
		//判断系统注册邀请码开关是否已开
		/*
		Config config = new Config();
		config.setCode("registerInviteCodeUsableFlag");
		config.setConfigValue("0");
		Config conf = configService.getConfigByCode(config);
		model.addAttribute("config", conf);
		*/
		
		//2017-05-23 优化
		Config conf = ConfigUtils.getConfig("registerInviteCodeUsableFlag");
		if(conf != null && "0".equals(conf.getConfigValue())) {
			model.addAttribute("config", conf);
		} else {
			model.addAttribute("config", null);
		}
		
		return "modules/idx/rg/rgInviteCodeList";
	}

	@RequiresPermissions("idx:rg:rgInviteCode:view")
	@RequestMapping(value = "form")
	public String form(RgInviteCode rgInviteCode, Model model) {
		model.addAttribute("rgInviteCode", rgInviteCode);
		return "modules/idx/rg/rgInviteCodeForm";
	}

	@RequiresPermissions("idx:rg:rgInviteCode:edit")
	@RequestMapping(value = "save")
	public String save(RgInviteCode rgInviteCode, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, rgInviteCode)){
			return form(rgInviteCode, model);
		}
		rgInviteCodeService.save(rgInviteCode);
		addMessage(redirectAttributes, "保存注册邀请码成功");
		return "redirect:"+Global.getAdminPath()+"/idx/rg/rgInviteCode/?repage";
	}
	
	@RequiresPermissions("idx:rg:rgInviteCode:edit")
	@RequestMapping(value = "delete")
	public String delete(RgInviteCode rgInviteCode, RedirectAttributes redirectAttributes) {
		rgInviteCodeService.delete(rgInviteCode);
		addMessage(redirectAttributes, "删除注册邀请码成功");
		return "redirect:"+Global.getAdminPath()+"/idx/rg/rgInviteCode/?repage";
	}

    @RequiresPermissions("idx:rg:rgInviteCode:view")
    @RequestMapping(value = "info")
    public String info(RgInviteCode rgInviteCode, Model model) {
        model.addAttribute("rgInviteCode", rgInviteCode);
        return "modules/idx/rg/rgInviteCodeInfo";
    }
    
    /**
     * 批量生产注册邀请码
     * @param inviteCodeId
     * @param num
     * @param request
     * @param response
     * @param model
     * @return    设定文件
     * @throws
     */
    @RequiresPermissions("idx:rg:rgInviteCode:edit")
    @RequestMapping(value = "generateInviteCode")
    public String generateInviteCode(Integer num, String remarks, HttpServletRequest request, HttpServletResponse response, Model model) {
    	RgInviteCode ct = new RgInviteCode();
    	if(num == null || num < 1 || num > 1000) {
    		addMessage(model, "生成失败：注册邀请码的单次生成数量不能少于1，且不能大于1000，请重新输入");
    		return list(ct, request, response, model);
    	}
    	rgInviteCodeService.generateRgInviteCode(num, remarks);
    	addMessage(model, "注册邀请码已经成功生成");
    	ct = new RgInviteCode();
    	return list(ct, request, response, model);
    }
    
    
}