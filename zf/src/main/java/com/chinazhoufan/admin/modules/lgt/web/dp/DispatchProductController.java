/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.dp;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduce;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduct;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchMissionService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProduceService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProductService;

/**
 * 调货产品货品Controller
 * @author 贾斌
 * @version 2016-03-16
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/dp/dispatchProduct")
public class DispatchProductController extends BaseController {

	@Autowired
	private DispatchProductService dispatchProductService;
	@Autowired
	private DispatchProduceService dispatchProduceService;
	@Autowired
	private DispatchMissionService dispatchMissionService;
	
//	@ModelAttribute
	public DispatchProduct get(@RequestParam(required=false) String id) {
		DispatchProduct entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dispatchProductService.get(id);
		}
		if (entity == null){
			entity = new DispatchProduct();
		}
		return entity;
	}
	
//	@RequiresPermissions("lgt:dp:DispatchProduct:view")
	@RequestMapping(value = {"list", ""})
	public String list(DispatchProduct dispatchProduct,String dispatchProduceId, HttpServletRequest request, HttpServletResponse response, Model model) {
		dispatchProduct.setDispatchProduce(dispatchProduceService.get(dispatchProduceId));
		Page<DispatchProduct> page = dispatchProductService.findPage(new Page<DispatchProduct>(request, response), dispatchProduct); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchProductList";
	}

	@RequiresPermissions("lgt:dp:DispatchProduct:view")
	@RequestMapping(value = "form")
	public String form(DispatchProduct dispatchProduct, Model model) {
		model.addAttribute("DispatchProduct", dispatchProduct);
		return "modules/lgt/dp/dispatchProductForm";
	}

	@RequiresPermissions("lgt:dp:DispatchProduct:edit")
	@RequestMapping(value = "save")
	public String save(DispatchProduct dispatchProduct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dispatchProduct)){
			return form(dispatchProduct, model);
		}
		dispatchProductService.save(dispatchProduct);
		addMessage(redirectAttributes, "保存调货单货品列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchProduct/?repage";
	}
	
	@RequiresPermissions("lgt:dp:DispatchProduct:edit")
	@RequestMapping(value = "delete")
	public String delete(DispatchProduct dispatchProduct, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(dispatchProduct.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调货单货品信息！");
			return "error/400";
		}
		dispatchProductService.delete(dispatchProduct);
		addMessage(redirectAttributes, "删除调货单货品列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchProduct/?repage";
	}

	@RequestMapping(value = "stockInfo")
	public String stockInfo(DispatchProduct dispatchProduce,String dispatchOrderId, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<DispatchProduce> list = dispatchProduceService.listProductWithProduceByDispatchOrderId(dispatchOrderId);
		Page<DispatchProduce> page = new Page<DispatchProduce>(request, response);
		page.setList(list);
		model.addAttribute("page", page);
		//
		if(list != null && list.size() > 0) {
			String dispatchMissionId = list.get(0).getDispatchOrder().getDispatchMission().getId();
			DispatchMission dm = dispatchMissionService.get(dispatchMissionId);
			model.addAttribute("dispatchMission", dm);
		}
		return "modules/lgt/dp/dispatchMissionCallinForm";
	}
	
	
}