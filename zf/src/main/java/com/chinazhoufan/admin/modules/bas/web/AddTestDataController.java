/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.service.AddTestDataService;
import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

/**
 * 添加测试数据Contorller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/addTestData")
public class AddTestDataController extends BaseController {
	
	@Autowired
	private AddTestDataService addTestDataService;
	@Autowired
	private ScanCodeService scanCodeService;
	@Autowired
	private ProductService productService;
	@Autowired
	private WareplaceService wareplaceService;
	
	@RequestMapping(value = {"page",""})
	public String page() {
		return "modules/bas/addTestData";
	}
	
	/**
	 * 新增200个货品电子码（货品电子码从100001开始）
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "addScanCodeProduct")
	public String addScanCodeProduct(Model model) {
		Config config = ConfigUtils.getConfig("addTestDataFlag");
		if("1".equals(config.getConfigValue())){
			int totalNum = addTestDataService.addScanCodeProduct();
			addMessage(model, "成功新增货品电子码"+totalNum+"个！");			
		}else {
			addMessage(model, "新增货品电子码失败，添加测试数据开关已关闭！");			
		}
		return "modules/bas/addTestData";
	}
	
	/**
	 * 新增200个货位电子码（货品电子码从100001开始）
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "addScanCodeWareplace")
	public String addScanCodeWareplace(Model model) {
		Config config = ConfigUtils.getConfig("addTestDataFlag");
		if("1".equals(config.getConfigValue())){
			int totalNum = addTestDataService.addScanCodeWareplace();
			addMessage(model, "成功新增货位电子码"+totalNum+"个！");
		}else {
			addMessage(model, "新增货位电子码失败，添加测试数据开关已关闭！");			
		}
		return "modules/bas/addTestData";
	}
	
	/**（为系统新增测试货品入库!!!）
	 * 添加货品（为每个产品随机增加1-10个货品）
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "addProduct")
	public String addProduct(Model model) {
		Config config = ConfigUtils.getConfig("addTestDataFlag");
		if("1".equals(config.getConfigValue())){
			int totalNum = addTestDataService.addProduct();
			addMessage(model, "成功新增货品"+totalNum+"个！");			
		}else {
			addMessage(model, "新增货位电子码失败，添加测试数据开关已关闭！");			
		}
		return "modules/bas/addTestData";
	}
	
	/**
	 * 重置所有货品的电子码（清空所有货品电子码，并依次为所有货品设置电子码，电子码不足则结束）
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "resetProductScanCode")
	public String resetProductScanCode(Model model) {
		Config config = ConfigUtils.getConfig("addTestDataFlag");
		if("1".equals(config.getConfigValue())){
			int totalReset = addTestDataService.resetProductScanCode();
			int totalProduct = productService.findList(new Product()).size();
			addMessage(model, "清空所有货品电子码，并成功设置"+totalReset+"/"+totalProduct+"个！");			
		}else {
			addMessage(model, "重置货品电子码失败，添加测试数据开关已关闭！");			
		}
		return "modules/bas/addTestData";
	}
	
	/**
	 * 重置所有货位的电子码（清空所有货位电子码，并依次为所有货位设置电子码，电子码不足则结束）
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "resetWareplaceScanCode")
	public String resetWareplaceScanCode(Model model) {
		Config config = ConfigUtils.getConfig("addTestDataFlag");
		if("1".equals(config.getConfigValue())){
			int totalReset = addTestDataService.resetWareplaceScanCode();
			int totalWareplace = wareplaceService.findList(new Wareplace()).size();
			addMessage(model, "清空所有货位电子码，并成功设置"+totalReset+"/"+totalWareplace+"个！");			
		}else {
			addMessage(model, "重置货位电子码失败，添加测试数据开关已关闭！");			
		}
		return "modules/bas/addTestData";
	}
}