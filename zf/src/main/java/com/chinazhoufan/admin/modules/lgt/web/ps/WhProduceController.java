/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.util.Date;
import java.util.List;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 仓库产品库存表Controller
 * @author 刘晓东
 * @version 2016-03-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/whProduce")
public class WhProduceController extends BaseController {

	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private WarehouseService warehouseService;
	
	@ModelAttribute
	public WhProduce get(@RequestParam(required=false) String id) {
		WhProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = whProduceService.get(id);
		}
		if (entity == null){
			entity = new WhProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:whProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(WhProduce whProduce, String stockStatus, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WhProduce> page = whProduceService.findPage(new Page<WhProduce>(request, response), whProduce, stockStatus);
		Warehouse wh = new Warehouse();
		wh.setUsableFlag(Warehouse.TRUE_FLAG);
		List<Warehouse> list = warehouseService.findList(wh);
		model.addAttribute("page", page);
		model.addAttribute("stockStatus", stockStatus);
		model.addAttribute("code", list.get(0).getCode());
		return "modules/lgt/ps/whProduceList";
	}

	@RequiresPermissions("lgt:ps:whProduce:view")
	@RequestMapping(value = "form")
	public String form(WhProduce whProduce, Model model) {
		whProduce.setUpdateBy(UserUtils.getUser());
		whProduce.setUpdateDate(new Date());
		model.addAttribute("whProduce", whProduce);
		return "modules/lgt/ps/whProduceForm";
	}

	@RequiresPermissions("lgt:ps:whProduce:edit")
	@RequestMapping(value = "save")
	public String save(WhProduce whProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, whProduce)){
			return form(whProduce, model);
		}
		whProduceService.save(whProduce);
		addMessage(redirectAttributes, "保存仓库产品库存设置成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/whProduce/?repage";
	}
	
	/**
	 * 批量设置仓库库存
	 * @param whProduce
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("lgt:ps:whProduce:edit")
	@RequestMapping(value = "batchSave")
	public String batchSave(WhProduce whProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, whProduce)){
			return form(whProduce, model);
		}
		whProduceService.batchSave(whProduce);
		addMessage(redirectAttributes, "保存仓库产品库存设置成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/whProduce/?repage";
	}
	
	
	@RequiresPermissions("lgt:ps:whProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(WhProduce whProduce, RedirectAttributes redirectAttributes) {
		if(whProduce == null || StringUtils.isBlank(whProduce.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到仓库产品库存信息！");
			return "error/400";
		}
		
		whProduceService.delete(whProduce);
		addMessage(redirectAttributes, "删除仓库产品库存设置成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/whProduce/?repage";
	}

	/**
	 * 注意此处的pageKey = 请求过来的页面名称
	 * @param whProduce
	 * @param pageKey
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:ps:whProduce:view")
	@RequestMapping(value="select")
	public String select(WhProduce whProduce, String pageKey, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<Produce> page = whProduceService.findWarehouseProduce(new Page<Produce>(request,response),whProduce);
		model.addAttribute("page", page);
		model.addAttribute("pageKey", pageKey);
		return "modules/lgt/ps/whProduceSelect";
	}
	
	
	/**
	 * 启用或停用监控
	 * @param warehouse
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:whProduce:edit")
	@RequestMapping("updateMotinorStatus")
	public String updateMotinorStatus(WhProduce whProduce,String stockStatus, String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (whProduce == null || StringUtils.isBlank(whProduce.getId())) {
			addMessage(model, "操作失败，未能获取到有效仓库信息");
			return list(whProduce,stockStatus, request, response, model);
		}
		try {
			WhProduce whProduceOld = whProduceService.get(whProduce.getId());
			if (StringUtils.isBlank(Integer.toString(whProduceOld.getStockWarning())) || StringUtils.isBlank(Integer.toString(whProduceOld.getStockStandard()))||StringUtils.isBlank(Integer.toString(whProduceOld.getStockSafe()))) {
				addMessage(model, "操作失败，未能获取到有效库存信息");
				return list(whProduce,stockStatus, request, response, model);
			}else {
				whProduceOld.setMotinorStatus(status);
				whProduceService.update(whProduceOld);
				addMessage(model, "操作成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败");
		}
		return list(whProduce,stockStatus, request, response, model);
	}
}