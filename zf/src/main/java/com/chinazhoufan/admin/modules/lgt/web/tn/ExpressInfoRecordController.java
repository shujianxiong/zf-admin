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
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressInfoRecord;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressInfoRecordService;

/**
 * 快递信息记录Controller
 * @author liuxiaodong
 * @version 2017-11-04
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/tn/expressInfoRecord")
public class ExpressInfoRecordController extends BaseController {

	@Autowired
	private ExpressInfoRecordService expressInfoRecordService;
	
	@ModelAttribute
	public ExpressInfoRecord get(@RequestParam(required=false) String id) {
		ExpressInfoRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = expressInfoRecordService.get(id);
		}
		if (entity == null){
			entity = new ExpressInfoRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:tn:expressInfoRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExpressInfoRecord expressInfoRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExpressInfoRecord> page = expressInfoRecordService.findPage(new Page<ExpressInfoRecord>(request, response), expressInfoRecord); 
		model.addAttribute("page", page);
		return "modules/lgt/tn/expressInfoRecordList";
	}

	@RequiresPermissions("lgt:tn:expressInfoRecord:view")
	@RequestMapping(value = "form")
	public String form(ExpressInfoRecord expressInfoRecord, Model model) {
		model.addAttribute("expressInfoRecord", expressInfoRecord);
		return "modules/lgt/tn/expressInfoRecordForm";
	}


    @RequiresPermissions("lgt:tn:expressInfoRecord:view")
    @RequestMapping(value = "info")
    public String info(ExpressInfoRecord expressInfoRecord, Model model) {
        model.addAttribute("expressInfoRecord", expressInfoRecord);
        return "modules/lgt/tn/expressInfoRecordInfo";
    }
}