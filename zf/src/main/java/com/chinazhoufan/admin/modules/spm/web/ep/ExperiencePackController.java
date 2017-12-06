/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ep;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.idx.entity.sw.StarsWear;
import com.chinazhoufan.api.common.service.ServiceException;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
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
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackService;

/**
 * 体验包Controller
 * @author 舒剑雄
 * @version 2017-08-30
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ep/experiencePack")
public class ExperiencePackController extends BaseController {

	@Autowired
	private ExperiencePackService experiencePackService;
	
	@ModelAttribute
	public ExperiencePack get(@RequestParam(required=false) String id) {
		ExperiencePack entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = experiencePackService.get(id);
		}
		if (entity == null){
			entity = new ExperiencePack();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ep:experiencePack:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExperiencePack experiencePack, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperiencePack> page = experiencePackService.findPage(new Page<ExperiencePack>(request, response), experiencePack);
		model.addAttribute("page", page);
		return "modules/spm/ep/experiencePackList";
	}

	@RequiresPermissions("spm:ep:experiencePack:view")
	@RequestMapping(value = "form")
	public String form(ExperiencePack experiencePack, Model model) {
		model.addAttribute("experiencePack", experiencePack);
		return "modules/spm/ep/experiencePackForm";
	}

	@RequiresPermissions("spm:ep:experiencePack:edit")
	@RequestMapping(value = "save")
	public String save(ExperiencePack experiencePack, Model model, RedirectAttributes redirectAttributes) {
		try {
		experiencePackService.save(experiencePack);
		addMessage(redirectAttributes, "保存体验包成功");
		} catch (ServiceException se) {//无可用快递单号给予的提醒
			addMessage(model, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+Global.getAdminPath()+"/spm/ep/experiencePack/?repage";
	}
	
	@RequiresPermissions("spm:ep:experiencePack:edit")
	@RequestMapping(value = "delete")
	public String delete(ExperiencePack experiencePack, RedirectAttributes redirectAttributes) {
		experiencePackService.delete(experiencePack);
		addMessage(redirectAttributes, "删除体验包成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/experiencePack/?repage";
	}

    @RequiresPermissions("spm:ep:experiencePack:view")
    @RequestMapping(value = "info")
    public String info(ExperiencePack experiencePack, Model model) {
        model.addAttribute("experiencePack", experiencePack);
        return "modules/spm/ep/experiencePackInfo";
    }

	/**
	 * 更新体验包启用状态
	 * @param id
	 * @param activeFlag  操作类型，（启用=1， 停用=0）
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:ep:experiencePack:edit")
	@RequestMapping(value = "updateUsable")
	public String updateStatus(String id, String activeFlag, RedirectAttributes redirectAttributes, Model model) {
		//获取操作类型（启用=1， 停用=0）
		String returnUrl = Global.getAdminPath()+"/spm/ep/experiencePack/?repage";
		if(StringUtils.isBlank(id)){
			addMessage(redirectAttributes, "体验包启用状态变更失败：未获取到体验包状态信息");
			return returnUrl;

		}

		//获取原有的体验包状态参数信息
		ExperiencePack experiencePack = experiencePackService.get(id);
		//获取体验包对应的状态信息
		if("0".equals(activeFlag)){
			experiencePack.setActiveFlag(experiencePack.FALSE_FLAG);
		}else if("1".equals(activeFlag)){
			experiencePack.setActiveFlag(experiencePack.TRUE_FLAG);
		}
		experiencePackService.save(experiencePack);
		addMessage(redirectAttributes, "体验包状态操作成功");
		return "redirect:"+returnUrl;
	}
}