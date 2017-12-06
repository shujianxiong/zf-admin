/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.sw;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
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
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.idx.entity.sw.StarsWear;
import com.chinazhoufan.admin.modules.idx.service.sw.StarsWearService;

/**
 * 明星穿搭Controller
 * @author 张金俊
 * @version 2017-07-31
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/sw/starsWear")
public class StarsWearController extends BaseController {

	@Autowired
	private StarsWearService starsWearService;
	
	@ModelAttribute
	public StarsWear get(@RequestParam(required=false) String id) {
		StarsWear entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = starsWearService.get(id);
		}
		if (entity == null){
			entity = new StarsWear();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:sw:starsWear:view")
	@RequestMapping(value = {"list", ""})
	public String list(StarsWear starsWear, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StarsWear> page = starsWearService.findPage(new Page<StarsWear>(request, response), starsWear); 
		model.addAttribute("page", page);
		return "modules/idx/sw/starsWearList";
	}

	@RequiresPermissions("idx:sw:starsWear:view")
	@RequestMapping(value = "form")
	public String form(StarsWear starsWear, Model model) {
		//设置启用默认值
		if(StringUtils.isBlank(starsWear.getUsableFlag())){
			starsWear.setUsableFlag(starsWear.FALSE_FLAG);
		}
		model.addAttribute("starsWear", starsWear);
		return "modules/idx/sw/starsWearForm";
	}

	@RequiresPermissions("idx:sw:starsWear:edit")
	@RequestMapping(value = "save")
	public String save(StarsWear starsWear, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, starsWear)){
			return form(starsWear, model);
		}
		starsWearService.save(starsWear);
		addMessage(redirectAttributes, "保存明星穿搭成功");
		return "redirect:"+Global.getAdminPath()+"/idx/sw/starsWear/?repage";
	}
	
	@RequiresPermissions("idx:sw:starsWear:edit")
	@RequestMapping(value = "delete")
	public String delete(StarsWear starsWear, RedirectAttributes redirectAttributes) {
		starsWearService.delete(starsWear);
		addMessage(redirectAttributes, "删除明星穿搭成功");
		return "redirect:"+Global.getAdminPath()+"/idx/sw/starsWear/?repage";
	}

    @RequiresPermissions("idx:sw:starsWear:view")
    @RequestMapping(value = "info")
    public String info(StarsWear starsWear, Model model) {
        model.addAttribute("starsWear", starsWear);
        return "modules/idx/sw/starsWearInfo";
    }

	/**
	 * 更新明星穿搭启用状态
	 * @param id
	 * @param usableFlag  操作类型，（启用=1， 停用=0）
	 * @param model
	 * @return
	 */
	@RequiresPermissions("idx:sw:starsWear:edit")
	@RequestMapping(value = "updateUsable")
	public String updateStatus(String id, String usableFlag, RedirectAttributes redirectAttributes, Model model) {

		Echos echo = null;
		//获取操作类型（启用=1， 停用=0）
		String returnUrl = Global.getAdminPath()+"/idx/sw/starsWear/?repage";
		if(StringUtils.isBlank(id)){
			addMessage(redirectAttributes, "明星穿搭启用状态变更失败：未获取到明星穿搭状态信息");
			return returnUrl;

		}

		//获取原有的明星穿搭状态参数信息
		StarsWear starsWearOld = starsWearService.get(id);
		//获取明星穿搭对应的状态信息
		if("0".equals(usableFlag)){
			starsWearOld.setUsableFlag(starsWearOld.FALSE_FLAG);
		}else if("1".equals(usableFlag)){
			starsWearOld.setUsableFlag(starsWearOld.TRUE_FLAG);
		}
		starsWearService.save(starsWearOld);
		addMessage(redirectAttributes, "明星穿搭状态操作成功");
		return "redirect:"+returnUrl;
	}
}