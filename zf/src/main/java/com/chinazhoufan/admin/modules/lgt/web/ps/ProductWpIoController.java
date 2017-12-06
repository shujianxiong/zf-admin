/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.sys.entity.Dict;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;

/**
 * 货品出入库记录Controller
 * @author 张金俊
 * @version 2015-11-09
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/productWpIo")
public class ProductWpIoController extends BaseController {

	@Autowired
	private ProductWpIoService productWpIoService;
	@Autowired
	private ProductService productService;
	@Autowired
	private ScanCodeService scanCodeService;
	
	@ModelAttribute
	public ProductWpIo get(@RequestParam(required=false) String id) {
		ProductWpIo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = productWpIoService.get(id);
		}
		if (entity == null){
			entity = new ProductWpIo();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProductWpIo productWpIo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProductWpIo> page = productWpIoService.findPage(new Page<ProductWpIo>(request, response), productWpIo); 
		model.addAttribute("page", page);
		model.addAttribute("productWpIo", productWpIo);
		return "modules/lgt/ps/productWpIoList";
	}
	
	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = "view")
	public String view(ProductWpIo productWpIo, Model model) {
		Product product = productService.get(productWpIo.getProduct().getId());
		productWpIo.setProduct(product);
		model.addAttribute("productWpIo", productWpIo);
		return "modules/lgt/ps/productWpIoView";
	}

	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = "form")
	public String form(ProductWpIo productWpIo, Model model) {
		model.addAttribute("productWpIo", productWpIo);
		return "modules/lgt/ps/productWpIoForm";
	}

	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "save")
	public String save(ProductWpIo productWpIo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, productWpIo)){
			return form(productWpIo, model);
		}
		productWpIoService.save(productWpIo);
		addMessage(redirectAttributes, "保存货品出入库记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/?repage";
	}
	
	/**
	 * 货品入库
	 * @param productWpIo
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = "inForm")
	public String inForm(ProductWpIo productWpIo, Model model) {
		//只保留“操作原因类型”数据字典中值以“1”开头的元素（属于入库的操作原因类型）
		List<Dict> dictList = DictUtils.getDictList("lgt_ps_product_wp_io_ioReasonType");
		List<Dict> inDictList = new ArrayList<Dict>();
		for(Dict dictTemp : dictList){
			if(dictTemp.getValue().startsWith("1")){
				inDictList.add(dictTemp);
			}
		}
		model.addAttribute("inDictList", inDictList);
		model.addAttribute("productWpIo", productWpIo);
		return "modules/lgt/ps/productWpIoInForm";
	}
	/**
	 * 货品入库保存
	 * @param productWpIo
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "inSave")
	public String inSave(ProductWpIo productWpIo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, productWpIo)){
			return inForm(productWpIo, model);
		}
		try {
			productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
			productWpIoService.productInSave(productWpIo);
			addMessage(redirectAttributes, "货品入库保存成功");
		} catch (ServiceException e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "货品入库保存失败："+e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "货品入库异常");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/?repage";
	}
	
	/**
	 * 货品出库
	 * @param productWpIo
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = "outForm")
	public String outForm(ProductWpIo productWpIo, Model model) {
		//只保留“操作原因类型”数据字典中值以“2”开头的元素（属于出库的操作原因类型）
		List<Dict> dictList = DictUtils.getDictList("lgt_ps_product_wp_io_ioReasonType");
		List<Dict> outDictList = new ArrayList<Dict>();
		for(Dict dictTemp : dictList){
			if(dictTemp.getValue().startsWith("2")){
				outDictList.add(dictTemp);
			}
		}
		model.addAttribute("outDictList", outDictList);
		model.addAttribute("productWpIo", productWpIo);
		return "modules/lgt/ps/productWpIoOutForm";
	}
	/**
	 * 货品出库保存
	 * @param productWpIo
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "outSave")
	public String outSave(ProductWpIo productWpIo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, productWpIo)){
			return outForm(productWpIo, model);
		}
		try{
			String productCode = productWpIo.getProduct().getCode();
			productWpIo.setProduct(productService.getByCode(productCode));
			productWpIo.setIoType(ProductWpIo.IOTYPE_OUT);
			productWpIoService.productOutSave(productWpIo);
			addMessage(redirectAttributes, "货品出库保存成功");			
		}catch(ServiceException e){
			addMessage(redirectAttributes, "货品出库保存失败："+e.getMessage());
		}catch(Exception e){
			addMessage(redirectAttributes, "货品出库保存失败异常！！！");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/?repage";
	}
	
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "delete")
	public String delete(ProductWpIo productWpIo, RedirectAttributes redirectAttributes) {
		if(productWpIo == null || StringUtils.isBlank(productWpIo.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的货品出入库记录信息！");
			return "error/400";
		}
		
		productWpIoService.delete(productWpIo);
		addMessage(redirectAttributes, "删除货品出入库记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/?repage";
	}

}