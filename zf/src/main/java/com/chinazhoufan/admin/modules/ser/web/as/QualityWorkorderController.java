/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.as;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.dao.bs.BreakdownStandardDao;
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkordProductService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.query.QueryUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkorder;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkorderService;

/**
 * 质检工单列表Controller
 * @author 舒剑雄
 * @version 2017-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/as/qualityWorkorder")
public class QualityWorkorderController extends BaseController {

	@Autowired
	private QualityWorkorderService qualityWorkorderService;

	@Autowired
	private QualityWorkordProductService qualityWorkordProductService;
	@Autowired
	private BreakdownStandardDao breakdownStandardDao;
	
	@ModelAttribute
	public QualityWorkorder get(@RequestParam(required=false) String id) {
		QualityWorkorder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = qualityWorkorderService.get(id);
		}
		if (entity == null){
			entity = new QualityWorkorder();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:as:qualityWorkorder:view")
	@RequestMapping(value = {"list", ""})
	public String list(QualityWorkorder qualityWorkorder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QualityWorkorder> page = qualityWorkorderService.findPage(new Page<QualityWorkorder>(request, response), qualityWorkorder); 
		model.addAttribute("page", page);
		return "modules/ser/as/qualityWorkorderList";
	}
	/**
	 * 处理未处理的质检客服单
	 * @param qualityWorkorder
	 * @param model
	 * @return
	 */
	@RequiresPermissions("ser:as:qualityWorkorder:view")
	@RequestMapping(value = "form")
	public String form(QualityWorkorder qualityWorkorder, Model model) {
		QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
		qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
		qualityWorkorder.setQualityWorkordProductList(qualityWorkordProductService.findListByQualityWorkorderId(qualityWorkordProduct));
		model.addAttribute("qualityWorkorder", qualityWorkorder);
		return "modules/ser/as/qualityWorkorderForm";
	}

	@RequiresPermissions("ser:as:qualityWorkorder:edit")
	@RequestMapping(value = "save")
	public String save(QualityWorkorder qualityWorkorder, Model model, RedirectAttributes redirectAttributes) {
		try {
		qualityWorkorderService.updateOrder(qualityWorkorder);
		addMessage(redirectAttributes, "保存质检工单列表成功");
		} catch (ServiceException se) {//无可用快递单号给予的提醒
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkorder/?repage";
	}
	
	@RequiresPermissions("ser:as:qualityWorkorder:edit")
	@RequestMapping(value = "delete")
	public String delete(QualityWorkorder qualityWorkorder, RedirectAttributes redirectAttributes) {
		qualityWorkorderService.delete(qualityWorkorder);
		addMessage(redirectAttributes, "删除质检工单列表成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkorder/?repage";
	}

    @RequiresPermissions("ser:as:qualityWorkorder:view")
    @RequestMapping(value = "info")
    public String info(QualityWorkorder qualityWorkorder, Model model) {
		QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
		qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
		qualityWorkorder.setQualityWorkordProductList(qualityWorkordProductService.findListByQualityWorkorderId(qualityWorkordProduct));
		model.addAttribute("qualityWorkorder", qualityWorkorder);
        return "modules/ser/as/qualityWorkorderInfo";
    }
	/**
	 * 审核已处理的质检客服单
	 * @param qualityWorkorder
	 * @param model
	 * @return
	 */
	@RequiresPermissions("ser:as:qualityWorkorder:approve")
	@RequestMapping(value = "toApprove")
	public String toApprove(QualityWorkorder qualityWorkorder, Model model, RedirectAttributes redirectAttributes) {
		QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
		qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
		qualityWorkorder.setQualityWorkordProductList(qualityWorkordProductService.findListByQualityWorkorderId(qualityWorkordProduct));
		model.addAttribute("qualityWorkorder", qualityWorkorder);
		return "modules/ser/as/qualityWorkorderApprove";
	}

	@RequiresPermissions("ser:as:qualityWorkorder:approve")
	@RequestMapping(value = "approve")
	public String approve(QualityWorkorder qualityWorkorder, Model model, RedirectAttributes redirectAttributes) {
		try {
			qualityWorkorderService.approve(qualityWorkorder);
			addMessage(redirectAttributes, "质检工单审核成功");
		} catch (ServiceException se) {//无可用快递单号给予的提醒
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkorder/?repage";
	}
	@RequiresPermissions("ser:as:qualityWorkorder:approve")
	@RequestMapping(value = "refuse")
	public String refuse(QualityWorkorder qualityWorkorder, Model model, RedirectAttributes redirectAttributes) {
		qualityWorkorderService.refuse(qualityWorkorder);
		addMessage(redirectAttributes, "质检工单已拒绝");
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkorder/?repage";
	}
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = {"getRateBreak"})
	public BreakdownStandard getRateBreak(String breakdownType , HttpServletRequest request, HttpServletResponse response) {
		BreakdownStandard breakdownStandard=breakdownStandardDao.getByType(breakdownType);
		if(breakdownStandard == null)breakdownStandard=new BreakdownStandard();
		return breakdownStandard;
	}
}