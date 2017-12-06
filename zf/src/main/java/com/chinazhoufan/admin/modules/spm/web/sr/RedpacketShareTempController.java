/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.sr;

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
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.sr.RedpacketShareTemp;
import com.chinazhoufan.admin.modules.spm.service.sr.RedpacketShareTempService;

/**
 * 红包分享模板Controller
 * @author 刘晓东
 * @version 2015-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/sr/redpacketShareTemp")
public class RedpacketShareTempController extends BaseController {

	@Autowired
	private RedpacketShareTempService redpacketShareTempService;
//	@Autowired
//	private RedpacketShareTempDao redpacketShareTempDao;
	
	@ModelAttribute
	public RedpacketShareTemp get(@RequestParam(required=false) String id) {
		RedpacketShareTemp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = redpacketShareTempService.get(id);
		}
		if (entity == null){
			entity = new RedpacketShareTemp();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:sr:redpacketShareTemp:view")
	@RequestMapping(value = {"list", ""})
	public String list(RedpacketShareTemp redpacketShareTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RedpacketShareTemp> page = redpacketShareTempService.findPage(new Page<RedpacketShareTemp>(request, response), redpacketShareTemp); 
		model.addAttribute("page", page);
		return "modules/spm/sr/redpacketShareTempList";
	}

	@RequiresPermissions("spm:sr:redpacketShareTemp:view")
	@RequestMapping(value = "form")
	public String form(RedpacketShareTemp redpacketShareTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
//		/**
//		 * 模板使用状态不为新建时，不能修改
//		 */
//		RedpacketShareTemp redpacketShareTempOld = redpacketShareTempService.get(redpacketShareTemp.getId());
//		if (!StringUtils.isBlank(redpacketShareTemp.getId())) {
//			if (!redpacketShareTempOld.getTempStatus().equals(RedpacketShareTemp.AMOUNTTYPE_NEW)) {
//				addMessage(model, "模板状态为新建时才能修改");
//				return list(redpacketShareTemp, request, response, model);
//			}
//		}
		model.addAttribute("redpacketShareTemp", redpacketShareTemp);
		return "modules/spm/sr/redpacketShareTempForm";
	}

	@RequiresPermissions("spm:sr:redpacketShareTemp:edit")
	@RequestMapping(value = "edit")
	public String edit(RedpacketShareTemp redpacketShareTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		/**
		 * 模板使用状态不为新建时，不能修改
		 */
		RedpacketShareTemp redpacketShareTempOld = redpacketShareTempService.get(redpacketShareTemp.getId());
		if (!StringUtils.isBlank(redpacketShareTemp.getId())) {
			if (!redpacketShareTempOld.getTempStatus().equals(RedpacketShareTemp.AMOUNTTYPE_NEW)) {
				addMessage(model, "模板状态为新建时才能修改");
				return list(redpacketShareTemp, request, response, model);
			}
		}
		model.addAttribute("redpacketShareTemp", redpacketShareTempOld);
		return "modules/spm/sr/redpacketShareTempEdit";
	}
	
	@RequiresPermissions("spm:sr:redpacketShareTemp:view")
	@RequestMapping(value = "info")
	public String info(RedpacketShareTemp redpacketShareTemp ,HttpServletRequest request, HttpServletResponse response, Model model) {
		if(redpacketShareTemp == null || StringUtils.isBlank(redpacketShareTemp.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的红包分享模板信息！");
			return "error/400";
		}
		
		model.addAttribute("redpacketShareTemp", redpacketShareTemp);
		return "modules/spm/sr/redpacketShareTempInfo";
	}
	
	@RequiresPermissions("spm:sr:redpacketShareTemp:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(RedpacketShareTemp redpacketShareTemp ,String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (redpacketShareTemp == null || StringUtils.isBlank(redpacketShareTemp.getId())) {
			addMessage(model, "友情提示：未能获取到红包模板信息");
			return "error/400";
		}
		
		if(StringUtils.isBlank(status)){
			addMessage(model, "友情提示：未能获取到红包模板状态信息");
			return "error/400";
		}
		
		RedpacketShareTemp redpacketShareTempOld = redpacketShareTempService.get(redpacketShareTemp.getId());
		
		//启用
		if (RedpacketShareTemp.AMOUNTTYPE_ENABLE.equals(status)) {
			
			//判断该模板是否已启用
			if (redpacketShareTempOld.getTempStatus().equals(RedpacketShareTemp.AMOUNTTYPE_ENABLE)) {
				addMessage(model, "该模板已经启用");
				return list(redpacketShareTemp, request, response, model);
			}
			//查询是否有启用的
			int cnt = redpacketShareTempService.enable(redpacketShareTemp);
			redpacketShareTempOld.setTempStatus(status);
			redpacketShareTempService.update(redpacketShareTempOld);
			if (cnt == 0) {
				addMessage(model, "已启用");
			}else {
				addMessage(model, "启用成功,并已自动关闭旧模板");
			}
			return list(redpacketShareTemp, request, response, model);
		}
		//停用
		else if (RedpacketShareTemp.AMOUNTTYPE_DISABLED.equals(status)) {
			redpacketShareTempOld.setTempStatus(status);
			redpacketShareTempService.update(redpacketShareTempOld);
			addMessage(model, "已停用");
			return list(redpacketShareTemp, request, response, model);
		}
		addMessage(model, "操作失败");
		return list(redpacketShareTemp, request, response, model);
	}
	
	@RequiresPermissions("spm:sr:redpacketShareTemp:edit")
	@RequestMapping(value = "save")
	public String save(RedpacketShareTemp redpacketShareTemp, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, redpacketShareTemp)){
			return form(redpacketShareTemp, request, response, model);
		}
		/**
		 * 1.活动启用时间不得大于当前时间
		 */
		int n = DateUtils.compare_date(redpacketShareTemp.getRedpacketStartTime());
		if (n >= 0) {
			addMessage(model, "活动启用时间不得大于当前时间");
			return form(redpacketShareTemp, request, response, model);
		}
		/**
		 * 2.金额类型为固定时，红包金额、最大金额和最小金额应相等
		 *   金额类型为随机时，红包金额、最大金额和最小金额应满足   最大金额 >= 红包金额 >= 最小金额
		 */
		String amountType = redpacketShareTemp.getAmountType();
		//金额类型为固定
		if (amountType.equals(RedpacketShareTemp.AMOUNT_NUM_TYPE_STABLE)) {
			if (!(redpacketShareTemp.getAmount().compareTo(redpacketShareTemp.getMaxAmount()) == 0 &&redpacketShareTemp.getAmount().compareTo(redpacketShareTemp.getMinAmount()) == 0)) {
				addMessage(model, "金额类型为固定时，红包金额、最大金额和最小金额应相等");
				return form(redpacketShareTemp, request, response, model);
			}
		}else {
			if ( redpacketShareTemp.getMaxAmount().compareTo(redpacketShareTemp.getAmount()) < 0){
				addMessage(model, "最大红包金额不得低于红包金额");
				return form(redpacketShareTemp, request, response, model);
			}else if (redpacketShareTemp.getAmount().compareTo(redpacketShareTemp.getMinAmount()) < 0) {
				addMessage(model, "红包金额不得低于最小红包金额");
				return form(redpacketShareTemp, request, response, model);
			}
		}
		/**
		 * 3.数量类型为固定时，红包数量、最大数量和最小数量应相等
		 *   数量类型为随机时，红包数量、最大数量和最小数量应满足   最大数量 >= 红包数量>= 最小数量
		 */
		String numType = redpacketShareTemp.getNumType();
		//数量类型为固定
		if (numType.equals(RedpacketShareTemp.AMOUNT_NUM_TYPE_STABLE)) {
			if (!(redpacketShareTemp.getNum().compareTo(redpacketShareTemp.getMaxNum()) == 0 &&redpacketShareTemp.getNum().compareTo(redpacketShareTemp.getMinNum()) == 0)) {
				addMessage(model, "数量类型为固定时，红包数量、最大数量和最小数量金额应相等");
				return form(redpacketShareTemp, request, response, model);
			}
		}else {
			if (redpacketShareTemp.getMaxNum().compareTo(redpacketShareTemp.getNum()) < 0){
				addMessage(model, "最大数量不得低于最小数量");
				return form(redpacketShareTemp, request, response, model);
			}else if (redpacketShareTemp.getNum().compareTo(redpacketShareTemp.getMinNum()) < 0 ) {
				addMessage(model, "红包数量不得低于最小数量");
				return form(redpacketShareTemp, request, response, model);
			}
		}
		redpacketShareTempService.save(redpacketShareTemp);
		addMessage(redirectAttributes, "保存红包分享模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/sr/redpacketShareTemp/?repage";
	}
	
	@RequiresPermissions("spm:sr:redpacketShareTemp:edit")
	@RequestMapping(value = "delete")
	public String delete(RedpacketShareTemp redpacketShareTemp, RedirectAttributes redirectAttributes) {
		if(redpacketShareTemp == null || StringUtils.isBlank(redpacketShareTemp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的红包分享模板信息！");
			return "error/400";
		}
		
		redpacketShareTempService.delete(redpacketShareTemp);
		addMessage(redirectAttributes, "删除红包分享模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/sr/redpacketShareTemp/?repage";
	}

}