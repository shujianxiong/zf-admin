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
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcPropvalue;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsRcPropvalueService;

/**
 * 商品推荐属性值表Controller
 * @author 刘晓东
 * @version 2016-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsRcPropvalue")
public class GoodsRcPropvalueController extends BaseController {

	@Autowired
	private GoodsRcPropvalueService goodsRcPropvalueService;
	
	@ModelAttribute
	public GoodsRcPropvalue get(@RequestParam(required=false) String id) {
		GoodsRcPropvalue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsRcPropvalueService.get(id);
		}
		if (entity == null){
			entity = new GoodsRcPropvalue();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goodsRcPropvalue:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsRcPropvalue goodsRcPropvalue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsRcPropvalue> page = goodsRcPropvalueService.findPage(new Page<GoodsRcPropvalue>(request, response), goodsRcPropvalue); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsRcPropvalueList";
	}

	@RequiresPermissions("lgt:ps:goodsRcPropvalue:view")
	@RequestMapping(value = "form")
	public String form(GoodsRcPropvalue goodsRcPropvalue, Model model) {
		model.addAttribute("goodsRcPropvalue", goodsRcPropvalue);
		return "modules/lgt/ps/goodsRcPropvalueForm";
	}

	@RequiresPermissions("lgt:ps:goodsRcPropvalue:edit")
	@RequestMapping(value = "save")
	public String save(GoodsRcPropvalue goodsRcPropvalue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsRcPropvalue)){
			return form(goodsRcPropvalue, model);
		}
		goodsRcPropvalueService.save(goodsRcPropvalue);
		addMessage(redirectAttributes, "保存商品推荐属性值表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcPropvalue/?repage";
	}
	
	@RequiresPermissions("lgt:ps:goodsRcPropvalue:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsRcPropvalue goodsRcPropvalue, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsRcPropvalue.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品推荐属性值信息！");
			return "error/400";
		}
		goodsRcPropvalueService.delete(goodsRcPropvalue);
		addMessage(redirectAttributes, "删除商品推荐属性值表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcPropvalue/?repage";
	}

}