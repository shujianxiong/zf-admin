/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.oe;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProduceService;
import com.chinazhoufan.admin.modules.express.services.SFService;
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
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackService;

/**
 * 体验单Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/oe/experienceOrder")
public class ExperienceOrderController extends BaseController {

	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private ReturnOrderService returnOrderService;
	@Autowired
	private ReturnProduceService returnProduceService;
	@Autowired
	private ServiceApplyService serviceApplyService;
	@Autowired
	private ExperiencePackService experiencePackService;
	@Autowired
	private SFService sfService;


	@ModelAttribute
	public ExperienceOrder get(@RequestParam(required=false) String id) {
		ExperienceOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = experienceOrderService.get(id);
		}
		if (entity == null){
			entity = new ExperienceOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:oe:experienceOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExperienceOrder experienceOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperienceOrder> page = experienceOrderService.findPage(new Page<ExperienceOrder>(request, response), experienceOrder); 
		model.addAttribute("page", page);
		return "modules/bus/oe/experienceOrderList";
	}

	@RequiresPermissions("bus:oe:experienceOrder:view")
	@RequestMapping(value = "form")
	public String form(ExperienceOrder experienceOrder, Model model) {
		model.addAttribute("experienceOrder", experienceOrder);
		return "modules/bus/oe/experienceOrderForm";
	}

	@RequiresPermissions("bus:oe:experienceOrder:edit")
	@RequestMapping(value = "save")
	public String save(ExperienceOrder experienceOrder, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, experienceOrder)){
			return form(experienceOrder, model);
		}*/
		experienceOrderService.save(experienceOrder);
		addMessage(redirectAttributes, "保存体验单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceOrder/?repage";
	}
	
	@RequiresPermissions("bus:oe:experienceOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(ExperienceOrder experienceOrder, RedirectAttributes redirectAttributes) {
		experienceOrderService.delete(experienceOrder);
		addMessage(redirectAttributes, "删除体验单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceOrder/?repage";
	}

    @RequiresPermissions("bus:oe:experienceOrder:view")
    @RequestMapping(value = "info")
    public String info(ExperienceOrder experienceOrder, Model model) {
    	if(StringUtils.isBlank(experienceOrder.getId())) {
			addMessage(model, "友情提示：参数不完整，请核查");
			return "error/404";
		}
    	experienceOrder = experienceOrderService.getDetail(experienceOrder.getId());
        List<ExperienceProduce> list = experienceOrder.getEpList();
        
        	for (int i = 0; i < list.size(); i++) {
            	Produce p =list.get(i).getProduce();

				BigDecimal experienceFee = null;
				BigDecimal experienceDepositFee = null;
				BigDecimal zeroBD = new BigDecimal("0.00");
    			if(p.getPriceSrc() != null && !zeroBD.equals(p.getPriceSrc()) && p.getScaleExperienceFee() != null && !zeroBD.equals(p.getScaleExperienceFee())) {
    				experienceFee = p.getPriceSrc().multiply(p.getScaleExperienceFee());
    				p.setExperienceFee(String.valueOf(Math.round(Math.ceil(experienceFee.doubleValue()))));
    			}

    			if(p.getPriceSrc() != null && !zeroBD.equals(p.getPriceSrc()) && p.getScaleExperienceDeposit() != null && !zeroBD.equals(p.getScaleExperienceDeposit())) {
    				experienceDepositFee = p.getPriceSrc().multiply(p.getScaleExperienceDeposit());
    				p.setExperienceDepositFee(String.valueOf(Math.round(Math.ceil(experienceDepositFee.doubleValue()))));
    			}
    			list.get(i).setReturnProduce(returnProduceService.getByOrderProduce(list.get(i).getId()));
    		}
        SendOrder sendOrder = sendOrderService.getByOrderId(experienceOrder.getId());
        if (sendOrder != null){
        	model.addAttribute("sendOrder", sendOrder);
        	if (StringUtils.isNotBlank(sendOrder.getExpressNo())){
				model.addAttribute("sendRouteInfo", sfService.sfexpressService(sendOrder.getExpressNo()));
			}
			if (StringUtils.isNotBlank(sendOrder.getReturnExpressNo())){
				model.addAttribute("returnRouteInfo", sfService.sfexpressService(sendOrder.getReturnExpressNo()));
			}
        }
        
      /*  ReturnOrder returnOrder = returnOrderService.getByOrderNo(experienceOrder.getOrderNo());
		returnOrder.setReturnProductList(returnProductService.getByReturnOrder(returnOrder.getId()));
        model.addAttribute("returnOrder", returnOrder);*/
      
        ExperiencePack experiencePack =   experiencePackService.get(experienceOrder.getExperiencePackId());
        if (experiencePack != null) {
        	model.addAttribute("experiencePack", experiencePack);
        }
    	ServiceApply sa = new ServiceApply();
        sa.setOrderId(experienceOrder.getId());
        List<ServiceApply> serviceApply =  serviceApplyService.findList(sa);
        model.addAttribute("serviceApply",serviceApply );
        model.addAttribute("experienceOrder", experienceOrder);
        return "modules/bus/oe/experienceOrderInfo";
    }
    
	/**
	 * 关闭订单
	 * @param experienceOrder
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:oe:experienceOrder:edit")
	@RequestMapping(value = "closeExperienceOrder")
	public String closeExperienceOrder(ExperienceOrder experienceOrder, Model model, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(experienceOrder.getId())) {
			addMessage(model, "友情提示：参数不完整，请核查");
			return "error/404";
		}
		
		try{
			experienceOrderService.closeExperienceOrder(experienceOrder);
		}catch(Exception e){
			addMessage(redirectAttributes, e.getMessage());
			return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceOrder/?repage";
		}
		addMessage(redirectAttributes, "关闭体验单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceOrder/?repage";
	}
	
    /**
     * 体验单选择器
     * @param experienceOrder
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("bus:oe:experienceOrder:view")
	@RequestMapping(value = "select")
	public String select(ExperienceOrder experienceOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperienceOrder> page = experienceOrderService.findPage(new Page<ExperienceOrder>(request, response), experienceOrder); 
		model.addAttribute("page", page);
		return "modules/bus/oe/experienceOrderSelect";
	}
    
    /**
     * 欠费信息列表
     * @param experienceOrder
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("bus:oe:experienceOrder:view")
   	@RequestMapping(value = "arrearageInfo")
   	public String arrearageInfo(ExperienceOrder experienceOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
    	experienceOrder.setStatusSystem(ExperienceOrder.STATUSMEMBER_DUE);
    	experienceOrder.setStatusMember(ExperienceOrder.STATUSMEMBER_DUE);
   		Page<ExperienceOrder> page = experienceOrderService.findPage(new Page<ExperienceOrder>(request, response), experienceOrder); 
   		model.addAttribute("page", page);
   		return "modules/bus/oe/arrearageInfo";
   	}
    
}
