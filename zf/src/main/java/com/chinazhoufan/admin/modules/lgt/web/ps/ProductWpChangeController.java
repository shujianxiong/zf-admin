/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpChangeService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 货品货位调整记录查询Controller
 * @author 陈适、张金俊
 * @version 2015-12-04
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/productWpChange")
public class ProductWpChangeController extends BaseController {

	@Autowired
	private ProductWpChangeService productWpChangeService;
	@Autowired
	private ProductService productService;
	
	@ModelAttribute
	public ProductWpChange get(@RequestParam(required=false) String id) {
		ProductWpChange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = productWpChangeService.get(id);
		}
		if (entity == null){
			entity = new ProductWpChange();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:productWpChange:view")
	@RequestMapping(value = "list")
	public String list(ProductWpChange productWpChange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProductWpChange> page = productWpChangeService.findPage(new Page<ProductWpChange>(request, response), productWpChange); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/productWpChangeList";
	}

	@RequiresPermissions("lgt:ps:productWpChange:view")
	@RequestMapping(value = "form")
	public String form(ProductWpChange productWpChange, Model model) {
		model.addAttribute("productWpChange", productWpChange);
		return "modules/lgt/ps/productWpChangeForm";
	}

	/**
	 * 针对退货货品损坏调整货位
	 */
	@RequiresPermissions("lgt:ps:productWpChange:view")
	@RequestMapping(value = "formReturn")
	public String formReturn(@RequestParam(required=false) String code, Model model) {
		Product product = productService.getByCode(code);
		ProductWpChange productWpChange = new ProductWpChange();
		productWpChange.setProduct(product);
		model.addAttribute("productWpChange", productWpChange);
		return "modules/lgt/ps/productWpChangeFormReturn";
	}
	/**
	 * 修改货品货位
	 * @param productWpChange	货品货位变动记录
	 * @param postType			货品调后位置类型（wareplace：调到货位    holduser：调到持有人）
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpChange:edit")
	@RequestMapping(value = "save")
	public String save(ProductWpChange productWpChange, String postType, Model model, RedirectAttributes redirectAttributes) {
		try{
			if(ProductWpChange.POSTTYPE_WAREPLACE.equals(postType)){
				// 调整到货位，清空页面表单可能传递过来的调后持有人数据
				productWpChange.setPostHoldUser(null);
			}else if(ProductWpChange.POSTTYPE_HOLDUSER.equals(postType)){
				// 调整到持有人，清空页面表单可能传递过来的调后货位数据
				productWpChange.setPostWareplace(null);
			}
			productWpChangeService.updateProductPosition(productWpChange, UserUtils.getUser());
			addMessage(redirectAttributes, "保存货品货位记录成功");			
		}catch(ServiceException se){
			switch (se.getMessage()) {
			case "preWareplaceUseless":
				addMessage(redirectAttributes, "货品货位调整异常，货品调前货位未启用，不能调出");
				break;
			case "preWareplaceLocked":
				addMessage(redirectAttributes, "货品货位调整异常，货品调前货位已锁定，不能调出");
				break;
			case "postWareplaceUseless":
				addMessage(redirectAttributes, "货品货位调整异常，货品调后货位未启用，不能调入");
				break;
			case "postWareplaceLocked":
				addMessage(redirectAttributes, "货品货位调整异常，货品调后货位已锁定，不能调入");
				break;
			case "postWareplaceOccupied":
				addMessage(redirectAttributes, "货品货位调整异常，货品调入货位已存放其他产品类型的货品");
				break;
			default:
				addMessage(redirectAttributes, se.getMessage());
				break;
			}
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpChange/list?repage";
	}
	
	@RequiresPermissions("lgt:ps:productWpChange:edit")
	@RequestMapping(value = "delete")
	public String delete(ProductWpChange productWpChange, RedirectAttributes redirectAttributes) {
		if(productWpChange == null ||  StringUtils.isBlank(productWpChange.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的货品货位记录信息！");
			return "error/400";
		}
		
		productWpChangeService.delete(productWpChange);
		addMessage(redirectAttributes, "删除货品货位记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpChange/list?repage";
	}

	
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = {"adjustment", ""})
	public String adjustment(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Product> page = productService.findPage(new Page<Product>(request, response), product); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/productAdjustmentList";
	}
	
}