/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceUpdate;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceUpdateService;

/**
 * 产品更新审批Controller
 * @author liut
 * @version 2017-03-22
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/produceUpdate")
public class ProduceUpdateController extends BaseController {

	@Autowired
	private ProduceUpdateService produceUpdateService;
	@Autowired
	private ProduceService produceService;
	
	@ModelAttribute
	public ProduceUpdate get(@RequestParam(required=false) String id) {
		ProduceUpdate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = produceUpdateService.get(id);
		}
		if (entity == null){
			entity = new ProduceUpdate();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:produceUpdate:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProduceUpdate produceUpdate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProduceUpdate> page = produceUpdateService.findPage(new Page<ProduceUpdate>(request, response), produceUpdate); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/produceUpdateList";
	}

	@RequiresPermissions("lgt:ps:produceUpdate:view")
	@RequestMapping(value = "form")
	public String form(ProduceUpdate produceUpdate, Model model) {
		
		if(StringUtils.isBlank(produceUpdate.getId()) && produceUpdate.getProduce() != null &&  StringUtils.isNotBlank(produceUpdate.getProduce().getCode())) {
			Produce produce = produceService.findByBarCode(produceUpdate.getProduce().getCode());
			if(produce != null) {
				if(!Produce.STATUS_DOWN.equals(produce.getStatus())) {
					//throw new ServiceException("产品非下架状态，不允许修改价格!");
					addMessage(model, "警告:产品非下架状态，不允许修改价格!");
					model.addAttribute("produceUpdate", produceUpdate);
					return "modules/lgt/ps/produceUpdateForm";
				}
				produceUpdate.setProduce(produce);
				List<ProduceUpdate> list = produceUpdateService.findUnOkList(produceUpdate);
				if(list != null && list.size() > 0) {
					//throw new ServiceException("产品改价已在审批状态中，请勿重复提交申请!");
					addMessage(model, "警告:该产品对应的产品改价申请已在审批状态中或已驳回，请核查，勿重复提交申请!");
					model.addAttribute("produceUpdate", produceUpdate);
					return "modules/lgt/ps/produceUpdateForm";
				}
				
				produceUpdate.setSrcIsBuy(produce.getIsBuy());
				produceUpdate.setSrcIsExperience(produce.getIsExperience());
				produceUpdate.setSrcIsForebuy(produce.getIsForeBuy());
				produceUpdate.setSrcIsForeexperience(produce.getIsForeExperience());
//				produceUpdate.setSrcPriceBuy(produce.getPriceBuy());
				produceUpdate.setSrcPriceOperation(produce.getPriceOperation());
				produceUpdate.setSrcPricePurchase(produce.getPricePurchase());
				produceUpdate.setCheckStatus(ProduceUpdate.CHECK_STATUS_NEW);
				produceUpdate.setSrcScaleDiscount(produce.getDiscountScale());
//				produceUpdate.setSrcScaleExperience(produce.getScaleExperience());
				produceUpdate.setProduce(produce);
			}
		}
		
		
		//不是新建，就是待审批，产品对应的改价审批未通过的数据仅只有一条，如果没有，新建
		/*List<ProduceUpdate> list = produceUpdateService.findUnOkList(produceUpdate);
		if(list != null && list.size() > 0) {
			produceUpdate = list.get(0);
		} else {
			Produce produce = produceService.getProduceOnly(produceUpdate.getProduce());
			produceUpdate.setSrcExperienceFee(produce.getExperienceFee());
			produceUpdate.setSrcIsBuy(produce.getIsBuy());
			produceUpdate.setSrcIsExperience(produce.getIsExperience());
			produceUpdate.setSrcIsForebuy(produce.getIsForeBuy());
			produceUpdate.setSrcIsForeexperience(produce.getIsForeExperience());
			produceUpdate.setSrcPriceBuy(produce.getPriceBuy());
			produceUpdate.setSrcPriceOperation(produce.getPriceOperation());
			produceUpdate.setSrcPricePurchase(produce.getPricePurchase());
			produceUpdate.setCheckStatus(ProduceUpdate.CHECK_STATUS_NEW);
			produceUpdate.setProduce(produce);
		}*/
		
		model.addAttribute("produceUpdate", produceUpdate);
		return "modules/lgt/ps/produceUpdateForm";
	}

	@RequiresPermissions("lgt:ps:produceUpdate:edit")
	@RequestMapping(value = "save")
	public String save(ProduceUpdate produceUpdate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, produceUpdate)){
			return form(produceUpdate, model);
		}
		produceUpdateService.save(produceUpdate);
		addMessage(redirectAttributes, "提交产品改价申请成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produceUpdate/?repage";
	}
	
	@RequiresPermissions("lgt:ps:produceUpdate:approve")
	@RequestMapping(value = "approve")
	public String approve(ProduceUpdate produceUpdate, Model model, RedirectAttributes redirectAttributes) {
		produceUpdateService.approve(produceUpdate);
		addMessage(redirectAttributes, "提交审批结果成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produceUpdate/?repage";
	}
	
	@RequiresPermissions("lgt:ps:produceUpdate:edit")
	@RequestMapping(value = "delete")
	public String delete(ProduceUpdate produceUpdate, RedirectAttributes redirectAttributes) {
		produceUpdateService.delete(produceUpdate);
		addMessage(redirectAttributes, "删除产品更新审批成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produceUpdate/?repage";
	}

    @RequiresPermissions("lgt:ps:produceUpdate:view")
    @RequestMapping(value = "info")
    public String info(ProduceUpdate produceUpdate, Model model) {
        model.addAttribute("produceUpdate", produceUpdate);
        return "modules/lgt/ps/produceUpdateInfo";
    }
    
    
    
}