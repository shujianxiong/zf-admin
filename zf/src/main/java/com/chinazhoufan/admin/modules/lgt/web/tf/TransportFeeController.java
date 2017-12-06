/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.tf;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.entity.tf.TransportFee;
import com.chinazhoufan.admin.modules.lgt.service.tf.TransportFeeService;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.service.AreaService;

/**
 * 运费模板Controller
 * @author 张金俊
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/tf/transportFee")
public class TransportFeeController extends BaseController {

	@Autowired
	private TransportFeeService transportFeeService;
	@Autowired
	private AreaService areaService;
	
	@ModelAttribute
	public TransportFee get(@RequestParam(required=false) String id) {
		TransportFee entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = transportFeeService.get(id);
		}
		if (entity == null){
			entity = new TransportFee();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:tf:transportFee:view")
	@RequestMapping(value = {"list", ""})
	public String list(TransportFee transportFee, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TransportFee> page = transportFeeService.findPage(new Page<TransportFee>(request, response), transportFee); 
		model.addAttribute("page", page);
		return "modules/lgt/tf/transportFeeList";
	}

	@RequiresPermissions("lgt:tf:transportFee:view")
	@RequestMapping(value = "form")
	public String form(TransportFee transportFee, Model model) {
		
		//组装省市区列表
		Area a = new Area();
		a.setType(Area.TYPE_PROVINCE);
		List<Area> provinceList = areaService.listAreaByType(a);
		model.addAttribute("provinceList", provinceList);
		
		//省能直接取到集合，区对应的是机构存储的值，可以直接取集合，就只剩下市需要获取父级ID
		String provinceId = "";
		if (StringUtils.isNotBlank(transportFee.getId()) && transportFee.getReceiveArea()!=null && !"1".equals(transportFee.getReceiveArea().getId())){//如果区域为空或者区域是中国的，都需要重新选择区域
			
			String parentIds = transportFee.getReceiveArea().getParentIds();
			if(StringUtils.isNotBlank(parentIds)) {
				String[] idsArr = parentIds.substring(4, parentIds.length()-1).split(",");//去除开头的0,1,和最后一个,
				if(idsArr.length > 0) {
					provinceId = idsArr[0];
				}
				//市
				a.setType(Area.TYPE_CITY);
				Area p = new Area();//省级ID
				p.setId(provinceId);
				a.setParent(p);
				List<Area> cityList = areaService.listAreaByType(a);
				model.addAttribute("cityList", cityList);
				//区     赋予的当前值
				a.setType(Area.TYPE_DISTRICT);
				a.setParent(transportFee.getReceiveArea().getParent());//市级ID
				List<Area> districtList = areaService.listAreaByType(a);
				model.addAttribute("districtList", districtList);
			}
		}
		
		model.addAttribute("transportFee", transportFee);
		return "modules/lgt/tf/transportFeeForm";
	}

	@RequiresPermissions("lgt:tf:transportFee:edit")
	@RequestMapping(value = "save")
	public String save(TransportFee transportFee, Model model, RedirectAttributes redirectAttributes) {
		transportFeeService.save(transportFee);
		addMessage(redirectAttributes, "保存运费模板成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tf/transportFee/?repage";
	}
	
	@RequiresPermissions("lgt:tf:transportFee:edit")
	@RequestMapping(value = "delete")
	public String delete(TransportFee transportFee, RedirectAttributes redirectAttributes) {
		transportFeeService.delete(transportFee);
		addMessage(redirectAttributes, "删除运费模板成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/tf/transportFee/?repage";
	}

    @RequiresPermissions("lgt:tf:transportFee:view")
    @RequestMapping(value = "info")
    public String info(TransportFee transportFee, Model model) {
        model.addAttribute("transportFee", transportFee);
        return "modules/lgt/tf/transportFeeInfo";
    }

	@RequiresPermissions("lgt:tf:transportFee:view")
	@RequestMapping(value = "importForm")
	public String importForm(TransportFee transportFee, Model model) {
		model.addAttribute("transportFee", transportFee);
		return "modules/lgt/tf/transportFeeImportForm";
	}
	/**
	 * 导入区域数据
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("lgt:tf:transportFee:edit")
	@RequestMapping(value = "import", method= RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/lgt/tf/transportFee/?repage";
		}
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			transportFeeService.importTransportFee(ei);
			addMessage(redirectAttributes, "已成功导入"+ei.getLastDataRowNum()+"条运费模板数据");
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入运费模板数据失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/lgt/tf/transportFee/?repage";
	}
}