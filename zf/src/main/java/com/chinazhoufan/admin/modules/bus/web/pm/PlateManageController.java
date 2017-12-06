/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.pm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.PickOrderService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;
import com.chinazhoufan.admin.modules.bus.service.pm.PlateManageService;

import java.util.List;

/**
 * 托盘管理Controller
 * @author liuxiaodong
 * @version 2017-10-27
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/pm/plateManage")
public class PlateManageController extends BaseController {

	@Autowired
	private PlateManageService plateManageService;
	@Autowired
	private PickOrderService pickOrderService;
	
	@ModelAttribute
	public PlateManage get(@RequestParam(required=false) String id) {
		PlateManage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = plateManageService.get(id);

		}
		if (entity == null){
			entity = new PlateManage();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:pm:plateManage:view")
	@RequestMapping(value = {"list", ""})
	public String list(PlateManage plateManage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PlateManage> page = plateManageService.findPage(new Page<PlateManage>(request, response), plateManage); 
		model.addAttribute("page", page);
		return "modules/bus/pm/plateManageList";
	}

	@RequiresPermissions("bus:pm:plateManage:view")
	@RequestMapping(value = "form")
	public String form(PlateManage plateManage, Model model) {
		model.addAttribute("plateManage", plateManage);
		return "modules/bus/pm/plateManageForm";
	}

	@RequiresPermissions("bus:pm:plateManage:edit")
	@RequestMapping(value = "save")
	public String save(PlateManage plateManage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, plateManage)){
			return form(plateManage, model);
		}
		try {
            plateManageService.save(plateManage);
            addMessage(redirectAttributes, "保存托盘成功");
        } catch (Exception e){
		    addMessage(model, e.getMessage());
		    return form(plateManage, model);
        }
		return "redirect:"+Global.getAdminPath()+"/bus/pm/plateManage/?repage";
	}
	
	@RequiresPermissions("bus:pm:plateManage:edit")
	@RequestMapping(value = "delete")
	public String delete(PlateManage plateManage, RedirectAttributes redirectAttributes) {
		try {
			plateManageService.delete(plateManage);
			addMessage(redirectAttributes, "删除托盘成功");
		}catch (Exception e){
			addMessage(redirectAttributes, "操作失败，"+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/pm/plateManage/?repage";
	}

    @RequiresPermissions("bus:pm:plateManage:view")
    @RequestMapping(value = "info")
    public String info(PlateManage plateManage, Model model) {
        model.addAttribute("plateManage", plateManage);
        return "modules/bus/pm/plateManageInfo";
    }

	@RequiresPermissions("bus:pm:plateManage:edit")
	@RequestMapping(value = "updateFlag")
	public String updateFlag(PlateManage plateManage, RedirectAttributes redirectAttributes) {
		plateManage.setPlateStatus(PlateManage.TRUE_FLAG.equals(plateManage.getPlateStatus()) ? PlateManage.FALSE_FLAG : PlateManage.TRUE_FLAG);
		plateManageService.save(plateManage);
		addMessage(redirectAttributes, (PlateManage.TRUE_FLAG.equals(plateManage.getPlateStatus()) ? "启用" : "停用")+"托盘成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pm/plateManage/?repage";
	}


	@RequiresPermissions("bus:pm:plateManage:view")
	@RequestMapping(value = "pickOrderinfo")
	public String pickOrderinfo(PlateManage plateManage, Model model) {
		model.addAttribute("pickOrder", pickOrderService.findPickOrderByPlateNo(plateManage.getPlateNo()));
		return "modules/bus/ol/pickOrderInfo";
	}

	@RequiresPermissions("bus:pm:plateManage:edit")
	@RequestMapping(value = "clearPlate")
	public String clearPlate(PlateManage plateManage, RedirectAttributes redirectAttributes) {
		if (PlateManage.TRUE_FLAG.equals(plateManage.getPlateUsed())){
			PickOrder pickOrder = pickOrderService.findPickOrderByPlateNo(plateManage.getPlateNo());
			if (pickOrder == null){
				addMessage(redirectAttributes, "操作失败，未找到对应拣货单，请核实！");
			}else {
				//设置托盘使用状态为空闲
				plateManage.setPlateUsed(PlateManage.FALSE_FLAG);
				plateManageService.save(plateManage);
				//取消拣货单
				pickOrderService.cancelByPlateNo(pickOrder);
				addMessage(redirectAttributes, "操作成功！");
			}
		}
		return "redirect:"+Global.getAdminPath()+"/bus/pm/plateManage/?repage";
	}



	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "findUsableList", method = RequestMethod.POST)
	public List<PlateManage> findUsableList(PlateManage plateManage){
		plateManage.setPlateUsed(PlateManage.FALSE_FLAG);
		plateManage.setPlateStatus(PlateManage.TRUE_FLAG);
		return plateManageService.findUsableList(plateManage);
	}


    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "findInUseList", method = RequestMethod.POST)
    public List<PlateManage> findInUseList(PlateManage plateManage){
        plateManage.setPlateUsed(PlateManage.TRUE_FLAG);
        plateManage.setPlateStatus(PlateManage.TRUE_FLAG);
        return plateManageService.findList(plateManage);
    }


}