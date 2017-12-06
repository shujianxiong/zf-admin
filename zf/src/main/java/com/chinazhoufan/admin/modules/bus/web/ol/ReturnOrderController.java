/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.entity.gold.BasGoldPriceGather;
import com.chinazhoufan.admin.modules.bus.dao.bs.BreakdownStandardDao;
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.bus.entity.ol.ExpressBroken;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.service.bs.BreakdownStandardService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ExpressBrokenService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
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
import com.chinazhoufan.admin.modules.bus.bean.Order;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 退货单Controller
 * @author 张金俊
 * @version 2017-04-19
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/returnOrder")
public class ReturnOrderController extends BaseController {

	@Autowired
	private ReturnOrderService returnOrderService;

	@Autowired
	private ReturnProductService returnProductService;

	@Autowired
	private ExpressBrokenService expressBrokenService;
	@Autowired
	private ServiceApplyService serviceApplyService;
	@Autowired
	private BreakdownStandardDao breakdownStandardDao;


	@ModelAttribute
	public ReturnOrder get(@RequestParam(required=false) String id) {
		ReturnOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = returnOrderService.get(id);
		}
		if (entity == null){
			entity = new ReturnOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ol:returnOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(ReturnOrder returnOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ReturnOrder> page = returnOrderService.findPage(new Page<ReturnOrder>(request, response), returnOrder); 
		model.addAttribute("page", page);
		model.addAttribute("beginReceiveTime", returnOrder.getBeginReceiveTime());
		model.addAttribute("endReceiveTime", returnOrder.getEndReceiveTime());
		return "modules/bus/ol/returnOrderList";
	}

	@RequiresPermissions("bus:ol:returnOrder:view")
	@RequestMapping(value = "form")
	public String form(ReturnOrder returnOrder, Model model) {
		model.addAttribute("returnOrder", returnOrder);
		return "modules/bus/ol/returnOrderForm";
	}

	@RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "save")
	public String save(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, returnOrder)){
			return form(returnOrder, model);
		}
		returnOrderService.save(returnOrder);
		addMessage(redirectAttributes, "保存退货单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/?repage";
	}
	
	@RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(ReturnOrder returnOrder, RedirectAttributes redirectAttributes) {
		returnOrderService.delete(returnOrder);
		addMessage(redirectAttributes, "删除退货单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/?repage";
	}

    @RequiresPermissions("bus:ol:returnOrder:view")
    @RequestMapping(value = "info")
    public String info(@RequestParam(required=false) String id, Model model) {
    	ReturnOrder returnOrder= returnOrderService.get(id);
		returnOrder.setReturnProductList(returnProductService.getByReturnOrder(id));
        model.addAttribute("returnOrder", returnOrder);
        return "modules/bus/ol/returnOrderInfo";
    }
    
    /**
     * 确认收货，变更退货单状态由 退货中->待质检
     * @param returnOrder
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "confirm")
	public String confirm(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
    	returnOrder.setStatus(ReturnOrder.STATUS_TOCHECK);
		User user = UserUtils.getUser();//当前用户即为回货收货人
		returnOrder.setReceiveBy(user);
		returnOrderService.updateStatusById(returnOrder);
		addMessage(redirectAttributes, "退货货品收货成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/?repage";
	}
	/**
	 * 退货单包裹核对
	 * @param returnOrder
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:bagCheck:view")
	@RequestMapping(value = "bagCheck")
	public String bagCheck(ReturnOrder returnOrder, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		Page<ReturnOrder> page = returnOrderService.findPage(new Page<ReturnOrder>(request, response), returnOrder);
		model.addAttribute("page", page);
		model.addAttribute("beginReceiveTime", returnOrder.getBeginReceiveTime());
		model.addAttribute("endReceiveTime", returnOrder.getEndReceiveTime());
		return "modules/bus/ol/returnOrderCheck";
	}


	@RequiresPermissions("bus:ol:bagCheck:view")
	@RequestMapping(value = "toCheck")
	public String toCheck(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
		if(returnOrder.getOrderId() == null){
			addMessage(redirectAttributes, "未获取到退货单，请刷新");
			return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/?repage";
		}
		ExpressBroken expressBroken =expressBrokenService.findByReturnOrderId(returnOrder.getId());
		//检查此包裹是否存在损坏记录
		if(null == expressBroken){
			expressBroken = new ExpressBroken();
			expressBroken.setReturnOrder(returnOrder);
		}
		model.addAttribute("expressBroken", expressBroken);
		return "modules/bus/ol/expressBrokenForm";
	}

    /**
     * 退货货品登记
     * @param returnOrder
     * @param model
     * @return
     */
    @RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "register")
	public String register(ReturnOrder returnOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
    	ReturnOrder ro = returnOrderService.findWithProductByExpressNo(returnOrder);
    	model.addAttribute("returnOrder", ro);
    	model.addAttribute("repairOrder", new RepairOrder());
    	return "modules/bus/ol/returnProductForm";
	}
    
    @RequiresPermissions("bus:ol:returnOrder:view")
    @RequestMapping(value = "index")
    public String receiveIndex(Model model ) {
    	List<ReturnOrder> ro = returnOrderService.findReceiptList();
    	model.addAttribute("returnOrderList", ro);
    	return "modules/bus/ol/returnOrderIndex";
    }
    
    
    @ResponseBody
    @RequiresPermissions("bus:ol:returnOrder:view")
    @RequestMapping(value = "findOrderByExpressNo")
    public String findOrderByExpressNo(String expressNo, HttpServletRequest request, HttpServletResponse response) {
    	Echos echo = null;
    	if(StringUtils.isBlank(expressNo)) {
    		echo = new Echos();
    		echo.setStatus(0);
    		echo.setMessage("回单号不允许为空!");
    		return JsonMapper.toJsonString(echo);
    	}
    	
		List<Order> orderList = returnOrderService.findOrderByExpressNo(expressNo);
		if(orderList == null) {
			echo = new Echos();
    		echo.setStatus(0);
    		echo.setMessage("未找到回单号【"+expressNo+"】关联的退货单记录，请核查!");
			return JsonMapper.toJsonString(echo);
		}else if(orderList.size() == 0){
			echo = new Echos();
			echo.setStatus(0);
			echo.setMessage("回单号【"+expressNo+"】关联的退货单已收货，请核查!");
			return JsonMapper.toJsonString(echo);
		}
		echo = new Echos();
		echo.setStatus(1);
		echo.setData(orderList);
		return JsonMapper.toJsonString(echo);
		
    };
	/**
	 * 退货货品质检
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:productCheck:view")
	@RequestMapping(value = "toQuality")
	public String toQuality(@RequestParam(required=false) String id, @RequestParam(required=false) String returnOrderNo,Model model, RedirectAttributes redirectAttributes) {
		ReturnProduct returnProduct = new ReturnProduct();
		ReturnOrder returnOrder = returnOrderService.get(id);
		returnProduct.setReturnOrder(returnOrder);
		List<ReturnProduct> returnProducts = returnProductService.findListByReturnOrderId(returnProduct);
		returnOrder.setReturnProductList(returnProducts);
		returnOrder.setCheckBy(UserUtils.getUser());
		model.addAttribute("returnOrder", returnOrder);
		List<ServiceApply> serviceApplyList = serviceApplyService.findByOrder(returnOrder.getOrderId());
		model.addAttribute("serviceApplyList", JsonMapper.toJsonString(serviceApplyList));
		return "modules/bus/ol/returnOrderQuality";
	}
	/**
	 * 退货货品扫描质检
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:productCheck:view")
	@RequestMapping(value = "scan")
	public String scan(@RequestParam(required=false) String expressNo,Model model, RedirectAttributes redirectAttributes) {
		try {
		ReturnProduct returnProduct = new ReturnProduct();
		ReturnOrder returnOrder = returnOrderService.getByExpressNo(expressNo);
		if(returnOrder == null){
			addMessage(redirectAttributes, "操作失败：运单号不存在对应的退货单或者退货单状态不是待质检！");
			return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/bagCheck?repage";
		}
		returnProduct.setReturnOrder(returnOrder);
		List<ReturnProduct> returnProducts = returnProductService.findListByReturnOrderId(returnProduct);
		returnOrder.setReturnProductList(returnProducts);
		returnOrder.setCheckBy(UserUtils.getUser());
		model.addAttribute("returnOrder", returnOrder);
		List<ServiceApply> serviceApplyList = serviceApplyService.findByOrder(returnOrder.getOrderId());
		model.addAttribute("serviceApplyList", JsonMapper.toJsonString(serviceApplyList));
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "modules/bus/ol/returnOrderQuality";
	}
	/**
	 * 退货货品扫描包裹
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:bagCheck:view")
	@RequestMapping(value = "scanBag")
	public String scanBag(@RequestParam(required=false) String expressNo,Model model, RedirectAttributes redirectAttributes) {
		try {
			ReturnOrder returnOrder = returnOrderService.getByExpressNo(expressNo);
			if(returnOrder == null){
				addMessage(redirectAttributes, "操作失败：运单号不存在对应的退货单或者退货单状态不是待质检！");
				return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/list?repage";
			}
			ExpressBroken expressBroken =expressBrokenService.findByReturnOrderId(returnOrder.getId());
			//检查此包裹是否存在损坏记录
			if(null == expressBroken){
				expressBroken = new ExpressBroken();
				expressBroken.setReturnOrder(returnOrder);
			}
			model.addAttribute("expressBroken", expressBroken);
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "modules/bus/ol/expressBrokenForm";
	}
	@RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "batchSave")
	public String batchSave(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
		try {
			Boolean isSave =returnOrderService.qualitySave(returnOrder);
			if(isSave){
				addMessage(redirectAttributes, "退货货品质检保存成功");
			}else{
				addMessage(redirectAttributes, "操作失败：退货货品质检保存失败");
			}
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/list?repage";
	}
	/**
	 * 责任清单
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:returnOrder:view")
	@RequestMapping(value = "qualityInfo")
	public String qualityInfo(@RequestParam(required=false) String id, Model model, RedirectAttributes redirectAttributes) {
		ReturnProduct returnProduct = new ReturnProduct();
		ReturnOrder returnOrder = returnOrderService.get(id);
		//检查回货单状态，只有质检过的单才能打印责任清单
		if(ReturnOrder.STATUS_TOACCOUNT.equals(returnOrder.getStatus()) || ReturnOrder.STATUS_FINISH.equals(returnOrder.getStatus()) ){
			ExpressBroken expressBroken =expressBrokenService.findByReturnOrderId(returnOrder.getId());
			returnProduct.setReturnOrder(returnOrder);
			List<ReturnProduct> returnProducts = returnProductService.findListByReturnOrderId(returnProduct);
			returnOrder.setReturnProductList(returnProducts);
			model.addAttribute("returnOrder", returnOrder);
			model.addAttribute("expressBroken", expressBroken);
			return "modules/bus/ol/expressBrokenPrint";

		}else{
			addMessage(redirectAttributes, "操作失败：请完成质检后才能打印清单");
			return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/?repage";
		}

	}
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = {"getRateBreak"})
	public BreakdownStandard getRateBreak(String breakdownType ,HttpServletRequest request, HttpServletResponse response) {
		BreakdownStandard breakdownStandard=breakdownStandardDao.getByType(breakdownType);
		if(breakdownStandard == null)breakdownStandard=new BreakdownStandard();
		return breakdownStandard;
	}
	/**
	 * 回货质检时，存在重度损坏换新，回货单挂起
	 * @param
	 */
	@RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "hang")
	public String hang(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
		try {
			returnOrderService.hang(returnOrder);
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/list?repage";
	}
	/**
	 * 回货单激活
	 * @param
	 */
	@RequiresPermissions("bus:ol:returnOrder:edit")
	@RequestMapping(value = "active")
	public String active(ReturnOrder returnOrder, Model model, RedirectAttributes redirectAttributes) {
		try {
			returnOrderService.active(returnOrder);
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/list?repage";
	}
}