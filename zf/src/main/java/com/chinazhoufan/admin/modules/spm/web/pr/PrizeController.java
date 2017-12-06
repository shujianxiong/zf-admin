/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pr;

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
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;
import com.chinazhoufan.admin.modules.spm.service.pr.PrizeService;

/**
 * 奖品表Controller
 * @author liut
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pr/prize")
public class PrizeController extends BaseController {

	@Autowired
	private PrizeService prizeService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	
	@ModelAttribute
	public Prize get(@RequestParam(required=false) String id) {
		Prize entity = null;
		if (StringUtils.isNotBlank(id)){
//			entity = prizeService.get(id);
		}
		if (entity == null){
			entity = new Prize();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pr:prize:view")
	@RequestMapping(value = {"list", ""})
	public String list(Prize prize, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Prize> page = prizeService.findPage(new Page<Prize>(request, response), prize); 
		model.addAttribute("page", page);
		return "modules/spm/pr/prizeList";
	}

	@RequiresPermissions("spm:pr:prize:view")
	@RequestMapping(value = "form")
	public String form(Prize prize, Model model) {
		//自动生成奖品编码
		if(StringUtils.isBlank(prize.getId())) {
			prize.setCode(codeGeneratorService.generateCode(Prize.GENERATECODE_PRIZE));
			model.addAttribute("prize", prize);
		} else {
			Prize p = prizeService.get(prize);
			model.addAttribute("prize", p);
		}
		return "modules/spm/pr/prizeForm";
	}

	@RequiresPermissions("spm:pr:prize:edit")
	@RequestMapping(value = "save")
	public String save(Prize prize, Model model, RedirectAttributes redirectAttributes) {
		prize.setUsableNum(prize.getStockNum());
		if (!beanValidator(model, prize)){
			return form(prize, model);
		}
		//新建奖品时，奖品的状态为 新建，同时可用库存和库存数量保持一致
		if(StringUtils.isBlank(prize.getId())) {
			prize.setStatus(Prize.PRIZE_NEW);
		}
		prizeService.save(prize);
		addMessage(redirectAttributes, "保存奖品表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pr/prize/?repage";
	}
	
	@RequiresPermissions("spm:pr:prize:edit")
	@RequestMapping(value = "delete")
	public String delete(Prize prize, RedirectAttributes redirectAttributes) {
		if(prize  == null || StringUtils.isBlank(prize.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的奖品信息!");
			return "error/400";
		}
		
		prizeService.delete(prize);
		addMessage(redirectAttributes, "删除奖品表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pr/prize/?repage";
	}
	
	@RequiresPermissions("spm:pr:prize:view")
	@RequestMapping(value = "info")
	public String info(Prize prize, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(prize == null || StringUtils.isBlank(prize.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的奖品信息！");
			return "error/400";
		}
		Prize p = prizeService.get(prize);
		model.addAttribute("prize", p);
		return "modules/spm/pr/prizeInfo";
	}

	@RequiresPermissions("spm:pr:prize:edit")
	@RequestMapping(value = "changeFlag")
	public String changeFlag(Prize prize, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(prize == null || StringUtils.isBlank(prize.getId())) {
			addMessage(model, "友情提示：未能获取到有效的奖品信息！");
			return "error/400";
		}
		
		prizeService.changeFlag(prize);
		prize = new Prize();
		model.addAttribute("prize", prize);
		return list(prize, request, response, model);
	}
	
	@RequestMapping(value = "select")
	public String select(Prize prize, HttpServletRequest request, HttpServletResponse response, Model model) {
		prize.setStatus(Prize.PRIZE_UP);
		Page<Prize> page = prizeService.findPage(new Page<Prize>(request, response), prize); 
		model.addAttribute("page", page);
		return "modules/spm/pr/prizeSelect";
	}
	
}