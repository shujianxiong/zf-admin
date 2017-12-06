/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web.pv;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.excel.ExportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.pv.PvRecord;
import com.chinazhoufan.admin.modules.bas.service.pv.PvRecordService;
import com.chinazhoufan.admin.modules.bas.service.pv.PvRecordStat;

/**
 * 页面访问记录Controller
 * @author liut
 * @version 2017-03-03
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/pv/pvRecord")
public class PvRecordController extends BaseController {

	@Autowired
	private PvRecordService pvRecordService;
	
	@ModelAttribute
	public PvRecord get(@RequestParam(required=false) String id) {
		PvRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pvRecordService.get(id);
		}
		if (entity == null){
			entity = new PvRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:pv:pvRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(PvRecord pvRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PvRecord> page = pvRecordService.findPage(new Page<PvRecord>(request, response), pvRecord); 
		model.addAttribute("page", page);
		return "modules/bas/pv/pvRecordList";
	}
	
	/**
	 *  根据页面类型统计浏览量
	 * @param pvRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("bas:pv:pvRecord:view")
	@RequestMapping(value = "statPageViewByPageType")
	public String statPageViewByPageType(PvRecord pvRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<PvRecord> list = pvRecordService.statPageViewByPageType(pvRecord);
		model.addAttribute("list", list);
		return "modules/bas/pv/pvRecordStat";
	}

	@RequiresPermissions("bas:pv:pvRecord:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
	public String exportStatByPageType(PvRecord pvRecord, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "页面访问量统计数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            List<PvRecord> list = pvRecordService.statPageViewByPageType(pvRecord);
    		new ExportExcel("页面访问量统计数据", PvRecord.class).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出页面访问量统计数据失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/bas/pv/pvRecord/statPageViewByPageType?repage";
	}
	
	
	/**
	 * 绘制饼状图
	 * @param pvRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@ResponseBody
	@RequiresPermissions("bas:pv:pvRecord:view")
	@RequestMapping(value = "drawPageViewByPageType", method=RequestMethod.POST)
	public String drawPageViewByPageType(PvRecord pvRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<PvRecordStat> list = pvRecordService.drawPageViewByPageType(pvRecord);
		return JsonMapper.toJsonString(list);
	}
	
	
	@RequiresPermissions("bas:pv:pvRecord:view")
	@RequestMapping(value = "form")
	public String form(PvRecord pvRecord, Model model) {
		model.addAttribute("pvRecord", pvRecord);
		return "modules/bas/pv/pvRecordForm";
	}

	@RequiresPermissions("bas:pv:pvRecord:edit")
	@RequestMapping(value = "save")
	public String save(PvRecord pvRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pvRecord)){
			return form(pvRecord, model);
		}
		pvRecordService.save(pvRecord);
		addMessage(redirectAttributes, "保存页面访问记录成功");
		return "redirect:"+Global.getAdminPath()+"/bas/pv/pvRecord/?repage";
	}
	
	@RequiresPermissions("bas:pv:pvRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(PvRecord pvRecord, RedirectAttributes redirectAttributes) {
		pvRecordService.delete(pvRecord);
		addMessage(redirectAttributes, "删除页面访问记录成功");
		return "redirect:"+Global.getAdminPath()+"/bas/pv/pvRecord/?repage";
	}

    @RequiresPermissions("bas:pv:pvRecord:view")
    @RequestMapping(value = "info")
    public String info(PvRecord pvRecord, Model model) {
        model.addAttribute("pvRecord", pvRecord);
        return "modules/bas/pv/pvRecordInfo";
    }
}