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
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcProp;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsRcPropService;

/**
 * 商品推荐属性表Controller
 * @author 刘晓东
 * @version 2016-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsRcProp")
public class GoodsRcPropController extends BaseController {

	@Autowired
	private GoodsRcPropService goodsRcPropService;
	
	@ModelAttribute
	public GoodsRcProp get(@RequestParam(required=false) String id) {
		GoodsRcProp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsRcPropService.get(id);
		}
		if (entity == null){
			entity = new GoodsRcProp();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goodsRcProp:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsRcProp goodsRcProp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsRcProp> page = goodsRcPropService.findPage(new Page<GoodsRcProp>(request, response), goodsRcProp); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsRcPropList";
	}

	@RequiresPermissions("lgt:ps:goodsRcProp:view")
	@RequestMapping(value = "form")
	public String form(GoodsRcProp goodsRcProp, Model model) {
		model.addAttribute("goodsRcProp", goodsRcProp);
		return "modules/lgt/ps/goodsRcPropForm";
	}

	@RequiresPermissions("lgt:ps:goodsRcProp:edit")
	@RequestMapping(value = "save")
	public String save(GoodsRcProp goodsRcProp, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsRcProp)){
			return form(goodsRcProp, model);
		}
		goodsRcPropService.save(goodsRcProp);
		addMessage(redirectAttributes, "保存商品推荐属性表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcProp/?repage";
	}
	
	@RequiresPermissions("lgt:ps:goodsRcProp:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsRcProp goodsRcProp, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsRcProp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品推荐属性信息！");
			return "error/400";
		}
		goodsRcPropService.delete(goodsRcProp);
		addMessage(redirectAttributes, "删除商品推荐属性表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcProp/?repage";
	}

}