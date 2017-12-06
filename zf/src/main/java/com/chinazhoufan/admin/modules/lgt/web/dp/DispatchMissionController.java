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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.approve.annotation.ApproveAop;
import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveRecord;
import com.chinazhoufan.admin.modules.bas.service.BasMissionService;
import com.chinazhoufan.admin.modules.bas.service.ap.ApproveRecordService;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchMissionService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchOrderService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;

/**
 * 调货任务Controller
 * @author 刘晓东
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/dp/dispatchMission")
public class DispatchMissionController extends BaseController {

	@Autowired
	private DispatchMissionService dispatchMissionService;
	@Autowired
	private WarehouseService warehouseService;
	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private DispatchOrderService dispatchOrderService;
	@Autowired
	private BasMissionService basMissionService;
	@Autowired
	private ApproveRecordService approveRecordService;
	
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
	 * 查询仓库产品
	 * @param param   值调入仓库ID&多个产品ID，    如 E1&1,2,3,4,  warehouseId & produceIdArr
	 * @return
	 */
	@RequestMapping(value = "/ajax/queryProudceStock", method = RequestMethod.POST)
	public @ResponseBody String queryProudceStock(String param, HttpServletResponse response){
		List<WhProduce> whProduces = null;
		try {
			if(StringUtils.isBlank(param)) 
				return renderString(response, "请先选择产品");
			String[] arr = param.split("=");
			List<String> produceIdList = Lists.newArrayList();
			String[] eIdList = arr[1].split(",");
			for(String eids : eIdList) {
				produceIdList.add(eids);
			}
			whProduces=whProduceService.findListByProduceIdArr(arr[0], produceIdList);
		} catch (Exception e) {
			e.printStackTrace();
			return renderString(response, "false:程序出错了");
		}
//		return JsonMapper.toJsonString(echos);
		return renderString(response, JsonMapper.toJsonString(whProduces));
	}
	
	
	/**
	 * 调货发起人查询自己发起的调货任务
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:view")
	@RequestMapping(value = {"list", ""})
	public String list(DispatchMission dispatchMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.findPageByStartBy(new Page<DispatchMission>(request, response), dispatchMission); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionList";
	}
	/**
	 * 审核所有的任务
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:view")
	@RequestMapping(value = "checkList")
	public String checkList(DispatchMission dispatchMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.findPage(new Page<DispatchMission>(request, response), dispatchMission); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionCheckList";
	}
	/**
	 * 系统当前用户查询需要调货入库的数据
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:view")
	@RequestMapping(value = "callinList")
	public String callinList(DispatchMission dispatchMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.findPageinUser(new Page<DispatchMission>(request, response), dispatchMission); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionCallinList";
	}

	/**
	 * 我的待入库调货单
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:view")
	@RequestMapping(value = "pendingStockList")
	public String pendingStockList(DispatchMission dispatchMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.pendingStockList(new Page<DispatchMission>(request, response), dispatchMission); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/pendingStockList";
	}
	
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:view")
	@RequestMapping(value = "form")
	public String form(DispatchMission dispatchMission, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		//判断是否创建操作
		if(StringUtils.isBlank(dispatchMission.getId())){
			//发起人为当前操作员
			dispatchMission.setStartBy(UserUtils.getUser());
			//发起人时间为当前时间
			dispatchMission.setStartTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
			//任务状态
			dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCONFIRMED);
		} else {
			/**
			 * 任务单当在审核未能通过状态为1才能修改
			 */
			DispatchOrder dispatchOrder = new DispatchOrder();
			dispatchOrder.setDispatchMission(dispatchMission);
			List<DispatchOrder> dispatchOrderList = dispatchOrderService.findList(dispatchOrder);
			dispatchMission.setDispatchOrderList(dispatchOrderList);
		}
		model.addAttribute("dispatchMission", dispatchMission);
		return "modules/lgt/dp/dispatchMissionForm";
	}
	
	/**
	 * 调货货品到货后确认到货
	 * @param dispatchMission
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "info")
	public String info(DispatchMission dispatchMission, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		/*DispatchOrder dispatchOrder = new DispatchOrder();
		dispatchOrder.setDispatchMission(dispatchMission);
		List<DispatchOrder> dispatchOrderList = dispatchOrderService.findList(dispatchOrder);
		dispatchMission.setDispatchOrderList(dispatchOrderList);*/
		if(StringUtils.isBlank(dispatchMission.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的调货任务信息！");
			return "error/400";
		}
		
		DispatchMission mission = dispatchMissionService.findMissionWithProductAndProduceBySearchParam(dispatchMission);
		model.addAttribute("dispatchMission", mission);
		return "modules/lgt/dp/dispatchMissionCallinForm";
	}
	/**
	 * 查看详细信息
	 * @param dispatchMission
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "detailed")
	public String detailed(DispatchMission dispatchMission, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		/*DispatchOrder dispatchOrder = new DispatchOrder();
		dispatchOrder.setDispatchMission(dispatchMission);
		List<DispatchOrder> dispatchOrderList = dispatchOrderService.findList(dispatchOrder);
		dispatchMission.setDispatchOrderList(dispatchOrderList);*/
		//TODO orderId验证要加？注意，这里必须要给dispatchMission.dispatchOrder.id赋值，因为这个是查询单个调货单详情的
		DispatchMission disM = dispatchMissionService.getDispatchMissionWithDetailAll(dispatchMission);
		if(disM != null) {
			List<DispatchOrder> oList = disM.getDispatchOrderList();
			if(oList.size() > 0) 
				disM.setDispatchOrder(oList.get(0));
			model.addAttribute("dispatchMission", disM);
		} else {
			model.addAttribute("dispatchMission", dispatchMission);
		}
		return "modules/lgt/dp/dispatchMissionInfo";
	}
	
	/**
	 * 查看一个调货任务的完整的详细信息
	 * @param dispatchMission
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "detailedAll")
	public String detailedAll(DispatchMission dispatchMission, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		dispatchMission = dispatchMissionService.getDispatchMissionWithDetailAll(dispatchMission);
		model.addAttribute("dispatchMission", dispatchMission);
		return "modules/lgt/dp/dispatchMissionInfoAll";
	}
	
	/**
	 * 跳转到任务修改界面
	 * @param dispatchMission
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "edit")
	public String edit(DispatchMission dispatchMission, Model model, HttpServletRequest request, HttpServletResponse response){
		/**
		 * 任务单当在审核未能通过状态为1才能修改
		 */
		DispatchOrder dispatchOrder = new DispatchOrder();
		dispatchOrder.setDispatchMission(dispatchMission);
		List<DispatchOrder> dispatchOrderList = dispatchOrderService.findList(dispatchOrder);
		dispatchMission.setDispatchOrderList(dispatchOrderList);
		model.addAttribute("dispatchMission", dispatchMission);
		return "modules/lgt/dp/dispatchMissionUpdateForm";
	}
	
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "updateSave")
	public String updateSave(DispatchMission dispatchMission, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		dispatchMissionService.save(dispatchMission);
		addMessage(redirectAttributes, "调货任务修改成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMission/?repage";
	}
	
	@ApproveAop(businessType="lgt_dp_dispatch",businessStatus="lgt_dp_dispatch_1",approveType="create")
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "save")
	public String save(DispatchMission dispatchMission, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		
		if (!beanValidator(model, dispatchMission)){
			return form(dispatchMission, model, request,redirectAttributes, response);
		}
		//limitTime不得大于发起时间
		if (DateUtils.compare_date(dispatchMission.getStartTime(), dispatchMission.getLimitTime()) > 0 ) {
			addMessage(model, "警告,要求完成时间不得小于发起时间！");
			return form(dispatchMission, model, request,redirectAttributes, response);
		}
		//未录入产品时不得保存
		if (!(dispatchMission.getDispatchOrderList().size() > 0)) {
			addMessage(model, "警告,请录入调货产品后再保存");
			return form(dispatchMission, model, request,redirectAttributes, response);
		}
		dispatchMissionService.save(dispatchMission);
		addMessage(redirectAttributes, "保存调货任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMission/?repage";
	}
	
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "delete")
	public String delete(DispatchMission dispatchMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(dispatchMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调货任务信息！");
			return "error/400";
		}
		dispatchMissionService.delete(dispatchMission);
		addMessage(redirectAttributes, "删除调货任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMission/?repage";
	}
	/**
	 * 发布任务审核
	 * @return
	 */
	@ApproveAop(businessType="lgt_dp_dispatch",businessStatus="lgt_dp_dispatch_1",approveType="test")
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "release")
	public String release(DispatchMission dispatchMission, RedirectAttributes redirectAttributes){ 
		dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCALLOUT);
		dispatchMissionService.Update(dispatchMission);
		addMessage(redirectAttributes, "发布任务成功,等待相关人员就受任务");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMission/?repage";
	}
	
	//跳转到审核页面
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "approvalRecordList")
	public String approvalRecordList(DispatchMission dispatchMission,ApproveRecord approvalRecord,Model model, HttpServletRequest request, HttpServletResponse response){
		List<ApproveRecord> approvalRecords = approveRecordService.findList(approvalRecord);
		model.addAttribute("approvalRecords", approvalRecords);//获取审批记录信息
		DispatchOrder dispatchOrder = new DispatchOrder();
		dispatchOrder.setDispatchMission(dispatchMission);//根据任务的id来查询调货单信息
		List<DispatchOrder> dispatchOrders = dispatchOrderService.findList(dispatchOrder); 
		model.addAttribute("dispatchOrders", dispatchOrders);
		return "modules/lgt/dp/approveRecordList";
	}
	//执行审核方法
	@RequiresPermissions("lgt:dp:lgtPsDispatchMission:edit")
	@RequestMapping(value = "approvalRecordSava")
	public String approvalRecordSava(ApproveRecord approvalRecord,String dispatchMissionId, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		//审核是否成功，成功需要修改任务状态为执行中
		DispatchMission dispatchMission = dispatchMissionService.get(dispatchMissionId);
		dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCALLIN);
		dispatchMissionService.Update(dispatchMission);
		addMessage(redirectAttributes, "任务审核操作成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/dp/dispatchMission/checkList/?repage";
	}
	
}