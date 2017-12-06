/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.as;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

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
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import com.chinazhoufan.admin.modules.ser.service.as.WorkorderService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 售后工单Controller
 * @author liut
 * @version 2017-05-18
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/as/workorder")
public class WorkorderController extends BaseController {

	@Autowired
	private WorkorderService workorderService;
	
	@ModelAttribute
	public Workorder get(@RequestParam(required=false) String id) {
		Workorder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = workorderService.get(id);
		}
		if (entity == null){
			entity = new Workorder();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:as:workorder:view")
	@RequestMapping(value = {"list", ""})
	public String list(Workorder workorder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Workorder> page = workorderService.findPage(new Page<Workorder>(request, response), workorder); 
		model.addAttribute("page", page);
		return "modules/ser/as/workorderList";
	}
	
	
	/**
	 * 我的指派工单
	 * @param workorder
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("ser:as:workorder:view")
	@RequestMapping(value = "myCreateList")
	public String myCreateList(Workorder workorder, HttpServletRequest request, HttpServletResponse response, Model model) {
		workorder.setCreateBy(UserUtils.getUser());
		Page<Workorder> page = workorderService.findPage(new Page<Workorder>(request, response), workorder); 
		model.addAttribute("page", page);
		return "modules/ser/as/myCreateList";
	}
	
	
	/**
	 * 我的待处理工单
	 * @param workorder
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("ser:as:workorder:view")
	@RequestMapping(value = "myWaitDealList")
	public String myWaitDealList(Workorder workorder, HttpServletRequest request, HttpServletResponse response, Model model) {
		workorder.setAppointedUser(UserUtils.getUser());
		workorder.setWaitDealStatus(Workorder.WORKORDER_STATUS_FINISH);
		Page<Workorder> page = workorderService.findPage(new Page<Workorder>(request, response), workorder); 
		model.addAttribute("page", page);
		return "modules/ser/as/myWaitDealList";
	}
	

	@RequiresPermissions("ser:as:workorder:view")
	@RequestMapping(value = "form")
	public String form(Workorder workorder, Model model) {
		if(StringUtils.isBlank(workorder.getId())) {
			workorder.setStatus(Workorder.WORKORDER_STATUS_WAIT);
		}
		Calendar calendar   =   new GregorianCalendar();
		Date date=new   Date();//取当前时间
		calendar.setTime(date);//已过期重新计算时间
		calendar.add(calendar.DAY_OF_MONTH, -1);
		model.addAttribute("curDate", calendar.getTime());
		model.addAttribute("workorder", workorder);
		return "modules/ser/as/workorderForm";
	}

	@RequiresPermissions("ser:as:workorder:edit")
	@RequestMapping(value = "save")
	public String save(Workorder workorder, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, workorder)){
			return form(workorder, model);
		}*/
		workorderService.save(workorder);
		addMessage(redirectAttributes, "保存售后工单成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorder/myCreateList";
	}
	
	@RequiresPermissions("ser:as:workorder:edit")
	@RequestMapping(value = "delete")
	public String delete(Workorder workorder, RedirectAttributes redirectAttributes) {
		workorderService.delete(workorder);
		addMessage(redirectAttributes, "删除售后工单成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorder/?repage";
	}

    @RequiresPermissions("ser:as:workorder:view")
    @RequestMapping(value = "info")
    public String info(Workorder workorder, Model model) {
    	workorder = workorderService.find(workorder);
        model.addAttribute("workorder", workorder);
        return "modules/ser/as/workorderInfo";
    }
}