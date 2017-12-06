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
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsCollectService;

/**
 * 会员商品收藏表Controller
 * @author 刘晓东
 * @version 2015-11-20
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/cl/goodsCollect")
public class GoodsCollectController extends BaseController {

	@Autowired
	private GoodsCollectService goodsCollectService;
	
	@ModelAttribute
	public GoodsCollect get(@RequestParam(required=false) String id) {
		GoodsCollect entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsCollectService.get(id);
		}
		if (entity == null){
			entity = new GoodsCollect();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:cl:goodsCollect:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsCollect goodsCollect, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsCollect> page = goodsCollectService.findPage(new Page<GoodsCollect>(request, response), goodsCollect); 
		model.addAttribute("page", page);
		return "modules/crm/cl/goodsCollectList";
	}

	@RequiresPermissions("crm:cl:goodsCollect:view")
	@RequestMapping(value = "form")
	public String form(GoodsCollect goodsCollect, Model model) {
		model.addAttribute("goodsCollect", goodsCollect);
		return "modules/crm/cl/goodsCollectForm";
	}

	@RequiresPermissions("crm:cl:goodsCollect:edit")
	@RequestMapping(value = "save")
	public String save(GoodsCollect goodsCollect, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsCollect)){
			return form(goodsCollect, model);
		}
		goodsCollectService.save(goodsCollect);
		addMessage(redirectAttributes, "保存会员商品收藏表成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/goodsCollect/?repage";
	}
	
	@RequiresPermissions("crm:cl:goodsCollect:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsCollect goodsCollect, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsCollect.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员商品收藏记录！");
			return "error/400";
		}
		goodsCollectService.delete(goodsCollect);
		addMessage(redirectAttributes, "删除会员商品收藏表成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/goodsCollect/?repage";
	}

}