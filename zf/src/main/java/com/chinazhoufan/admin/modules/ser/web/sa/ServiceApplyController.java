/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.sa;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
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
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;

/**
 * 服务申请Controller
 * @author 张金俊
 * @version 2017-08-14
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/sa/serviceApply")
public class ServiceApplyController extends BaseController {

	@Autowired
	private ServiceApplyService serviceApplyService;

	@Autowired
	private MemberService memberService;
	
	@ModelAttribute
	public ServiceApply get(@RequestParam(required=false) String id) {
		ServiceApply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = serviceApplyService.get(id);
		}
		if (entity == null){
			entity = new ServiceApply();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:sa:serviceApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(ServiceApply serviceApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isNotEmpty(serviceApply.getMembercode())){
			Member member = memberService.getByUsercode(serviceApply.getMembercode());
			if(member != null){
				serviceApply.setApplyById(member.getId());
			}
		}
		Page<ServiceApply> page = serviceApplyService.findPage(new Page<ServiceApply>(request, response), serviceApply);
		model.addAttribute("page", page);
		return "modules/ser/sa/serviceApplyList";
	}

	@RequiresPermissions("ser:sa:serviceApply:view")
	@RequestMapping(value = "form")
	public String form(ServiceApply serviceApply, Model model) {
		serviceApplyService.getExperienceOrder(serviceApply);
		serviceApplyService.getMemBus(serviceApply);
		//Produce produce = serviceApplyService.findProduceByOrderProduceId(serviceApply.getOrderProduceId());
		//model.addAttribute("produce", produce);
		serviceApplyService.getProduce(serviceApply);
		model.addAttribute("serviceApply", serviceApply);
		return "modules/ser/sa/serviceApplyForm";
	}

	@RequiresPermissions("ser:sa:serviceApply:edit")
	@RequestMapping(value = "save")
	public String save(ServiceApply serviceApply, Model model, RedirectAttributes redirectAttributes) {
		try {
		serviceApplyService.orderPass(serviceApply);
		addMessage(redirectAttributes, "保存服务申请成功");
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.toString());
			addMessage(redirectAttributes, "保存服务申请失败");
		}
		return "redirect:"+Global.getAdminPath()+"/ser/sa/serviceApply/?repage";
	}
	
	@RequiresPermissions("ser:sa:serviceApply:edit")
	@RequestMapping(value = "delete")
	public String delete(ServiceApply serviceApply, RedirectAttributes redirectAttributes) {
		serviceApplyService.delete(serviceApply);
		addMessage(redirectAttributes, "删除服务申请成功");
		return "redirect:"+Global.getAdminPath()+"/ser/sa/serviceApply/?repage";
	}

    @RequiresPermissions("ser:sa:serviceApply:view")
    @RequestMapping(value = "info")
    public String info(ServiceApply serviceApply, Model model) {
		Produce produce = serviceApplyService.findProduceByOrderProduceId(serviceApply.getOrderProduceId());
		model.addAttribute("produce", produce);
		model.addAttribute("serviceApply", serviceApply);
        return "modules/ser/sa/serviceApplyInfo";
    }
	@RequiresPermissions("ser:sa:serviceApply:edit")
	@RequestMapping(value = "refuse")
	public String refuse(ServiceApply serviceApply, RedirectAttributes redirectAttributes) throws ServiceException, IOException {
		try {
			serviceApplyService.refuse(serviceApply);
			addMessage(redirectAttributes, "保存服务申请成功");
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.toString());
			addMessage(redirectAttributes, "保存服务申请失败");
		}
		return "redirect:"+Global.getAdminPath()+"/ser/sa/serviceApply/?repage";
	}
}