/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ob;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;

/**
 * 购买单Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ob/buyOrder")
public class BuyOrderController extends BaseController {

	@Autowired
	private BuyOrderService buyOrderService;
	
	@ModelAttribute
	public BuyOrder get(@RequestParam(required=false) String id) {
		BuyOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = buyOrderService.get(id);
		}
		if (entity == null){
			entity = new BuyOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ob:buyOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(BuyOrder buyOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BuyOrder> page = buyOrderService.findPage(new Page<BuyOrder>(request, response), buyOrder); 
		model.addAttribute("page", page);
		return "modules/bus/ob/buyOrderList";
	}

	@RequiresPermissions("bus:ob:buyOrder:view")
	@RequestMapping(value = "form")
	public String form(BuyOrder buyOrder, Model model) {
		model.addAttribute("buyOrder", buyOrder);
		return "modules/bus/ob/buyOrderForm";
	}

	@RequiresPermissions("bus:ob:buyOrder:edit")
	@RequestMapping(value = "save")
	public String save(BuyOrder buyOrder, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, buyOrder)){
			return form(buyOrder, model);
		}*/
		buyOrderService.save(buyOrder);
		addMessage(redirectAttributes, "保存购买单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyOrder/?repage";
	}
	
	
	/**
	 * 关闭订单
	 * @param experienceOrder
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ob:buyOrder:edit")
	@RequestMapping(value = "closeBuyOrder")
	public String closeBuyOrder(BuyOrder buyOrder, Model model, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(buyOrder.getId())) {
			addMessage(model, "友情提示：参数不完整，请核查");
			return "error/404";
		}
		
		try{
			buyOrderService.closeBuyOrder(buyOrder);
		}catch(Exception e){
			addMessage(redirectAttributes, e.getMessage());
			return "redirect:"+Global.getAdminPath()+"/bus/ob/buyOrder/?repage";
		}
		addMessage(redirectAttributes, "关闭购买单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyOrder/?repage";
	}
	
	
	@RequiresPermissions("bus:ob:buyOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(BuyOrder buyOrder, RedirectAttributes redirectAttributes) {
		buyOrderService.delete(buyOrder);
		addMessage(redirectAttributes, "删除购买单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyOrder/?repage";
	}

    @RequiresPermissions("bus:ob:buyOrder:view")
    @RequestMapping(value = "info")
    public String info(BuyOrder buyOrder, Model model) {
    	if(StringUtils.isBlank(buyOrder.getId())) {
			addMessage(model, "友情提示：参数不完整，请核查");
			return "error/404";
		}
    	buyOrder = buyOrderService.getDetail(buyOrder.getId());
        model.addAttribute("buyOrder", buyOrder);
        return "modules/bus/ob/buyOrderInfo";
    }

//    @RequiresPermissions("bus:ob:buyOrder:edit")
//	@RequestMapping(value = "judge")
//	public String judge(BuyOrder buyOrder, String orderJudgeId, Integer judgeType, RedirectAttributes redirectAttributes) {
//    	buyOrderService.judge(buyOrder, orderJudgeId, judgeType);
//		addMessage(redirectAttributes, "购买单评价审核操作成功!");
//		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyOrder/?repage";
//	}
    
    
    @RequiresPermissions("bus:ob:buyOrder:view")
	@RequestMapping(value = "select")
	public String select(BuyOrder buyOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BuyOrder> page = buyOrderService.findPage(new Page<BuyOrder>(request, response), buyOrder); 
		model.addAttribute("page", page);
		return "modules/bus/ob/buyOrderSelect";
	}
    
    
}