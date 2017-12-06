/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

import java.util.ArrayList;
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

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierBrand;
import com.chinazhoufan.admin.modules.lgt.service.bs.BrandService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierBrandService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 供应商品牌关系Controller
 * @author liut
 * @version 2016-04-29
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/supplierBrand")
public class SupplierBrandController extends BaseController {

	@Autowired
	private SupplierBrandService supplierBrandService;
	@Autowired
	private BrandService brandService;
	
	
	
	@ModelAttribute
	public SupplierBrand get(@RequestParam(required=false) String id) {
		SupplierBrand entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = supplierBrandService.get(id);
		}
		if (entity == null){
			entity = new SupplierBrand();
		}
		return entity;
	}
	
	@ResponseBody
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "saveSupplierBrandBatch")
	public String saveSupplierBrandBatch(String param, HttpServletResponse response) {
		Echos echo = new Echos();
		try {
			//先获取到该设计师下面的所有的分类，然后批量删除关联关系，在重新插入最新的分类选择
			if(StringUtils.isBlank(param)) {
				return "redirect:"+Global.getAdminPath()+"/idx/bs/designer/list?repage";
			}
			
			String[] arrs = param.split("=");
			String supplierId = arrs[0];
			SupplierBrand sb = new SupplierBrand();
			Supplier s = new Supplier();
			s.setId(supplierId);
			sb.setSupplier(s);
			supplierBrandService.deleteBySupplierId(sb);
			
			if(arrs.length > 1 && !StringUtils.isBlank(arrs[1])) {
				String[] brandIds = arrs[1].split(",");
				List<SupplierBrand> list = new ArrayList<SupplierBrand>();
				Brand b = null;
				for(String bid : brandIds) {
					sb = new SupplierBrand();
					sb.setSupplier(s);
					b = new Brand();
					b.setId(bid);
					sb.setBrand(b);
					sb.setSupplier(s);
					sb.preInsert();
					list.add(sb);
				}
				supplierBrandService.saveSupplierBrandBatch(list);
				echo.setStatus(1);
				echo.setMessage("供应商品牌设置成功");
				return JsonMapper.toJsonString(echo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echo.setStatus(0);
			echo.setMessage("供应商品牌设置失败");
			return JsonMapper.toJsonString(echo);
		}
		echo.setStatus(0);
		echo.setMessage("供应商品牌设置失败");
		return JsonMapper.toJsonString(echo);
	}
	
	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = {"select", ""})
	public String select(SupplierBrand supplierBrand, HttpServletRequest request, HttpServletResponse response, Model model) {
		Brand brand = supplierBrand.getBrand();
		if(brand == null) brand = new Brand();
		//默认查询可用,可见的品牌数据
		if(StringUtils.isBlank(brand.getBrandStatus())) 
				brand.setBrandStatus(Brand.TRUE_FLAG);
		Page<Brand> page = brandService.findPage(new Page<Brand>(request, response), brand); 
		model.addAttribute("page", page);
		
		model.addAttribute("supplier", supplierBrand.getSupplier());
		
		List<SupplierBrand> sbList = supplierBrandService.listBySupplierId(supplierBrand);
		model.addAttribute("supplierBrandList", sbList);
		
		return "modules/lgt/bs/brandSelectForSupplier";
	}
	
	
}