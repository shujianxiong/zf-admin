/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.se;

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
import com.chinazhoufan.admin.modules.idx.entity.se.SeSearchRecord;
import com.chinazhoufan.admin.modules.idx.service.se.SeSearchRecordService;

/**
 * 搜索记录表Controller
 * @author liut
 * @version 2016-10-27
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/se/seSearchRecord")
public class SeSearchRecordController extends BaseController {

	@Autowired
	private SeSearchRecordService seSearchRecordService;
	
	@ModelAttribute
	public SeSearchRecord get(@RequestParam(required=false) String id) {
		SeSearchRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = seSearchRecordService.get(id);
		}
		if (entity == null){
			entity = new SeSearchRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:se:seSearchRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(SeSearchRecord seSearchRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SeSearchRecord> page = seSearchRecordService.findPage(new Page<SeSearchRecord>(request, response), seSearchRecord); 
		model.addAttribute("page", page);
		return "modules/idx/se/seSearchRecordList";
	}

	@RequiresPermissions("idx:se:seSearchRecord:view")
	@RequestMapping(value = "form")
	public String form(SeSearchRecord seSearchRecord, Model model) {
		//这里默认为场景
		if(StringUtils.isBlank(seSearchRecord.getId())) {
			seSearchRecord.setType(SeSearchRecord.TYPE_SCENE);
		}
		model.addAttribute("seSearchRecord", seSearchRecord);
		return "modules/idx/se/seSearchRecordForm";
	}

	@RequiresPermissions("idx:se:seSearchRecord:edit")
	@RequestMapping(value = "save")
	public String save(SeSearchRecord seSearchRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, seSearchRecord)){
			return form(seSearchRecord, model);
		}
		seSearchRecordService.save(seSearchRecord);
		addMessage(redirectAttributes, "保存搜索记录成功");
		return "redirect:"+Global.getAdminPath()+"/idx/se/seSearchRecord/?repage";
	}
	
	@RequiresPermissions("idx:se:seSearchRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(SeSearchRecord seSearchRecord, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(seSearchRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的搜索记录信息！");
			return "error/400";
		}
		seSearchRecordService.delete(seSearchRecord);
		addMessage(redirectAttributes, "删除搜索记录成功");
		return "redirect:"+Global.getAdminPath()+"/idx/se/seSearchRecord/?repage";
	}

    @RequiresPermissions("idx:se:seSearchRecord:view")
    @RequestMapping(value = "info")
    public String info(SeSearchRecord seSearchRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
    	if(StringUtils.isBlank(seSearchRecord.getId())) {
    		addMessage(model, "友情提示：未能获取到要查看的搜索记录信息！");
    		return "error/400";
    	}
        model.addAttribute("seSearchRecord", seSearchRecord);
        return "modules/idx/se/seSearchRecordInfo";
    }
}