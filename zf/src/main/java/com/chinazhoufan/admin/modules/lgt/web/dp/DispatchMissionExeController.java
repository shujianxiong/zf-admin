/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.dp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchMissionService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchOrderService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProduceService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;

/**
 * 执行调货任务Controller
 * @author 刘晓东
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/dp/dispatchMissionExe")
public class DispatchMissionExeController extends BaseController {

	@Autowired
	private DispatchMissionService dispatchMissionService;
	@Autowired
	private DispatchProduceService dispatchProduceService;
	@Autowired
	private DispatchProductService dispatchProductService;
	@Autowired
	private DispatchOrderService dispatchOrderService;
	@Autowired
	private ProductService productService;
	
	@ModelAttribute
	public DispatchMission get(@RequestParam(required=false) String id) {
		DispatchMission entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dispatchMissionService.get(id);
		}
		if (entity == null){
			entity = new DispatchMission();
		}
		return entity;
	}
	
	/**
	 * 根据当前用户查询属于自己的执行调货的数据
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchMissionExe:view")
	@RequestMapping(value = {"list", ""})
	public String list(DispatchMission dispatchMission,HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.findPageoutUser(new Page<DispatchMission>(request, response), dispatchMission);
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionExeList";
	}

	@RequiresPermissions("lgt:dp:dispatchMissionExe:view")
	@RequestMapping(value = "form")
	public String form(DispatchMission dispatchMission, Model model) {
		model.addAttribute("dispatchMission", dispatchMission);
		return "modules/lgt/dp/dispatchMissionExeForm";
	}
	
	
	
	/**
	 * 添加货品表单显示
	 * @param purchaseProduceId
	 * @param purchase
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("lgt:dp:dispatchMissionExe:edit")
//	@RequestMapping(value = "addProductForm")
//	public String addProductForm(String dispatchProduceId, DispatchMission dispatchMission, Model model) {
//		DispatchProduce dispatchProduce = dispatchProduceService.get(dispatchProduceId);
////		dispatchProduce.setDispatchMission(dispatchMission);
//		List<DispatchProduct> dispatchProductList = dispatchProductService.findListByDispatchProduceId(dispatchProduce.getId());
//		model.addAttribute("dispatchProduce", dispatchProduce);
//		model.addAttribute("dispatchProductList", dispatchProductList);
//		return "modules/lgt/dp/dispatchMissionExeAddProductForm";
//	}
	
	/**
	 * 添加货品保存
	 * @param purchaseProduce
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	/*@RequiresPermissions("lgt:dp:dispatchMissionExe:edit")
	@RequestMapping(value = "addProductFormSave")
	public String addProductFormSave(DispatchProduce dispatchProduce, Model model, RedirectAttributes redirectAttributes) {
		try{
			dispatchProduceService.save(dispatchProduce);
		}catch(Exception e){
			addMessage(redirectAttributes, e.getMessage());
			return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMissionExe/addProductForm?dispatchProduceId="+dispatchProduce.getId();
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMissionExe/form?id="+dispatchProduce.getDispatchOrder().getId();
	}*/
	

	
	
}

