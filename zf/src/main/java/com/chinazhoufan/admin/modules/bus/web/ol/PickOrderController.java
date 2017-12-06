/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.modules.bus.dao.ol.SendOrderDao;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.pm.PlateManageService;
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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.PickOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.api.common.service.ServiceException;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 拣货单Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/pickOrder")
public class PickOrderController extends BaseController {

	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private SendOrderDao sendOrderDao;


	@Autowired
	private PickOrderService pickOrderService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private ServiceApplyService serviceApplyService;
	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private PlateManageService plateManageService;
	
	@ModelAttribute
	public PickOrder get(@RequestParam(required=false) String id) {
		PickOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pickOrderService.get(id);
		}
		if (entity == null){
			entity = new PickOrder();
		}
		return entity;
	}
	
	/**
	 * 拣货单列表
	 */
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PickOrder> page = pickOrderService.findPage(new Page<PickOrder>(request, response), pickOrder); 
		model.addAttribute("page", page);
		return "modules/bus/ol/pickOrderList";
	}
	
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = "form")
	public String form(PickOrder pickOrder, Model model) {
		model.addAttribute("pickOrder", pickOrder);
		return "modules/bus/ol/pickOrderForm";
	}
	
	@RequiresPermissions("bus:ol:pickOrder:edit")
	@RequestMapping(value = "save")
	public String save(PickOrder pickOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pickOrder)){
			return form(pickOrder, model);
		}
		pickOrderService.save(pickOrder);
		addMessage(redirectAttributes, "保存拣货单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/pickOrder/?repage";
	}
	
	@RequiresPermissions("bus:ol:pickOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(PickOrder pickOrder, RedirectAttributes redirectAttributes) {
		pickOrderService.delete(pickOrder);
		addMessage(redirectAttributes, "删除拣货单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/pickOrder/?repage";
	}

	/**
	 * 拣货单详情
	 */
    @RequiresPermissions("bus:ol:pickOrder:view")
    @RequestMapping(value = "info")
    public String info(PickOrder pickOrder, Model model) {
    	PickOrder po = pickOrderService.getDetailWithSendOrder(pickOrder);
        model.addAttribute("pickOrder", po);
        return "modules/bus/ol/pickOrderInfo";
    }
    
    
    
    /************************************************ 我的拣货任务start ******************************************************/
    /**
	 * 我的拣货单列表
	 */
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = "myPickList")
	public String myPickList(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		pickOrder.setPickBy(UserUtils.getUser());
		Page<PickOrder> page = pickOrderService.findPage(new Page<PickOrder>(request, response), pickOrder); 
		model.addAttribute("page", page);
		return "modules/bus/ol/myPickList";
	}
	
    /**
	 * 拣货单任务明细
	 */
    @RequiresPermissions("bus:ol:pickOrder:view")
    @RequestMapping(value = "missionDetail")
    public String missionDetail(PickOrder pickOrder, Model model) {
    	List<Produce> list = pickOrderService.getMissionDetailByPickOrder(pickOrder);
    	model.addAttribute("list", list);
        return "modules/bus/ol/pickOrderMissionDetail"; 
    }
    /************************************************ 我的拣货任务end ******************************************************/
    
    
    
    /************************************************ 我的打包任务start ******************************************************/
	/**
	 * 打包任务列表
	 */
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = "myPackageList")
	public String myPackageList(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		pickOrder.setPackageBy(UserUtils.getUser());
		Page<PickOrder> page = pickOrderService.findPageForPackage(new Page<PickOrder>(request, response), pickOrder); 
		model.addAttribute("page", page);
		return "modules/bus/ol/myPackageList";
	}
	
    /**
     * 打包扫码接单表单界面
     * @return
     */
    @RequiresPermissions("bus:ol:pickOrder:view")
    @RequestMapping(value = "packageScanForm")
    public String packageScanForm() {
    	return "modules/bus/ol/packageScanForm";
    }
    
    /**
     * 托盘编码验证接口
     * @return
     */
    @ResponseBody
    @RequiresPermissions("bus:ol:pickOrder:view")
    @RequestMapping(value = "checkPlateNo")
    public String checkPlateNo(PickOrder pickOrder) {
    	Echos echo = null;
    	try {
    		//TODO 托盘编码验证接口，等托盘编码表创建在完善
			echo = new Echos(1, "托盘编码OK!");
		} catch (Exception e) {
			echo = new Echos(0, "接收的托盘编码【"+pickOrder.getPlateNo()+"】不符合要求!");
		}
    	return JsonMapper.toJsonString(echo);
    }
    
    /**
	 * 扫描托盘电子码或点击页面接单按钮“接单”，“打包发货单”，跳转到打包操作界面
	 */
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = "toMyPackageForm")
	public String toMyPackageForm(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			PlateManage plateManage = plateManageService.getInUseByPlateNo(pickOrder.getPlateNo());
			if (plateManage != null){
				//更新拣货单的打包开始时间
				PickOrder po = pickOrderService.findPickOrderByPlateNo(pickOrder);
				if(po == null) {
					addMessage(model, "接单失败：编号为【"+pickOrder.getPlateNo()+"】的托盘不存在或该托盘没有对应的拣货中的拣货单，请核对!");
					return myPackageList(new PickOrder(UserUtils.getUser()), request, response, model);
				}
				//更新打包人，打包开始时间
				pickOrderService.receivePickOrder(po);
				//组装出库单数据
				SendOrder so = pickOrderService.generateData(po);
				if(so == null || StringUtils.isBlank(so.getReceiveName())) {
					addMessage(model, "提示：该拣货单下没有已激活待打包的发货单，或按顺序待打包的发货单中收货人姓名为空，请核对!");
					return myPackageList(new PickOrder(UserUtils.getUser()), request, response, model);
				}
				model.addAttribute("sendOrder", so);
				if (SendOrder.ORDERTYPE_EXPERIENCE.equals(so.getOrderType())){
					model.addAttribute("isFirstOrderFlag", experienceOrderService.isFirstOrder(so.getOrderId()));
				}else {
					model.addAttribute("isFirstOrderFlag", false);
				}
			}else {
				addMessage(model, "操作失败，当前托盘号不可用，请核实！");
				return myPackageList(new PickOrder(UserUtils.getUser()), request, response, model);
			}
		} catch (ServiceException se) {//无可用快递单号给予的提醒
			addMessage(model, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "modules/bus/ol/myPackageForm";
	}

	/**
	 * “打包发货单”，进入打包操作界面
	 */
	@RequiresPermissions("bus:ol:pickOrder:view")
	@RequestMapping(value = "myPackageForm")
	public String myPackageForm(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			SendOrder so;
			String type = request.getParameter("type");
			if (type != null && type.equals("read")){
				model.addAttribute("type", type);
				String pickOrderId = request.getParameter("pickOrderId");
				String sendOrderId = request.getParameter("sendOrderId");
                pickOrder = pickOrderService.get(pickOrderId);
				pickOrder.setSendOrderId(sendOrderId);
				so = pickOrderService.generateData(pickOrder,SendOrder.STATUS_WAITSEND);
			}else{
				//更新拣货单的打包开始时间
				pickOrderService.updatePackgeTime(pickOrder);
				so = pickOrderService.generateData(pickOrder);
				if(so == null || StringUtils.isBlank(so.getReceiveName())) {
					addMessage(model, "提示：该拣货单下没有已激活待打包的发货单，或按顺序待打包的发货单中收货人姓名为空，请核对!");
					return myPackageList(new PickOrder(UserUtils.getUser()), request, response, model);
				}
			}
			if (SendOrder.ORDERTYPE_EXPERIENCE.equals(so.getOrderType())){
				model.addAttribute("isFirstOrderFlag", experienceOrderService.isFirstOrder(so.getOrderId()));
			}else {
				model.addAttribute("isFirstOrderFlag", false);
			}
			model.addAttribute("sendOrder", so);
		} catch (com.chinazhoufan.admin.common.service.ServiceException se) {//无可用快递单号给予的提醒
			addMessage(model, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "modules/bus/ol/myPackageForm";
	}
	
	/**
	 * 发货单管理
	 */
    @RequiresPermissions("bus:ol:pickOrder:view")
    @RequestMapping(value = "myPackageSendOrderList")
    public String myPackageSendOrderList(PickOrder pickOrder, Model model) {
    	PickOrder po = pickOrderService.getDetailWithSendOrder(pickOrder);
        model.addAttribute("pickOrder", po);
        return "modules/bus/ol/myPackageSendOrderList";
    }    
    
    /**
     * 变更发货单激活标记
     * @param sendOrder
     * @return
     */
    @ResponseBody
    @RequiresPermissions("bus:ol:pickOrder:edit")
    @RequestMapping(value = "updateActiveFlagById")
    public String updateActiveFlagById(SendOrder sendOrder) {
    	Echos echo = null;
    	try {
    		SendOrder so = sendOrderService.get(sendOrder);
    		if(SendOrder.FALSE_FLAG.equals(so.getActiveFlag())) {
    			so.setActiveFlag(SendOrder.TRUE_FLAG);
    		} else {
    			so.setActiveFlag(SendOrder.FALSE_FLAG);
    		}
			sendOrderService.updateActiveFlagById(so);
			echo = new Echos(1, "更新激活标记成功!");
		} catch (Exception e) {
			echo = new Echos(0, "更新激活标记失败!");
		}
    	return JsonMapper.toJsonString(echo);
    }
    
    /**
     * 取消发货单对应的体验单或购买单
     * @param sendOrder
     * @return
     */
    @ResponseBody
    @RequiresPermissions("bus:ol:pickOrder:edit")
    @RequestMapping(value = "applyCancelBusinessOrder")
    public String applyCancelBusinessOrder(SendOrder sendOrder) {
    	Echos echo = null;
    	try {
    		SendOrder so = sendOrderService.get(sendOrder);
    		//变更发货单状态
			so.setStatus(SendOrder.STATUS_CANCEL);
			sendOrderDao.update(so);

    		serviceApplyService.createBySendOrder(so);
			echo = new Echos(1, "根据退货单生成（取消订单的）服务申请记录成功!");
		} catch (Exception e) {
			e.printStackTrace();
			echo = new Echos(0, "根据退货单生成（取消订单的）服务申请记录失败!");
		}
    	return JsonMapper.toJsonString(echo);
    }


}

