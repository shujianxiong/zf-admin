/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;
import com.chinazhoufan.admin.modules.bus.service.pm.PlateManageService;
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
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;

/**
 * 发货单Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/sendOrder")
public class SendOrderController extends BaseController {

	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private ConfigService configService;
	@Autowired
	private PlateManageService plateManageService;
	
	@ModelAttribute
	public SendOrder get(@RequestParam(required=false) String id) {
		SendOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sendOrderService.get(id);
		}
		if (entity == null){
			entity = new SendOrder();
		}
		return entity;
	}

	
    /*************************************生成测试代码****************************************/
	//TODO 待删
    @RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "createTestData")
    public void createTestData() {
    	sendOrderService.createTestData();
    }
    /*************************************生成测试代码****************************************/
    
    /**
     * 发货单列表
     */
	@RequiresPermissions("bus:ol:sendOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendOrder sendOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendOrder> page = sendOrderService.findPage(new Page<SendOrder>(request, response), sendOrder); 
		model.addAttribute("page", page);
		
		model.addAttribute("currentDate", DateUtils.parseDate(DateUtils.getDate()));
		return "modules/bus/ol/sendOrderList";
	}
	
	@RequiresPermissions("bus:ol:sendOrder:view")
	@RequestMapping(value = "form")
	public String form(SendOrder sendOrder, Model model) {
		model.addAttribute("sendOrder", sendOrder);
		return "modules/bus/ol/sendOrderForm";
	}

	@RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "save")
	public String save(SendOrder sendOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sendOrder)){
			return form(sendOrder, model);
		}
		sendOrderService.save(sendOrder);
		addMessage(redirectAttributes, "保存出库单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendOrder/?repage";
	}
	
	@RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(SendOrder sendOrder, RedirectAttributes redirectAttributes) {
		sendOrderService.delete(sendOrder);
		addMessage(redirectAttributes, "删除出库单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendOrder/?repage";
	}

	/**
     * 发货单详情
     */
    @RequiresPermissions("bus:ol:sendOrder:view")
    @RequestMapping(value = "info")
    public String info(SendOrder sendOrder, Model model) {
    	sendOrder = sendOrderService.findWithDetail(sendOrder);
        model.addAttribute("sendOrder", sendOrder);
        return "modules/bus/ol/sendOrderInfo";
    }
    
    
    /************************************************ 分拣货品start ******************************************************/
	/**
	 * 列出待拣货的发货单（发货日期在当前日期或之前，状态为待拣货，删除标记为未删除）
	 * @param sendOrder
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bus:ol:sendOrder:view")
	@RequestMapping(value = "listToPick")
	public String listToPick(SendOrder sendOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 拣货员一次性能接单的发货单数量上限
		Config con = new Config();
		con.setCode("maxReceiveSendOrderNum");
		Config config = configService.getConfigByCode(con);
		model.addAttribute("config", config);
		
		// 分页大小为能接单的发货单数量上限
		Page<SendOrder> page = new Page<SendOrder>(request, response);
		page.setPageSize(new Integer(config.getConfigValue()));
		page = sendOrderService.findToPickPage(page, sendOrder);
		model.addAttribute("page", page);

		//查询时间重置后赋值
		model.addAttribute("beginCreateTime", sendOrder.getBeginCreateTime());
		model.addAttribute("endCreateTime", sendOrder.getEndCreateTime());
		return "modules/bus/ol/sendOrderToPickList";
	}
	
    /**
     * 接单，生成拣货单，并排序
     * @param ids
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "receiveSendOrder")
    public String receiveSendOrder(String ids,String orderIds, String plateNo, RedirectAttributes redirectAttributes) {
    	if(StringUtils.isBlank(ids) || StringUtils.isBlank(plateNo)) {
    		addMessage(redirectAttributes, "参数值未制定");
    		return "error/404";
    	}
		try {
			PlateManage plateManage = plateManageService.getByPlateNo(plateNo, true);
			if (plateManage != null){
				sendOrderService.receiveSendOrder(ids, orderIds, plateManage, null);
				addMessage(redirectAttributes, "您已接受【"+ids.split(",").length+"】笔出库单，请尽快完成拣货!");
			}else {
				addMessage(redirectAttributes, "操作失败，当前托盘号不可用，请核实！");
			}
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			/*还原托盘使用状态*/
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
    	return "redirect:"+Global.getAdminPath()+"/bus/ol/sendOrder/listToPick?repage";
    }
    /************************************************ 分拣货品end ******************************************************/
    
    /**
     * 打印详情
     * @param sendOrder
     * @param model
     * @return
     */
    @RequiresPermissions("bus:ol:sendOrder:view")
    @RequestMapping(value = "printInfo")
    public String printInfo(SendOrder sendOrder, Model model) {
    	sendOrder = sendOrderService.findWithDetail(sendOrder);
        model.addAttribute("sendOrder", sendOrder);
        return "modules/bus/ol/sendOrderPrintInfo";
    }
    

    /************************************************ 发货单确认出库start ******************************************************/

	/**
	 * 发货单确认出库
	 * @param sendProduct
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "sendOrderOutConfirm")
	public String sendOrderOutConfirm(SendProduct sendProduct, Model model, RedirectAttributes redirectAttributes) {
		Boolean pickOrderFinishFlag = false;
		try {
			pickOrderFinishFlag = sendOrderService.sendOrderOutConfirm(sendProduct);
			addMessage(redirectAttributes, "发货单出库成功");
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		if(!pickOrderFinishFlag)
			return "redirect:"+Global.getAdminPath()+"/bus/ol/pickOrder/myPackageForm?id="+sendProduct.getSendOrder().getPickOrder().getId();
		return "redirect:"+Global.getAdminPath()+"/bus/ol/pickOrder/myPackageList";
	}
    /************************************************ 发货单确认出库end ******************************************************/


	/************************************************ 确认发货start ******************************************************/

	/**
	 * 发货单确认出库
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "confirmSend")
	public String confirmSend(@RequestParam(required=false) String id, RedirectAttributes redirectAttributes) {
		try {
			sendOrderService.confirmSend(id);
			addMessage(redirectAttributes, "确认发货成功");
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendOrder";
	}
	/************************************************ 确认发货end ******************************************************/


	/************************************************ 批量确认发货start ******************************************************/

	/**
	 * 发货单确认出库
	 * @param ids
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:sendOrder:edit")
	@RequestMapping(value = "batchConfirmSend")
	public String batchConfirmSend(@RequestParam(required=false) String ids, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(ids)) {
			addMessage(redirectAttributes, "参数值未制定");
			return "error/404";
		}
		try {
			String[] idList = ids.split(",");
			for (String id : idList){
				sendOrderService.confirmSend(id);
				addMessage(redirectAttributes, "确认发货成功");
			}
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendOrder";
	}
	/************************************************ 批量确认发货end ******************************************************/
}
