package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.math.BigDecimal;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierProduceService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 产品明细列表Controller
 * @author 陈适
 * @version 2015-10-12
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/produce")
public class ProduceController extends BaseController {

	@Autowired
	private ProduceService produceService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private SupplierProduceService supplierProduceService;
	
	@ModelAttribute
	public Produce get(@RequestParam(required=false) String id) {
		Produce entity = null;
		if (StringUtils.isNotBlank(id)){
//			entity = produceService.get(id);
		}
		if (entity == null){
			entity = new Produce();
		}
		return entity;
	}
	
	
	@RequiresPermissions("lgt:ps:produce:view")
	@RequestMapping(value = {"list", ""})
	public String list(Produce produce, String opMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Produce> page = produceService.findPageWithGoodsAndStock(new Page<Produce>(request, response), produce); 
		
		//产品的体验押金 = （原价*体验押金比例，结果小数位进一取整），体验费 = （原价*体验费用比例，结果小数位进一，取整），如11*0.95=10.45，最终结果是11
		List<Produce> list = page.getList();
		BigDecimal experienceFee = null;
		BigDecimal experienceDepositFee = null;
		BigDecimal zeroBD = new BigDecimal("0.00");
		for(Produce p : list) {
			if(p.getPriceSrc() != null && !zeroBD.equals(p.getPriceSrc()) && p.getScaleExperienceFee() != null && !zeroBD.equals(p.getScaleExperienceFee())) {
				experienceFee = p.getPriceSrc().multiply(p.getScaleExperienceFee());
				p.setExperienceFee("("+Math.round(Math.ceil(experienceFee.doubleValue()))+")");
			}
			
			if(p.getPriceSrc() != null && !zeroBD.equals(p.getPriceSrc()) && p.getScaleExperienceDeposit() != null && !zeroBD.equals(p.getScaleExperienceDeposit())) {
				experienceDepositFee = p.getPriceSrc().multiply(p.getScaleExperienceDeposit());
				p.setExperienceDepositFee("("+Math.round(Math.ceil(experienceDepositFee.doubleValue()))+")");
			}
			
		}
		
		model.addAttribute("page", page);
		
		// 平台折扣系数，交给页面展示使用
		Config dspConfig = ConfigUtils.getConfig(Produce.DISCOUNT_SCALE_PLATFORM);
		BigDecimal dspValue = dspConfig.getConfigValue()==null ? null : BigDecimal.valueOf(Double.parseDouble(dspConfig.getConfigValue().toString()));
		model.addAttribute("dspValue", dspValue);
		
		if(StringUtils.isNotBlank(opMessage)) {
			model.addAttribute("message", opMessage);
		}
		return "modules/lgt/ps/produceList";
	}
	
	@RequiresPermissions("lgt:ps:produce:view")
	@RequestMapping(value = "info")
	public String info(Produce produce, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(produce == null || StringUtils.isBlank(produce.getId())) {
			addMessage(model, "友情提示：未能获取到要删除的产品信息！");
			return "error/400";
		}
		produce = produceService.getInfo(produce.getId());
		model.addAttribute("produce", produce);
		return "modules/lgt/ps/produceInfo";
	}

	@RequiresPermissions("lgt:ps:produce:view")
	@RequestMapping(value = "form")
	public String form(Produce produce, Model model) {
		produce = produceService.get(produce.getId());
		/*if(StringUtils.isBlank(produce.getIsBuy())) {
			produce.setIsBuy(Produce.FALSE_FLAG);
		}
		if(StringUtils.isBlank(produce.getIsExperience())) {
			produce.setIsExperience(Produce.FALSE_FLAG);
		}
		if(StringUtils.isBlank(produce.getIsForeBuy())) {
			produce.setIsForeBuy(Produce.FALSE_FLAG);
		}
		if(StringUtils.isBlank(produce.getIsForeExperience())) {
			produce.setIsForeExperience(Produce.FALSE_FLAG);
		}*/
		if(produce.getSellNum() == null) {
			produce.setSellNum(0);
		}
		if(StringUtils.isBlank(produce.getStyleType())) {//默认为精华服饰版
			produce.setStyleType(Produce.ELITE_EDITION_STYLE);
		}
		
		//如果价格为空或0 设置成供应商产品最新记录的采购价上限
		if (produce.getPricePurchase() == null || !(produce.getPricePurchase().doubleValue() > 0)) {
			SupplierProduce supplierProduce = supplierProduceService.getLastestOne(produce.getId());
			produce.setPricePurchase(supplierProduce != null?supplierProduce.getPricePurchaseMax():BigDecimal.ZERO);
		}
		
		model.addAttribute("produce", produce);
		
		// 产品计算价格使用产品自己的加价系数
//		// 价格计算系数，交给页面计算价格使用
//		Config pbConfig = ConfigUtils.getConfig(Produce.PRICE_BUY_RATIO);
//		BigDecimal pbRatio = pbConfig.getConfigValue()==null ? null : BigDecimal.valueOf(Double.parseDouble(pbConfig.getConfigValue().toString()));
//		model.addAttribute("priceBuyRatio", pbRatio);
		
		// 平台折扣系数，交给页面展示使用
		Config dspConfig = ConfigUtils.getConfig(Produce.DISCOUNT_SCALE_PLATFORM);
		BigDecimal dspValue = dspConfig.getConfigValue()==null ? null : BigDecimal.valueOf(Double.parseDouble(dspConfig.getConfigValue().toString()));
		model.addAttribute("dspValue", dspValue);
		
		return "modules/lgt/ps/produceForm";
	}

	/**
	 * 单个编辑产品规格
	 * @param goods
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "save")
	public String save(Produce produce, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(produce.getId()) || produce.getGoods() == null){
			addMessage(redirectAttributes, "新增产品规格失败：未能获取到产品对应的商品信息");
			return "redirect:"+Global.getAdminPath()+"/lgt/ps/produce/addProduce?repage";
		}
		produceService.save(produce);
		addMessage(redirectAttributes, "保存产品成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produce/list?repage";
//		return list(produce, request, response, model);
	}
	
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "delete")
	public String delete(Produce produce, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(produce==null||StringUtils.isBlank(produce.getId())){
			addMessage(model, "友情提示：未能获取到产品删除信息");
			return "error/400";
		}
		try{
			produceService.delete(produce);
			addMessage(model, "删除产品成功");
		}catch(ServiceException e){
			addMessage(model, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produce/list?repage";
	}
	
	/**
	 * 进入修改页面
	 * @param produce
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "editForm")
	public String editForm(Produce produce, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(produce==null||StringUtils.isBlank(produce.getId())){
			addMessage(model, "友情提示：未能获取到产品修改信息");
			return "error/400";
		}
		produce=produceService.get(produce.getId());
		if(!Produce.STATUS_NEW.equals(produce.getStatus())){
			addMessage(model, "只有新建状态才能修改");
			return list(produce, null, request, response, model);
		}
		model.addAttribute("produce", produce);
		return "modules/lgt/ps/produceEditForm";
	}
	
	/**
	 * 修改
	 * @param produce
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "edit")
	public String edit(Produce produce, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(produce==null||StringUtils.isBlank(produce.getId())){
			addMessage(model, "友情提示：未能获取到产品修改信息");
			return "error/400";
		}
		Produce p=produceService.get(produce.getId());
		if(!Produce.STATUS_NEW.equals(p.getStatus())){
			addMessage(model, "只有新建状态才能修改");
			return list(produce, null, request, response, model);
		}
		produceService.update(produce);
		model.addAttribute("produce", produce);
		return list(produce, null, request, response, model);
	} 
	
	/**
	 * 更新产品状态
	 * @param produceId
	 * @param operationType  操作类型，（发布=1， 上架=2，下架=3， 冻结=4）
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(String produceId, String operationType, RedirectAttributes redirectAttributes, Model model) {
		
		Echos echo = null;
		//获取操作类型（1=发布，2=上架，3=下架，4=冻结）
		String opName = "";
		String nextStatus = "";
		
		switch(operationType) {
			case "1": 
				opName = "发布"; 
				nextStatus = Produce.STATUS_DOWN; 
			break;
			case "2": 
				opName = "上架"; 
				nextStatus = Produce.STATUS_UP; 
			break;
			case "3": 
				opName = "下架"; 
				nextStatus = Produce.STATUS_DOWN;
			break;
			case "4": 
				opName = "冻结"; 
				nextStatus = Produce.STATUS_FREEZE;
			break;
			default: 
				opName = "未获取到操作类型"; 
			break;
		}
		
//		String returnUrl = "redirect:"+Global.getAdminPath()+"/lgt/ps/produce/list?repage";
		
		if(StringUtils.isBlank(produceId)){
			echo = new Echos(0, "产品状态变更失败：未获取到产品状态信息");
			return JsonMapper.toJsonString(echo);
			
//			addMessage(redirectAttributes, "产品状态变更失败：未获取到产品状态信息");
//			return returnUrl;
		}
		
		//获取原有的产品状态参数信息
		Produce produceOld = produceService.get(produceId);
		//获取产品对应的商品状态信息
		Goods goods=goodsService.get(new Goods(produceOld.getGoods().getId()));
		
		//发布
		if("1".equals(operationType)){
			//只有商品处于发布状态，且产品为新建状态下产品才能发布
			if(Produce.STATUS_NEW.equals(produceOld.getStatus()) && !Goods.STATUS_NEW.equals(goods.getStatus())){
				produceService.updateStatus(produceOld.getId(), nextStatus);
				echo = new Echos(1, "产品"+opName+"操作成功");
				return JsonMapper.toJsonString(echo);
//				addMessage(redirectAttributes, "产品"+opName+"操作成功");
//				return returnUrl;
			}else{
				echo = new Echos(0, "产品"+opName+"失败：产品对应的商品还未发布，或者产品也不处于新建状态");
				return JsonMapper.toJsonString(echo);
//				addMessage(redirectAttributes, "产品"+opName+"失败：产品对应的商品还未发布，或者产品也不处于新建状态");
//				return returnUrl;
			}
		} else {
			//新建状态
			if(Produce.STATUS_NEW.equals(produceOld.getStatus())){
				echo = new Echos(0, "产品"+opName+"失败：需商品发布后才能变更状态");
				return JsonMapper.toJsonString(echo);
//				addMessage(redirectAttributes, "产品"+opName+"失败：需商品发布后才能变更状态");
//				return returnUrl;
			}
			//冻结(上架、下架状态都可以冻结)
			if(Produce.STATUS_FREEZE.equals(nextStatus)){
				produceService.updateStatus(produceOld.getId(), nextStatus);
				echo = new Echos(1, "产品"+opName+"操作成功");
				return JsonMapper.toJsonString(echo);
//				addMessage(redirectAttributes, "产品"+opName+"操作成功");
//				return returnUrl;
			}
			
			
			//上架   产品上架要求对应的商品必须是上架状态，且产品状态应该是下架状态
			if(Produce.STATUS_UP.equals(nextStatus)){
				if(!Goods.STATUS_UP.equals(goods.getStatus())){
					echo = new Echos(0, "产品"+opName+"失败：产品所属商品还未上架或产品不处于下架或冻结状态");
					return JsonMapper.toJsonString(echo);
//					addMessage(redirectAttributes, "产品"+opName+"失败：产品所属商品还未上架或产品不处于下架或冻结状态");
//					return returnUrl;
				}
				//处于下架或冻结状态才能上架
				if(Produce.STATUS_DOWN.equals(produceOld.getStatus())||Produce.STATUS_FREEZE.equals(produceOld.getStatus())){
					produceService.updateStatus(produceOld.getId(), nextStatus);
					echo = new Echos(1, "产品"+opName+"操作成功");
					return JsonMapper.toJsonString(echo);
//					addMessage(redirectAttributes, "产品"+opName+"操作成功");
//					return returnUrl;
				}else{
					echo = new Echos(0, "产品"+opName+"失败：处于下架或冻结状态的产品才能上架，且产品对应的商品状态必须为上架");
					return JsonMapper.toJsonString(echo);
//					addMessage(redirectAttributes, "产品"+opName+"失败：产品不处于下架状态");
//					return returnUrl;
				}
			}
			//下架
			if(Produce.STATUS_DOWN.equals(nextStatus)){
				//处于上架或冻结状态才能下架
				if(Produce.STATUS_UP.equals(produceOld.getStatus())||Produce.STATUS_FREEZE.equals(produceOld.getStatus())){
					produceService.updateStatus(produceOld.getId(), nextStatus);
					echo = new Echos(1, "产品"+opName+"操作成功");
					return JsonMapper.toJsonString(echo);
//					addMessage(redirectAttributes, "产品"+opName+"操作成功");
//					return returnUrl;
				}else{
					echo = new Echos(0, "产品"+opName+"失败：处于上架或冻结状态的产品才能下架");
					return JsonMapper.toJsonString(echo);
//					addMessage(redirectAttributes, "产品"+opName+"失败：产品不处于上架状态");
//					return returnUrl;
				}
			}
			return JsonMapper.toJsonString(echo);
		}
	}
	
	
	
	//批量发布，上架，下架
	@RequiresPermissions("lgt:ps:produce:edit")
	@RequestMapping(value = "batchOp")
	public String batchOp(String idsArr, String operationType, RedirectAttributes redirectAttributes, Model model) {
		String redirectUrl = "redirect:" + Global.getAdminPath() + "/lgt/ps/produce/list?repage";
		//获取操作类型（1=发布，2=上架，3=下架，4=冻结）
		String opName = "";
		try {
			if(StringUtils.isBlank(idsArr)) {
				addMessage(redirectAttributes, "无效参数!");
				return redirectUrl;
			}
			String nextStatus = "";
			switch(operationType) {
				case "1": 
					opName = "发布"; 
					nextStatus = Produce.STATUS_DOWN; 
				break;
				case "2": 
					opName = "上架"; 
					nextStatus = Produce.STATUS_UP; 
				break;
				case "3": 
					opName = "下架"; 
					nextStatus = Produce.STATUS_DOWN;
				break;
				case "4": 
					opName = "冻结"; 
					nextStatus = Produce.STATUS_FREEZE;
				break;
				default: 
					opName = "未获取到操作类型"; 
				break;
			}
			
			String[] ids = idsArr.split(",");
			for(String produceId : ids) {
				//获取原有的产品状态参数信息
				Produce produceOld = produceService.get(produceId);
				//获取产品对应的商品状态信息
				Goods goods=goodsService.get(new Goods(produceOld.getGoods().getId()));
				
				//发布
				if("1".equals(operationType)){
					//只有商品处于发布状态，且产品为新建状态下产品才能发布
					if(Produce.STATUS_NEW.equals(produceOld.getStatus()) && !Goods.STATUS_NEW.equals(goods.getStatus())){
						produceService.updateStatus(produceOld.getId(), nextStatus);
						addMessage(redirectAttributes, "产品"+opName+"操作成功");
					}else{
						addMessage(redirectAttributes, "产品"+opName+"失败：产品对应的商品还未发布，或者产品也不处于新建状态");
						return redirectUrl;
					}
				} else {
					//新建状态
					if(Produce.STATUS_NEW.equals(produceOld.getStatus()) && Goods.STATUS_NEW.equals(goods.getStatus())){
						addMessage(redirectAttributes, "产品"+opName+"失败：需商品发布后才能变更状态");
						return redirectUrl;
					}
					//冻结(上架、下架状态都可以冻结)
					if(Produce.STATUS_FREEZE.equals(nextStatus)){
						produceService.updateStatus(produceOld.getId(), nextStatus);
						addMessage(redirectAttributes, "产品"+opName+"操作成功");
					}
					
					
					//上架   产品上架要求对应的商品必须是上架状态，且产品状态应该是下架状态
					if(Produce.STATUS_UP.equals(nextStatus)){
						if(!Goods.STATUS_UP.equals(goods.getStatus())){
							addMessage(redirectAttributes, "产品"+opName+"失败：产品所属商品还未上架或产品不处于下架或冻结状态");
							return redirectUrl;
						}
						//处于下架或冻结状态才能上架
						if(Produce.STATUS_DOWN.equals(produceOld.getStatus())||Produce.STATUS_FREEZE.equals(produceOld.getStatus())){
							produceService.updateStatus(produceOld.getId(), nextStatus);
							addMessage(redirectAttributes, "产品"+opName+"操作成功");
						}else{
							addMessage(redirectAttributes, "产品"+opName+"失败：处于下架或冻结状态的产品才能上架，且产品对应的商品状态必须为上架");
							return redirectUrl;
						}
					}
					//下架
					if(Produce.STATUS_DOWN.equals(nextStatus)){
						//处于上架或冻结状态才能下架
						if(Produce.STATUS_UP.equals(produceOld.getStatus())||Produce.STATUS_FREEZE.equals(produceOld.getStatus())){
							produceService.updateStatus(produceOld.getId(), nextStatus);
							addMessage(redirectAttributes, "产品"+opName+"操作成功");
						}else{
							addMessage(redirectAttributes, "产品"+opName+"失败：处于上架或冻结状态的产品才能下架");
							return redirectUrl;
						}
					}
				}
			}
			addMessage(redirectAttributes, "产品"+opName+"操作成功");
			return redirectUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "产品"+opName+"操作失败");
		}
		return redirectUrl;
	}
	
	
	
	
	
	/**
	 * 编辑产品标准、安全、警戒库存
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = {"editStock", ""})
	public String editStock(String produceId, Model model) {
		Produce produce = produceService.get(produceId);
		model.addAttribute("produce", produce);
		return "modules/lgt/ps/editStock";
	}
	
	/**
	 * 编辑 产品标准警戒安全库存
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "saveStock")
	public String saveStock(Produce produce, Model model){
		Produce temp = produceService.get(produce.getId());
//		temp.setStockSafe(produce.getStockSafe());
//		temp.setStockStandard(produce.getStockStandard());
//		temp.setStockWarning(produce.getStockWarning());
		produceService.save(temp);
		addMessage(model, "编辑成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produce/list?repage";
	}
	
	/**
	 * 产品选择器
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "select")
	public String select(Produce produce, String pageKey, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Produce> page = produceService.findProduceSelectPage(new Page<Produce>(request, response), produce); 
		model.addAttribute("page", page);
		model.addAttribute("pageKey", pageKey);
		return "modules/lgt/ps/produceSelect";
	}
	
	
	/**
	 * 产品选择器
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "selectRadio")
	public String selectRadio(Produce produce, String pageKey, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Produce> page = produceService.findProduceSelectPage(new Page<Produce>(request, response), produce); 
		model.addAttribute("page", page);
		model.addAttribute("pageKey", pageKey);
		return "modules/lgt/ps/produceSelectRadio";
	}
	

	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "getProduceById")
	public @ResponseBody String getProduceById(@RequestParam(value = "produceIds[]")List<String> produceIds, HttpServletRequest request, HttpServletResponse response){
		List<Produce> list = produceService.findProduceByIds(produceIds);
		return renderString(response, list);
	}
	
	/**
	 * 根据商品ID获取商品详情，包括对应的产品规格，及货品信息
	 * @param id
	 * @return    返回产品列表集合
	 * @throws
	 */
	@RequestMapping(value = "/searchByWareplace")
	public String searchByWareplace(Produce produce, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		Page<Produce> page = produceService.searchByWareplace(new Page<Produce>(request, response), produce);
		model.addAttribute("page", page);
		model.addAttribute("produce", produce);
		return "modules/lgt/ps/searchByWareplaceList";
	}
	
	/**
	 * 产品打印
	 * @param produce
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:produce:view")
	@RequestMapping(value = "printPreview")
	public String printPreview(Produce produce, Model model) {
		List<Produce> list = produceService.printPreview(produce);
		model.addAttribute("list", list);
		return "modules/lgt/ps/produceListPrint";
	}
	
	
	
	
	
}