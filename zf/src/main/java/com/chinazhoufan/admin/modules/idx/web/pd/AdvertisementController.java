/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.pd;

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
import com.chinazhoufan.admin.modules.idx.entity.pd.Advertisement;
import com.chinazhoufan.admin.modules.idx.entity.pd.Channel;
import com.chinazhoufan.admin.modules.idx.service.pd.AdvertisementService;

/**
 * 广告Controller
 * @author 张金俊
 * @version 2016-08-12
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/pd/advertisement")
public class AdvertisementController extends BaseController {

	@Autowired
	private AdvertisementService advertisementService;
	
	@ModelAttribute
	public Advertisement get(@RequestParam(required=false) String id) {
		Advertisement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = advertisementService.get(id);
		}
		if (entity == null){
			entity = new Advertisement();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:pd:advertisement:view")
	@RequestMapping(value = {"list", ""})
	public String list(Advertisement advertisement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Advertisement> page = advertisementService.findPage(new Page<Advertisement>(request, response), advertisement); 
		model.addAttribute("page", page);
		return "modules/idx/pd/advertisementList";
	}

	@RequiresPermissions("idx:pd:advertisement:view")
	@RequestMapping(value = "form")
	public String form(Advertisement advertisement, Model model) {
		if(StringUtils.isBlank(advertisement.getId())) {
			advertisement.setUsableFlag(Advertisement.TRUE_FLAG);
		}
		model.addAttribute("advertisement", advertisement);
		return "modules/idx/pd/advertisementForm";
	}

	@RequiresPermissions("idx:pd:advertisement:edit")
	@RequestMapping(value = "save")
	public String save(Advertisement advertisement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, advertisement)){
			return form(advertisement, model);
		}
		advertisementService.save(advertisement);
		addMessage(redirectAttributes, "保存广告成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/advertisement/?repage";
	}
	
	@RequiresPermissions("idx:pd:advertisement:edit")
	@RequestMapping(value = "delete")
	public String delete(Advertisement advertisement, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(advertisement.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的广告信息！");
			return "error/400";
		}
		advertisementService.delete(advertisement);
		addMessage(redirectAttributes, "删除广告成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/advertisement/?repage";
	}
	
	@RequiresPermissions("idx:pd:advertisement:view")
	@RequestMapping(value = "info")
	public String info(Advertisement advertisement, HttpServletRequest request, HttpServletResponse response,  Model model) {
		if(StringUtils.isBlank(advertisement.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的广告信息！");
			return "error/400";
		}
		model.addAttribute("advertisement", advertisement);
		return "modules/idx/pd/advertisementInfo";
	}

	
	@RequiresPermissions("idx:pd:advertisement:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(Advertisement advertisement, RedirectAttributes redirectAttributes) {
		advertisement.setUsableFlag(Advertisement.TRUE_FLAG.equals(advertisement.getUsableFlag()) ? Advertisement.FALSE_FLAG : Advertisement.TRUE_FLAG);
		advertisementService.save(advertisement);
		addMessage(redirectAttributes, (Advertisement.TRUE_FLAG.equals(advertisement.getUsableFlag()) ? "启用" : "停用")+"广告成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/advertisement/?repage";
    }
	
	
}