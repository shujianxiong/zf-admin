/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pd;

import java.util.List;
import java.util.Map;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.PropertyService;
import com.chinazhoufan.admin.modules.spm.entity.pd.Discount;
import com.chinazhoufan.admin.modules.spm.service.pd.DiscountService;
import com.google.common.collect.Lists;

/**
 * 产品促销表Controller
 * @author liut
 * @version 2017-07-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pd/discount")
public class DiscountController extends BaseController {

	@Autowired
	private DiscountService discountService;
	@Autowired
	private PropertyService propertyService;
	@Autowired
	private ProduceService produceService;
	
	
	@ModelAttribute
	public Discount get(@RequestParam(required=false) String id) {
		Discount entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = discountService.get(id);
		}
		if (entity == null){
			entity = new Discount();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pd:discount:view")
	@RequestMapping(value = {"list", ""})
	public String list(Discount discount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Discount> page = discountService.findPage(new Page<Discount>(request, response), discount); 
		model.addAttribute("page", page);
		return "modules/spm/pd/discountList";
	}

	@RequiresPermissions("spm:pd:discount:view")
	@RequestMapping(value = "search")
	public String search(Produce produce, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Property property = new Property();
		property.setFilterFlag(Property.TRUE_FLAG);
		List<Property> propertyList = propertyService.listAllPropertyWithPropValueByFilterFlag(property);
		model.addAttribute("propertyList", propertyList);
		
		Page<Produce> page = new Page<Produce>(request, response);
		List<Produce> allList = produceService.filterListPage(produce, (page.getPageNo()-1)*page.getPageSize(), page.getPageSize(), "C");
		page.setCount(allList.size());
		List<Produce> list = produceService.filterListPage(produce, (page.getPageNo()-1)*page.getPageSize(), page.getPageSize(), "S");
		page.setList(list);
		model.addAttribute("page", page);
		
		List<Produce> produceList = page.getList();
		List<String> produceIdList = Lists.newArrayList();
		for(Produce pro : produceList) {
			produceIdList.add(pro.getId());
		}
		model.addAttribute("produceIdList", StringUtils.join(produceIdList, ","));
		
		model.addAttribute("produce", produce);
		
		return "modules/spm/pd/discountForm";
	}
	
	
	@RequiresPermissions("spm:pd:discount:view")
	@RequestMapping(value = "form")
	public String form(Discount discount, Model model) {
		if(StringUtils.isBlank(discount.getId())) {
			Property property = new Property();
			property.setFilterFlag(Property.TRUE_FLAG);
			List<Property> propertyList = propertyService.listAllPropertyWithPropValueByFilterFlag(property);
			model.addAttribute("propertyList", propertyList);
		}
		model.addAttribute("discount", discount);
		return "modules/spm/pd/discountForm";
	}

	@RequiresPermissions("spm:pd:discount:edit")
	@RequestMapping(value = "save")
	public String save(Discount discount, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, discount)){
			addMessage( model, "操作失败，查询产品的条件及条件说明不允许为空!");
			return form(discount, model);
		}
		discountService.save(discount);
		addMessage(redirectAttributes, "保存产品促销记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discount/?repage";
	}
	
	@RequiresPermissions("spm:pd:discount:edit")
	@RequestMapping(value = "delete")
	public String delete(Discount discount, RedirectAttributes redirectAttributes) {
		discountService.delete(discount);
		addMessage(redirectAttributes, "删除产品促销记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discount/?repage";
	}

    @RequiresPermissions("spm:pd:discount:view")
    @RequestMapping(value = "info")
    public String info(Discount discount, Model model) {
    	Discount dc = discountService.getDiscountDetail(discount);
        model.addAttribute("discount", dc);
        return "modules/spm/pd/discountInfo";
    }
}