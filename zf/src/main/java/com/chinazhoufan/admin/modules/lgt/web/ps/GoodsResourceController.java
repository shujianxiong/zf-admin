/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsResourceService;

/**
 * 商品资源Controller
 * @author 陈适
 * @version 2015-10-27
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsResource")
public class GoodsResourceController extends BaseController {

	@Autowired
	private GoodsResourceService goodsResourceService;
	
	@ModelAttribute
	public GoodsResource get(@RequestParam(required=false) String id) {
		GoodsResource entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsResourceService.get(id);
		}
		if (entity == null){
			entity = new GoodsResource();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goodsResource:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsResource goodsResource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsResource> page = goodsResourceService.findPage(new Page<GoodsResource>(request, response), goodsResource); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsResourceList";
	}

	@RequiresPermissions("lgt:ps:goodsResource:view")
	@RequestMapping(value = "form")
	public String form(GoodsResource goodsResource, Model model) {
		model.addAttribute("goodsResource", goodsResource);
		return "modules/lgt/ps/goodsResourceForm";
	}

	@RequiresPermissions("lgt:ps:goodsResource:edit")
	@RequestMapping(value = "save")
	public String save(GoodsResource goodsResource, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsResource)){
			return form(goodsResource, model);
		}
		goodsResourceService.save(goodsResource);
		addMessage(redirectAttributes, "保存商品资源成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsResource/?repage";
	}
	
	@RequiresPermissions("lgt:ps:goodsResource:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsResource goodsResource, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsResource.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品资源信息！");
			return "error/400";
		}
		goodsResourceService.delete(goodsResource);
		addMessage(redirectAttributes, "删除商品资源成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsResource/?repage";
	}

}