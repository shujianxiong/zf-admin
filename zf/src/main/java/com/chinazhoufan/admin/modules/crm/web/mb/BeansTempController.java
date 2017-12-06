/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
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
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansTemp;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansTempService;

/**
 * 会员魅力豆临时条目Controller
 * @author 张金俊
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mb/beansTemp")
public class BeansTempController extends BaseController {

	@Autowired
	private BeansTempService beansTempService;
	
	@ModelAttribute
	public BeansTemp get(@RequestParam(required=false) String id) {
		BeansTemp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = beansTempService.get(id);
		}
		if (entity == null){
			entity = new BeansTemp();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mb:beansTemp:view")
	@RequestMapping(value = {"list", ""})
	public String list(BeansTemp beansTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BeansTemp> page = beansTempService.findPage(new Page<BeansTemp>(request, response), beansTemp); 
		model.addAttribute("page", page);
		return "modules/crm/mb/beansTempList";
	}

	@RequiresPermissions("crm:mb:beansTemp:view")
	@RequestMapping(value = "form")
	public String form(BeansTemp beansTemp, Model model) {
		if(StringUtils.isBlank(beansTemp.getId())) {
			beansTemp.setCheckStatus(BeansTemp.STATUS_NEW);
		}
		model.addAttribute("beansTemp", beansTemp);
		return "modules/crm/mb/beansTempForm";
	}

	@RequiresPermissions("crm:mb:beansTemp:edit")
	@RequestMapping(value = "save")
	public String save(BeansTemp beansTemp, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, beansTemp)){
			return form(beansTemp, model);
		}*/
		try {
			if(!BeansTemp.STATUS_NEW.equals(beansTemp.getCheckStatus())) {
				addMessage(redirectAttributes, "提示：该魅力豆账户条目已审核，不允许修改!");
				return "redirect:"+Global.getAdminPath()+"/crm/mb/beansTemp/?repage";
			}
			beansTempService.save(beansTemp);
			addMessage(redirectAttributes, "保存会员魅力豆账户临时条目成功");
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "失败：保存会员魅力豆账户临时条目异常");
		}
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beansTemp/list/?repage";
	}
	
	@RequiresPermissions("crm:mb:beansTemp:edit")
	@RequestMapping(value = "delete")
	public String delete(BeansTemp beansTemp, RedirectAttributes redirectAttributes) {
		beansTempService.delete(beansTemp);
		addMessage(redirectAttributes, "删除会员魅力豆临时条目成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beansTemp/?repage";
	}

    @RequiresPermissions("crm:mb:beansTemp:view")
    @RequestMapping(value = "info")
    public String info(BeansTemp beansTemp, Model model) {
        model.addAttribute("beansTemp", beansTemp);
        return "modules/crm/mb/beansTempInfo";
    }
	/**
	 * 审核临时存折条目
	 * @param beansTemp
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("crm:mb:beansTemp:edit")
	@RequestMapping(value = "check")
	public String check(String checkType, BeansTemp beansTemp, RedirectAttributes redirectAttributes) {
		try{
			beansTempService.checkTemp(beansTemp, checkType);
		}catch(ServiceException se){
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
			return "redirect:"+Global.getAdminPath()+"/crm/mb/beansTemp/list/?repage";
		}
		addMessage(redirectAttributes, "审核会员资金账户临时条目成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beansTemp/list/?repage";
	}
}