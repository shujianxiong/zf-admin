/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.cl;

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
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsViewService;

/**
 * 会员商品浏览记录Controller
 * @author 贾斌
 * @version 2016-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/cl/goodsView")
public class GoodsViewController extends BaseController {

	@Autowired
	private GoodsViewService goodsViewService;
	
	@ModelAttribute
	public GoodsView get(@RequestParam(required=false) String id) {
		GoodsView entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsViewService.get(id);
		}
		if (entity == null){
			entity = new GoodsView();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:cl:goodsView:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsView goodsView, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsView> page = goodsViewService.findPage(new Page<GoodsView>(request, response), goodsView); 
		model.addAttribute("page", page);
		return "modules/crm/cl/goodsViewList";
	}

	@RequiresPermissions("crm:cl:goodsView:view")
	@RequestMapping(value = "form")
	public String form(GoodsView goodsView, Model model) {
		model.addAttribute("goodsView", goodsView);
		return "modules/crm/cl/goodsViewForm";
	}

	@RequiresPermissions("crm:cl:goodsView:edit")
	@RequestMapping(value = "save")
	public String save(GoodsView goodsView, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsView)){
			return form(goodsView, model);
		}
		goodsViewService.save(goodsView);
		addMessage(redirectAttributes, "保存会员商品浏览记录成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/goodsView/?repage";
	}
	
	@RequiresPermissions("crm:cl:goodsView:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsView goodsView, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsView.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员商品浏览记录！");
			return "error/400";
		}
		goodsViewService.delete(goodsView);
		addMessage(redirectAttributes, "删除会员商品浏览记录成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/goodsView/?repage";
	}

}