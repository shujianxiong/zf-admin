/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.tn;

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
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressAppointRecord;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressAppointRecordService;

/**
 * 快递预约记录Controller
 * @author liut
 * @version 2017-05-24
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/tn/expressAppointRecord")
public class ExpressAppointRecordController extends BaseController {

	@Autowired
	private ExpressAppointRecordService expressAppointRecordService;
	
	@ModelAttribute
	public ExpressAppointRecord get(@RequestParam(required=false) String id) {
		ExpressAppointRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = expressAppointRecordService.get(id);
		}
		if (entity == null){
			entity = new ExpressAppointRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:tn:expressAppointRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExpressAppointRecord expressAppointRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExpressAppointRecord> page = expressAppointRecordService.findPage(new Page<ExpressAppointRecord>(request, response), expressAppointRecord); 
		model.addAttribute("page", page);
		return "modules/lgt/tn/expressAppointRecordList";
	}

	@RequiresPermissions("lgt:tn:expressAppointRecord:view")
	@RequestMapping(value = "form")
	public String form(ExpressAppointRecord expressAppointRecord, Model model) {
		model.addAttribute("expressAppointRecord", expressAppointRecord);
		return "modules/lgt/tn/expressAppointRecordForm";
	}

	@RequiresPermissions("lgt:tn:expressAppointRecord:edit")
	@RequestMapping(value = "save")
	public String save(ExpressAppointRecord expressAppointRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, expressAppointRecord)){
			return form(expressAppointRecord, model);
		}
		expressAppointRecordService.save(expressAppointRecord);
		addMessage(redirectAttributes, "保存快递预约记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tn/expressAppointRecord/?repage";
	}
	
	@RequiresPermissions("lgt:tn:expressAppointRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(ExpressAppointRecord expressAppointRecord, RedirectAttributes redirectAttributes) {
		expressAppointRecordService.delete(expressAppointRecord);
		addMessage(redirectAttributes, "删除快递预约记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tn/expressAppointRecord/?repage";
	}

    @RequiresPermissions("lgt:tn:expressAppointRecord:view")
    @RequestMapping(value = "info")
    public String info(ExpressAppointRecord expressAppointRecord, Model model) {
        model.addAttribute("expressAppointRecord", expressAppointRecord);
        return "modules/lgt/tn/expressAppointRecordInfo";
    }
    
    /**
     * 变更快递预约状态
     * @param expressAppointRecord
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("lgt:tn:expressAppointRecord:edit")
    @RequestMapping(value = "updateStatus")
    public String updateFlag(ExpressAppointRecord expressAppointRecord, RedirectAttributes redirectAttributes) {
    	expressAppointRecord.setStatus(ExpressAppointRecord.CUSTOMER_STATUS_NO.equals(expressAppointRecord.getStatus()) ? ExpressAppointRecord.CUSTOMER_STATUS_OK : expressAppointRecord.getStatus());
    	expressAppointRecordService.save(expressAppointRecord);
		addMessage(redirectAttributes, "变更快递预约状态成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tn/expressAppointRecord/?repage";
    }
    
    
    
    
}