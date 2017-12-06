/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.tn;

import java.util.Date;

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
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressNoSegment;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressNoSegmentService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 快递单号段表Controller
 * @author liut
 * @version 2017-05-22
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/tn/expressNoSegment")
public class ExpressNoSegmentController extends BaseController {

	@Autowired
	private ExpressNoSegmentService expressNoSegmentService;
	
	@ModelAttribute
	public ExpressNoSegment get(@RequestParam(required=false) String id) {
		ExpressNoSegment entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = expressNoSegmentService.get(id);
		}
		if (entity == null){
			entity = new ExpressNoSegment();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:tn:expressNoSegment:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExpressNoSegment expressNoSegment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExpressNoSegment> page = expressNoSegmentService.findPage(new Page<ExpressNoSegment>(request, response), expressNoSegment); 
		model.addAttribute("page", page);
		return "modules/lgt/tn/expressNoSegmentList";
	}

	@RequiresPermissions("lgt:tn:expressNoSegment:view")
	@RequestMapping(value = "form")
	public String form(ExpressNoSegment expressNoSegment, Model model) {
		if(StringUtils.isBlank(expressNoSegment.getId())) {
			expressNoSegment.setExpressCompany(ExpressNoSegment.EXPRESS_COMPANY_ZJS);
		}
		model.addAttribute("expressNoSegment", expressNoSegment);
		return "modules/lgt/tn/expressNoSegmentForm";
	}

	@RequiresPermissions("lgt:tn:expressNoSegment:edit")
	@RequestMapping(value = "save")
	public String save(ExpressNoSegment expressNoSegment, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, expressNoSegment)){
			return form(expressNoSegment, model);
		}*/
		try {
			expressNoSegmentService.save(expressNoSegment);
			addMessage(redirectAttributes, "保存快递单号段成功");
		} catch (ServiceException e) {
			addMessage(redirectAttributes, e.getMessage());
		} 
		return "redirect:"+Global.getAdminPath()+"/lgt/tn/expressNoSegment/?repage";
	}
	
	@RequiresPermissions("lgt:tn:expressNoSegment:edit")
	@RequestMapping(value = "delete")
	public String delete(ExpressNoSegment expressNoSegment, RedirectAttributes redirectAttributes) {
		expressNoSegmentService.delete(expressNoSegment);
		addMessage(redirectAttributes, "删除快递单号段成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tn/expressNoSegment/?repage";
	}

    @RequiresPermissions("lgt:tn:expressNoSegment:view")
    @RequestMapping(value = "info")
    public String info(ExpressNoSegment expressNoSegment, Model model) {
        model.addAttribute("expressNoSegment", expressNoSegment);
        return "modules/lgt/tn/expressNoSegmentInfo";
    }
    
    @ResponseBody
    @RequiresPermissions("lgt:tn:expressNoSegment:edit")
	@RequestMapping(value = "updateStatusByExpressNo")
    public String updateStatusByExpressNo(ExpressNoSegment expressNoSegment, HttpServletRequest request, HttpServletResponse response) {
    	Echos echo = null;
    	try {
    		expressNoSegment.setUseTime(new Date());
    		expressNoSegment.setStatus(ExpressNoSegment.TRUE_FLAG);
    		expressNoSegment.setExpressCompany(ExpressNoSegment.EXPRESS_COMPANY_ZJS);
    		expressNoSegment.preUpdate();
			expressNoSegmentService.updateByExpressNo(expressNoSegment);
			echo = new Echos(1, "更新快递单号使用状态成功");
		} catch (Exception e) {
			echo = new Echos(0, "更新快递单号使用状态失败");
		}
    	return JsonMapper.toJsonString(echo);
    };
    
    
    
}