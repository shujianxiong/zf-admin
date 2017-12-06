/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web.code;

import java.util.List;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.dao.code.CodeGeneratorDao;
import com.chinazhoufan.admin.modules.bas.entity.code.CodeGenerator;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.google.common.collect.Lists;

/**
 * 业务编码生成器Controller
 * @author 贾斌
 * @version 2015-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/code/codeGenerator")
public class CodeGeneratorController extends BaseController {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	public CodeGeneratorDao codeGeneratorDao;
	
	@ModelAttribute
	public CodeGenerator get(@RequestParam(required=false) String id) {
		CodeGenerator entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = codeGeneratorService.get(id);
		}
		if (entity == null){
			entity = new CodeGenerator();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:code:codeGenerator:view")
	@RequestMapping(value = {"list", ""})
	public String list(CodeGenerator codeGenerator, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CodeGenerator> page = codeGeneratorService.findPage(new Page<CodeGenerator>(request, response), codeGenerator); 
		model.addAttribute("page", page);
		return "modules/bas/code/codeGeneratorList";
	}

	/**
	 * 自动补全功能
	 */
	@RequestMapping(value = "autoTip")
	public @ResponseBody String autoTip(String keyWorld){
		CodeGenerator genCode = new CodeGenerator();
		genCode.setCodeHandle(keyWorld);
		List<CodeGenerator> list = codeGeneratorService.findList(genCode); 
		List<String> tipList = Lists.newArrayList();
		for(CodeGenerator code : list){
			tipList.add(code.getCodeHandle());
		}
		return JsonMapper.toJsonString(tipList);
	}
	
	@RequiresPermissions("bas:code:codeGenerator:view")
	@RequestMapping(value = "form")
	public String form(CodeGenerator codeGenerator, Model model) {
		model.addAttribute("codeGenerator", codeGenerator);
		return "modules/bas/code/codeGeneratorForm";
	}
	
	@RequiresPermissions("bas:code:codeGenerator:view")
	@RequestMapping(value = "info")
	public String info(CodeGenerator codeGenerator, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(codeGenerator.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的编码生成策略！");
			return "error/400";
		}
		model.addAttribute("codeGenerator", codeGenerator);
		return "modules/bas/code/codeGeneratorInfo";
	}

	@RequiresPermissions("bas:code:codeGenerator:edit")
	@RequestMapping(value = "save")
	public String save(CodeGenerator codeGenerator, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, codeGenerator)){
			return form(codeGenerator, model);
		}
		List<CodeGenerator> codeGenerators = codeGeneratorDao.findCodeHandleList(codeGenerator);//判断该编码代码，编码名称是否已经存在
		if(StringUtils.isNotBlank(codeGenerator.getId())){
			if(codeGenerators.size() > 1){//修改 数值大于1 表示该数据已经存在,如果等于1表示是本身通过
				addMessage(model, "【"+codeGenerator.getCodeName()+"】或【"+codeGenerator.getCodeHandle()+"】该数据已存在,请重新录入");
				return form(codeGenerator, model);
			}
		}else{
			if(codeGenerators.size() == 1){//添加 等于1 表示该数据已经存在 提示
				addMessage(model, "【"+codeGenerator.getCodeName()+"】或【"+codeGenerator.getCodeHandle()+"】该数据已存在,请重新录入");
				return form(codeGenerator, model);
			}
		}
		codeGeneratorService.save(codeGenerator);
		addMessage(redirectAttributes, "保存业务编码生成器成功");
		return "redirect:"+Global.getAdminPath()+"/bas/code/codeGenerator/?repage";
	}
	
	@RequiresPermissions("bas:code:codeGenerator:edit")
	@RequestMapping(value = "delete")
	public String delete(CodeGenerator codeGenerator, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(codeGenerator.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的编码生成策略信息！");
			return "error/400";
		}
		codeGeneratorService.delete(codeGenerator);
		addMessage(redirectAttributes, "删除业务编码生成器成功");
		return "redirect:"+Global.getAdminPath()+"/bas/code/codeGenerator/?repage";
	}
	
	@RequiresPermissions("bas:code:codeGenerator:edit")
	@RequestMapping(value = "test")
	public String test(CodeGenerator codeGenerator, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		CodeGenerator entity = codeGeneratorService.get(codeGenerator.getId());
		String code = codeGeneratorService.generateCode(entity.getCodeHandle());//生成编号
		addMessage(redirectAttributes, "业务编码生成器生成成功【"+code+"】");
		redirectAttributes.addAttribute("codeHandle", codeGenerator.getCodeHandle());
		redirectAttributes.addAttribute("dateType", codeGenerator.getDateType());
		return "redirect:"+Global.getAdminPath()+"/bas/code/codeGenerator/?repage";
	}
	
}