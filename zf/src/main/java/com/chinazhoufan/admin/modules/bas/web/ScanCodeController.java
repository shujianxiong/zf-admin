/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 扫描电子码Controller
 * @author 张金俊
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/scanCode")
public class ScanCodeController extends BaseController {

	@Autowired
	private ScanCodeService scanCodeService;
	
	@ModelAttribute
	public ScanCode get(@RequestParam(required=false) String id) {
		ScanCode entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = scanCodeService.get(id);
		}
		if (entity == null){
			entity = new ScanCode();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:scanCode:view")
	@RequestMapping(value = {"list", ""})
	public String list(ScanCode scanCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ScanCode> page = scanCodeService.findPage(new Page<ScanCode>(request, response), scanCode); 
		model.addAttribute("page", page);
		return "modules/bas/scanCodeList";
	}

	@RequiresPermissions("bas:scanCode:view")
	@RequestMapping(value = "form")
	public String form(ScanCode scanCode, Model model) {
		model.addAttribute("scanCode", scanCode);
		return "modules/bas/scanCodeForm";
	}

	@RequiresPermissions("bas:scanCode:edit")
	@RequestMapping(value = "save")
	public String save(ScanCode scanCode, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, scanCode)){
			return form(scanCode, model);
		}
		scanCodeService.save(scanCode);
		addMessage(redirectAttributes, "保存扫描电子码成功");
		return "redirect:"+Global.getAdminPath()+"/bas/scanCode/?repage";
	}
	
	@RequiresPermissions("bas:scanCode:edit")
	@RequestMapping(value = "delete")
	public String delete(ScanCode scanCode, RedirectAttributes redirectAttributes) {
		scanCodeService.delete(scanCode);
		addMessage(redirectAttributes, "删除扫描电子码成功");
		return "redirect:"+Global.getAdminPath()+"/bas/scanCode/?repage";
	}

    @RequiresPermissions("bas:scanCode:view")
    @RequestMapping(value = "info")
    public String info(ScanCode scanCode, Model model) {
        model.addAttribute("scanCode", scanCode);
        return "modules/bas/scanCodeInfo";
    }
    
    /**
     * 自动增量，生成货品电子码
     * @param targetNum
     * @param response
     * @return
     */
    @ResponseBody
    @RequiresPermissions("bas:scanCode:view")
    @RequestMapping(value = "addProductScanCode")
    public String addProductScanCode(int targetNum, HttpServletResponse response) {
    	String codeStr = scanCodeService.addProductScanCode(targetNum);
    	Echos echo = new Echos(1, codeStr);
    	return JsonMapper.toJsonString(echo);
    }
    
    
    
    
}