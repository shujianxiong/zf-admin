/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Tags;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProducePropvalueService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.TagsService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierProduceService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;
import com.google.common.collect.Lists;

/**
 * 供应商产品表Controller
 * @author liut
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/supplierProduce")
public class SupplierProduceController extends BaseController {

	@Autowired
	private SupplierProduceService supplierProduceService;
	@Autowired
	private ProduceService produceService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private ProducePropvalueService producePropvalueService;
	@Autowired
	private TagsService tagsService;
	
	@ModelAttribute
	public SupplierProduce get(@RequestParam(required=false) String id) {
		SupplierProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = supplierProduceService.get(id);
		}
		if (entity == null){
			entity = new SupplierProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:si:supplierProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(SupplierProduce supplierProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SupplierProduce> page = supplierProduceService.findPage(new Page<SupplierProduce>(request, response), supplierProduce); 
		model.addAttribute("page", page);
		if(supplierProduce.getSupplier() != null) {
			Supplier supplier = supplierService.get(supplierProduce.getSupplier().getId());
			model.addAttribute("supplier", supplier);
		}
		return "modules/lgt/si/supplierProduceList";
	}

	/**
	 * 根据供应商和商品ID，获取对应的供应商产品信息
	 * @param supplierId
	 * @param goodsId
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:si:supplierProduce:view")
	@ResponseBody
	@RequestMapping(value = "listSupplierProduceBySupplierAndGoods")
	public String listSupplierProduceBySupplierAndGoods(String supplierId, String goodsId) {
		List<SupplierProduce> spList = supplierProduceService.listSupplierProduceBySupplierAndGoods(supplierId, goodsId);
		return JsonMapper.toJsonString(spList);
	}
	
	@RequiresPermissions("lgt:si:supplierProduce:view")
	@RequestMapping(value = "form")
	public String form(SupplierProduce supplierProduce, Model model) {
		//需要获取到该供应商对应的商品数据'
		if(!StringUtils.isBlank(supplierProduce.getId())) {
			List<SupplierProduce> spList = supplierProduceService.listSupplierProduceBySupplierAndGoods(supplierProduce.getSupplier().getId(), supplierProduce.getGoods().getId());
			if(spList.size() > 0) {
				SupplierProduce sp = spList.get(0);
				if(sp != null) {
					model.addAttribute("spList", spList);
				}
				supplierProduce.setGoods(sp.getGoods());
				supplierProduce.setWorkFee(sp.getWorkFee());
				supplierProduce.setTempletFee(sp.getTempletFee());
				supplierProduce.setElectrolyticGoldColour(sp.getElectrolyticGoldColour());
				supplierProduce.setElectrolyticGoldCrafts(sp.getElectrolyticGoldCrafts());
				supplierProduce.setElectrolyticGoldPrice(sp.getElectrolyticGoldPrice());
				supplierProduce.setElectrolyticGoldThickness(sp.getElectrolyticGoldThickness());
			}
		}
		model.addAttribute("supplierProduce", supplierProduce);
		model.addAttribute("supplier", supplierProduce.getSupplier());
		return "modules/lgt/si/supplierProduceForm";
	}
	
	
	@RequiresPermissions("lgt:si:supplierProduce:view")
	@RequestMapping(value = "edit")
	public String edit(String supplierId, String goodsId, Model model) {
		Goods goods = goodsService.get(goodsId);
		List<Produce> produceList = produceService.findListByGoodsId(goodsId);
		
		List<SupplierProduce> spList = supplierProduceService.listSupplierProduceBySupplierAndGoods(supplierId, goodsId);
		
		List<SupplierProduce> returnList = Lists.newArrayList();
		SupplierProduce spro = null;
		SupplierProduce supplierProduce = null;
		if(spList.size() > 0) {
			supplierProduce = spList.get(0);
				
			for(SupplierProduce produce : spList) {
				for(Produce newP : produceList) {
					if(produce.getProduce().getId().equals(newP.getId())) {
						newP.setDelFlag("99");
						returnList.add(produce);
					}
				}
			}
			//在已存在的里面，添加新的产品信息
			for(Produce produce : produceList) {
				if(!"99".equals(produce.getDelFlag())) {
					spro =  new SupplierProduce();
					spro.setGoods(goods);
					spro.setProduce(produce);
					returnList.add(spro);
				}
			}
			
		} else {
			for(Produce produce : produceList) {
				spro = new SupplierProduce();
				spro.setGoods(goods);
				spro.setProduce(produce);
				returnList.add(spro);
			}
		}
		Supplier supplier = supplierService.get(supplierId);
		model.addAttribute("supplierProduce", supplierProduce);
		model.addAttribute("spList", returnList);
		model.addAttribute("goods", goods);
		model.addAttribute("supplier", supplier);
		return "modules/lgt/si/supplierProduceForm";
	}
	
	
	@RequiresPermissions("lgt:si:supplierProduce:edit")
	@RequestMapping(value = "save")
	public String save(SupplierProduce supplierProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, supplierProduce)){
			return form(supplierProduce, model);
		}
		supplierProduceService.save(supplierProduce);
		addMessage(redirectAttributes, "保存供应商产品成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierProduce/list?supplier.id="+supplierProduce.getSupplier().getId();
	}
	
	/**
	 * 修改单条供应商产品记录
	 * @param supplierProduce
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:si:supplierProduce:view")
	@RequestMapping(value = "editor")
	public String editor(SupplierProduce supplierProduce, Model model) {
		model.addAttribute("supplierProduce", supplierProduce);
		return "modules/lgt/si/supplierProduceEditor";
	}
	
	/**
	 * 仅单纯保存供应商产品单条信息
	 * @param supplierProduce
	 * @param redirectAttributes
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:si:supplierProduce:edit")
	@RequestMapping(value = "saveOnly")
	public String saveOnly(SupplierProduce supplierProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		supplierProduceService.saveOnly(supplierProduce);
		addMessage(model, "更新供应商产品信息成功");
		return list(supplierProduce, request, response, model);
	}
	
	@RequiresPermissions("lgt:si:supplierProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(String supplierId, String goodsId, RedirectAttributes redirectAttributes) {
		supplierProduceService.deleteBySupplierAndGoods(supplierId, goodsId);
		addMessage(redirectAttributes, "删除供应商产品成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierProduce/list?supplier.id="+supplierId;
	}

	/**
	 * 查看供应商商/产品详情
	 * @param sid   供应商ID
	 * @param gid   商品ID
	 * @param pid   产品ID
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
    @RequiresPermissions("lgt:si:supplierProduce:view")
    @RequestMapping(value = "info")
    public String info(String sid, String gid, String pid, Model model) {
    	if(sid==null||StringUtils.isBlank(sid) || gid==null||StringUtils.isBlank(gid)){
			addMessage(model,"友情提示：未能获取到要查看的供应商产品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(gid);
		//转换图册结构
		String str="";
		for(GoodsResource goodsResource:goodsOld.getGoodsResources()){
			str=str+""+goodsResource.getUrl()+"|";
		}
		goodsOld.setGoodsResourcesUrlStr(str);
		
		model.addAttribute("categoryProperty",GoodsPropertyCacheUtil.getPropertyByCategoryId(goodsOld.getCategory().getId()));
		
		//获取商品下所有产品的规格参数
		List<ProducePropvalue> list = producePropvalueService.findListByGoodsId(goodsOld.getId());
		model.addAttribute("producePropvalue", list);
		model.addAttribute("goods", goodsOld);
		
		//关联商品数据
		String ids = goodsOld.getRelateGoodsIds();
		List<Goods> relateGoodsList = goodsService.listGoodsByIds(ids);
		model.addAttribute("relateGoodsList", relateGoodsList);
		
		//关联标签数据
		List<Tags> tagsList = tagsService.listTagsByGoodsId(goodsOld);
		model.addAttribute("tagsList", tagsList);
		
		//产品详情数据
		if(pid != null && StringUtils.isNotBlank(pid)) {
			Produce produce = produceService.getInfo(pid);
			model.addAttribute("produce", produce);
		}
    	
		//供应商产品数据
		SupplierProduce supplierProduce = new SupplierProduce();
		Supplier s = new Supplier(sid);
		supplierProduce.setSupplier(s);
		supplierProduce.setGoods(goodsOld);
		Produce p = new Produce(pid);
		supplierProduce.setProduce(p);
    	List<SupplierProduce> spList = supplierProduceService.findList(supplierProduce);
    	model.addAttribute("spList", spList);
    	
        return "modules/lgt/si/supplierProduceInfo";
    }
    
    
    /**
	 * 查看供应商产品详情2
	 * @param sid   供应商ID
	 * @param gid   商品ID
	 * @param pid   产品ID
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
    @RequiresPermissions("lgt:si:supplierProduce:view")
    @RequestMapping(value = "info2")
    public String info2(String sid, String gid, Model model) {
    	if(sid==null||StringUtils.isBlank(sid) || gid==null||StringUtils.isBlank(gid)){
			addMessage(model,"友情提示：未能获取到要查看的供应商产品信息");
			return "error/400";
		}
    	SupplierProduce sp = new SupplierProduce();
		sp.setSupplier(new Supplier(sid));
		List<SupplierProduce> list = supplierProduceService.findList(sp);
    	for(SupplierProduce spro : list) {
    		List<SupplierProduce> proList = supplierProduceService.listSupplierProduceBySupplierAndGoods(sid, spro.getGoods().getId());
    		spro.setSpList(proList);
    	}
    	model.addAttribute("list", list);
    	
        return "modules/lgt/si/supplierGoodsInfo";
    }
    
    
    /**
     * 打印预览供应商产品详情
     * @param supplierId
     * @param model
     * @return    设定文件
     * @throws
     */
    @RequiresPermissions("lgt:si:supplierProduce:view")
    @RequestMapping(value = "printPreview")
    public String printPreview(String supplierId, Model model) {
    	if(StringUtils.isBlank(supplierId)) {
    		return "errors/400";
    	}
    	Supplier supplier = supplierService.get(supplierId);
		model.addAttribute("supplier", supplier);
		
		SupplierProduce sp = new SupplierProduce();
		sp.setSupplier(supplier);
		List<SupplierProduce> list = supplierProduceService.findList(sp);
    	for(SupplierProduce spro : list) {
    		List<SupplierProduce> proList = supplierProduceService.listSupplierProduceBySupplierAndGoods(supplierId, spro.getGoods().getId());
    		spro.setSpList(proList);
    	}
    	model.addAttribute("list", list);
    	
    	return "modules/lgt/si/supplierProducePreview";
    }
    
    
    
}