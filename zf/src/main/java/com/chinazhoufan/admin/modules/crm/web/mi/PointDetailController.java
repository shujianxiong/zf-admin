/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mi;

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
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;
import com.chinazhoufan.admin.modules.crm.service.mi.PointDetailService;

/**
 * 会员积分账户流水表Controller
 * @author 刘晓东
 * @version 2016-01-05
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mi/pointDetail")
public class PointDetailController extends BaseController {

	@Autowired
	private PointDetailService pointDetailService;
	
	@ModelAttribute
	public PointDetail get(@RequestParam(required=false) String id) {
		PointDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pointDetailService.get(id);
		}
		if (entity == null){
			entity = new PointDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mi:pointDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(PointDetail pointDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PointDetail> page = pointDetailService.findPage(new Page<PointDetail>(request, response), pointDetail); 
		model.addAttribute("page", page);
		return "modules/crm/mi/pointDetailList";
	}

	@RequiresPermissions("crm:mi:pointDetail:view")
	@RequestMapping(value = "info")
	public String info(PointDetail pointDetail, Model model) {
		model.addAttribute("pointDetail", pointDetail);
		return "modules/crm/mi/pointDetailInfo";
	}
	
	@RequiresPermissions("crm:mi:pointDetail:view")
	@RequestMapping(value = "form")
	public String form(PointDetail pointDetail, Model model) {
		model.addAttribute("pointDetail", pointDetail);
		return "modules/crm/mi/pointDetailForm";
	}

	@RequiresPermissions("crm:mi:pointDetail:edit")
	@RequestMapping(value = "save")
	public String save(PointDetail pointDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pointDetail)){
			return form(pointDetail, model);
		}
		try {
			pointDetail.setOperaterType(PointDetail.OPERATER_TYPE_STAFF);
			pointDetailService.updatePoint(pointDetail);
			addMessage(redirectAttributes, "更新会员积分成功");
		} catch (Exception e) {
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/crm/mi/pointDetail/?repage";
	}
	
	@RequiresPermissions("crm:mi:pointDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(PointDetail pointDetail, RedirectAttributes redirectAttributes) {
		pointDetailService.delete(pointDetail);
		addMessage(redirectAttributes, "删除会员积分账户流水表成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/pointDetail/?repage";
	}
	

}