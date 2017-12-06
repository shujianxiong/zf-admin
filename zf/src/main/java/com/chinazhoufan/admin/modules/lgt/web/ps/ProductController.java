/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.token.annotation.FormToken;
import com.chinazhoufan.admin.common.token.annotation.TokenValid;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;

/**
 * 货品明细管理Controller
 * @author 陈适
 * @version 2015-10-12
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/product")
public class ProductController extends BaseController {

	@Autowired
	private ProductService productService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private WarehouseService warehouseService;
	
	@ModelAttribute
	public Product get(@RequestParam(required=false) String id) {
		Product entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = productService.get(id);
		}
		if (entity == null){
			entity = new Product();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = {"list", ""})
	public String list(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Product> page = productService.findPage(new Page<Product>(request, response), product);
		Warehouse wh = new Warehouse();
		wh.setUsableFlag(Warehouse.TRUE_FLAG);
		List<Warehouse> list = warehouseService.findList(wh);
		model.addAttribute("page", page);
		model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/productList";
	}

	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "form")
	@FormToken
	public String form(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("product", product);
		return "modules/lgt/ps/productForm";
	}
	
	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "upload")
	public String upload(Product product, Model model) {
		product = productService.get(product.getId());
		model.addAttribute("product", product);
		return "modules/lgt/ps/productUpLoad";
	}

	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "info")
	public String info(Product product, Model model) {
		model.addAttribute("product", product);
		return "modules/lgt/ps/productInfo";
	}
	
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "save")
	@TokenValid
	public String save(Product product, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, product)){
			return form(product,request, response, model);
		}
		productService.save(product);
		addMessage(redirectAttributes, "保存货品成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/product/list?repage";
//		return list(product, request, response, model);
	}
	
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "update")
	public String update(Product product, Model model, HttpServletRequest request, HttpServletResponse response) {
		if(product==null||StringUtils.isBlank(product.getId())){
			addMessage(model, "友情提示：未能获取到货品修改信息");
			return "error/400";
		}
		productService.update(product);
		//model.addAttribute("produce", product);
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/product/list?repage";
	}

	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "delete")
	public String delete(Product product, RedirectAttributes redirectAttributes) {
		if(product == null || StringUtils.isBlank(product.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的货品信息！");
			return "error/400";
		}
		
		productService.delete(product);
		addMessage(redirectAttributes, "删除货品成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/product/list?repage";
	}

	/**[接口]
	 * 根据编码查询货品信息
	 * @param pcode 货品编码
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "getDataByCode", method = {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String getDataByCode(String pcode, HttpServletResponse response) {
		if(StringUtils.isBlank(pcode))
			return null;
		Product product = productService.getByCode(pcode);
		return JsonMapper.toJsonString(product);
	}
	
	
	/**[接口]
	 * 判断货品是否可出库 json方法
	 * @param pid 货品ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "checkProductWpIoOut")
	public String checkProductWpIoOut(String pcode, HttpServletResponse response) {
		if(StringUtils.isBlank(pcode)){
			return renderString(response, "false:未能获取到需检测的货品信息！");
		}
		Product product = productService.getByCode(pcode);
		if(product == null){
			return renderString(response, "false:未能获取到需检测的货品信息！");
		}
		if("1".equals(product.getDelFlag())){
			return renderString(response, "false:对应货品删除状态为已删除，不能进行出库操作！");
		}
		
		if(Product.STATUS_NORMAL.equals(product.getStatus()) || Product.STATUS_HIRING.equals(product.getStatus()) || Product.STATUS_LOCKED.equals(product.getStatus())){
			return renderString(response, "success:对应货品可出库");			
		}else {
			return renderString(response, "false:对应货品不是锁定,正常,体验状态，不能进行出库操作，请检查！");
		}
	}
	
	/**[接口]
	 * 产品货品选择器
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "select")
	public String productSelect(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*List<String> productStatusList = Lists.newArrayList();
		productStatusList.add(Product.STATUS_NORMAL);
		product.setProductStatusList(productStatusList);*/
		product.setStatus(Product.STATUS_NORMAL);
		Page<Product> page = productService.findPage(new Page<Product>(request, response), product); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/productSelect";
	}
	
	
	/**
	 * 货品打印
	 * @param produce
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "printPreview")
	public String printPreview(Product product, Model model) {
		List<Product> list = productService.printPreview(product);
		model.addAttribute("list", list);
		return "modules/lgt/ps/productListPrint";
	}


	/**
	 * 根据货品编码查询货品
	 * @param code
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "code/{code}", method = RequestMethod.GET)
	public Product getByCode(@PathVariable("code") String code){
		Product product = productService.getByCode(code);
		return product == null?new Product():product;
	}

	
	
}