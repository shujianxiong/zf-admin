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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchMissionService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchOrderService;

/**
 * 调货单Controller
 * @author 贾斌
 * @version 2016-03-16
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/dp/dispatchOrder")
public class DispatchOrderController extends BaseController {

	@Autowired
	private DispatchOrderService dispatchOrderService;
	@Autowired
	private DispatchMissionService dispatchMissionService;
	
	@ModelAttribute
	public DispatchOrder get(@RequestParam(required=false) String id) {
		DispatchOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dispatchOrderService.get(id);
		}
		if (entity == null){
			entity = new DispatchOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:dp:dispatchOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchOrder> page = dispatchOrderService.findPage(new Page<DispatchOrder>(request, response), dispatchOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchOrderList";
	}

	@RequiresPermissions("lgt:dp:dispatchOrder:view")
	@RequestMapping(value = "form")
	public String form(DispatchOrder dispatchOrder, Model model) {
		model.addAttribute("dispatchOrder", dispatchOrder);
		return "modules/lgt/dp/dispatchOrderForm";
	}

	@RequiresPermissions("lgt:dp:dispatchOrder:edit")
	@RequestMapping(value = "save")
	public String save(DispatchOrder dispatchOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dispatchOrder)){
			return form(dispatchOrder, model);
		}
		dispatchOrderService.save(dispatchOrder);
		addMessage(redirectAttributes, "保存调货单列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchOrder/?repage";
	}
	
	@RequiresPermissions("lgt:dp:dispatchOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(DispatchOrder dispatchOrder, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(dispatchOrder.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调货单信息！");
			return "error/400";
		}
		
		dispatchOrderService.delete(dispatchOrder);
		addMessage(redirectAttributes, "删除调货单列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchOrder/?repage";
	}
	
	
	//---------------------我的调入，调出，待入库调货单=======================
	/**
	 * 系统当前用户查询需要调货入库的数据
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchOrder:view")
	@RequestMapping(value = "callinList")
	public String callinList(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchOrder> page = dispatchOrderService.callInList(new Page<DispatchOrder>(request, response), dispatchOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionCallinList";
	}
	
	
	/**
	 * 我的调出调货单
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchOrder:view")
	@RequestMapping(value = "callOutList")
	public String callOutList(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchOrder> page = dispatchOrderService.callOutList(new Page<DispatchOrder>(request, response), dispatchOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionExeList";
	}
	
	
	/**
	 * 我的待入库调货单
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchOrder:view")
	@RequestMapping(value = "pendingStockList")
	public String pendingStockList(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchOrder> page = dispatchOrderService.pendingStockList(new Page<DispatchOrder>(request, response), dispatchOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/pendingStockList";
	}
	
	
	//======================调入调出相关操作
	
	//接收调货任务改变状态
	@RequestMapping(value = "receiveMission")
	public String saveReceiveMission(DispatchOrder dispatchOrder,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
		DispatchMission dispatchMission = dispatchMissionService.get(dispatchOrder.getDispatchMission());
		dispatchMissionService.saveReceiveDispatchMission(dispatchMission,dispatchOrder.getId());
		addMessage(redirectAttributes, "接收调货单成功");
		dispatchOrder = new DispatchOrder();
		return callOutList(dispatchOrder, request, response, model);
	}
	
	/**
	 * 确认调货跳转页面
	 * 调货状态为2表示调货仓库管理员已经接收该任务等待确认调货，确认调货完成状态变为3派送中
	 * @param dispatchMission
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "confirmInfo")
	public String confirmInfo(DispatchOrder dispatchOrder, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		DispatchMission dm = dispatchMissionService.get(dispatchOrder.getDispatchMission());
		DispatchOrder doWithDetail = dispatchOrderService.getDispatchOrderWithGoodsDetail(dispatchOrder);
		if(doWithDetail != null && StringUtils.isBlank(doWithDetail.getPostType())) {
			doWithDetail.setPostType(DispatchOrder.POSTTYPEAUTO);
		}
		doWithDetail.setDispatchMission(dm);
		model.addAttribute("dispatchOrder", doWithDetail);
		return "modules/lgt/dp/dispatchMissionExeForm";
	}
	
	
	//确认调货数量和调货货品信息
	@RequiresPermissions("lgt:dp:dispatchOrder:edit")
	@RequestMapping(value = "confirmDispatchOrder")
	public String confirmDispatchOrder(DispatchOrder dispatchOrder, Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		DispatchMission dispatchMission = dispatchOrder.getDispatchMission();
		dispatchMission.setDispatchOrder(dispatchOrder);
		dispatchMissionService.confirmTheLibrary(dispatchMission);
		addMessage(redirectAttributes, "确认调货单货品信息成功");
		return callOutList(dispatchOrder, request, response, model);
	}
	
	//派送
	@RequestMapping(value = "sendMission")
	public String sendMission(DispatchOrder dispatchOrder,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
		String message = null;
		DispatchMission dispatchMission = null;
		try {
			dispatchMission = dispatchMissionService.get(dispatchOrder.getDispatchMission());
			dispatchMission.setDispatchOrder(dispatchOrder);
			dispatchMissionService.sendDispatchMission(dispatchMission);
			addMessage(redirectAttributes, "调货单派送成功");
		} catch (ServiceException e) {
			message = e.getMessage();
			addMessage(model, message);
		}
		return callOutList(dispatchOrder, request, response, model);
	}
	
	/**
	 * 调入方，确认到货
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchOrder:edit")
	@RequestMapping(value = "saveCallIn")
	public  @ResponseBody  String saveCallIn(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
		String status = "";
		try {
			DispatchMission dispatchMission = dispatchMissionService.get(dispatchOrder.getDispatchMission());
			dispatchMission.setDispatchOrder(dispatchOrder);
			dispatchMissionService.saveCallIn(dispatchMission);
			addMessage(redirectAttributes, "调入方确认收货成功，调货单目前状态为待质检");
			status = "true";
		} catch (Exception e) {
			e.printStackTrace();
			status = "false";
		}
		return JsonMapper.toJsonString(status);
	}
	
	@RequiresPermissions("lgt:dp:dispatchOrder:edit")
	@RequestMapping(value="saveProductStock")
	public String saveProductStock(DispatchOrder dispatchOrder, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
		DispatchMission dispatchMission = dispatchMissionService.get(dispatchOrder.getDispatchMission());
		dispatchMission.setDispatchOrder(dispatchOrder);
		dispatchMissionService.saveProductStock(dispatchMission);
		addMessage(redirectAttributes, "调入方货品入库成功，调货单目前状态为已完成");
		return pendingStockList(dispatchOrder, request, response, model);
		
	}
	
	//---------------------我的调入，调出，待入库调货单=======================
}