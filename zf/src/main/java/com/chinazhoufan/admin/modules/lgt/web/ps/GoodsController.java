/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.bas.entity.Video;
import com.chinazhoufan.admin.modules.bas.service.VideoService;
import org.apache.commons.beanutils.BeanUtils;
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
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Tags;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.service.ps.CategoriesService;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProducePropvalueService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.PropertyService;
import com.chinazhoufan.admin.modules.lgt.service.ps.TagsService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierProduceService;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;
import com.google.common.collect.Lists;

/**
 * 商品列表模块管理Controller
 * @author 陈适
 * @version 2015-10-1
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goods")
public class GoodsController extends BaseController {

	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private PropertyService propertyService;
	
	@Autowired
	private CategoriesService categoriesService;
	
	@Autowired
	private ProduceService produceService;
	
	@Autowired
	private ProductService productService;

	@Autowired
	private ProducePropvalueService producePropvalueService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private TagsService tagsService;
	@Autowired
	private SupplierProduceService supplierProduceService;

	@Autowired
	private VideoService videoService;
	@ModelAttribute
	public Goods get(@RequestParam(required=false) String id) {
		
		Goods entity = null;
		if (StringUtils.isNotBlank(id)){
			//entity = goodsService.get(id);
		}
		if (entity == null){
			entity = new Goods();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = {"list", ""})
	public String list(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Goods> page = goodsService.findPage(new Page<Goods>(request, response), goods); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsList";
	}

	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "form")
	public String form(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods.getCategory()==null||StringUtils.isBlank(goods.getCategory().getId())){
			addMessage(model,"请选择商品需要加入的分类");
			return list(goods, request, response, model);
		}
		//自动生成商品编码
		if(StringUtils.isBlank(goods.getId())) {
//			goods.setCode(codeGeneratorService.generateCode(Goods.CODEGENERATE_CODE));
		}
		if(goods != null && goods.getShowVideo() != null){
			Video video = new Video();
			video.setFileUrl(goods.getShowVideo());
			List<Video> selVideoList =videoService.findList(video);
			if(selVideoList != null && selVideoList.size()>0){
				goods.setDeo(selVideoList.get(0));
			}
		}
		//获取分类关联属性
		model.addAttribute("categoryProperty",GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId()));
		goods.setStatus(Goods.STATUS_NEW);
		goods.setIsCouponUsable(Goods.TRUE_FLAG); //默认为可使用优惠券
		goods.setIsRecommend(Goods.TRUE_FLAG); //默认为推荐
		model.addAttribute("goods", goods);
		return "modules/lgt/ps/goodsForm";
	}
	
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "info")
	public String info(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model,"友情提示：未能获取到要查看的商品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(goods.getId());
		//转换图册结构
		String str="";
		for(GoodsResource goodsResource:goodsOld.getGoodsResources()){
			str=str+""+goodsResource.getUrl()+"|";
		}
		goodsOld.setGoodsResourcesUrlStr(str);
		
		model.addAttribute("categoryProperty",GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId()));
		
		//获取商品下所有产品的规格参数
		List<ProducePropvalue> list = producePropvalueService.findListByGoodsId(goods.getId());
		model.addAttribute("producePropvalue", list);
		model.addAttribute("goods", goodsOld);
		
		//关联商品数据
		String ids = goodsOld.getRelateGoodsIds();
		List<Goods> relateGoodsList = goodsService.listGoodsByIds(ids);
		model.addAttribute("relateGoodsList", relateGoodsList);
		
		//关联标签数据
		List<Tags> tagsList = tagsService.listTagsByGoodsId(goodsOld);
		model.addAttribute("tagsList", tagsList);
		
		List<Supplier> supplierList = supplierProduceService.listSupplierByGoods(goods.getId());
		model.addAttribute("supplierList", supplierList);
		return "modules/lgt/ps/goodsInfo";
	}
	
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "goodsSynInfo")
	public String goodsSynInfo(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model,"友情提示：未能获取到要查看的商品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(goods.getId());
		//转换图册结构
		String str="";
		for(GoodsResource goodsResource:goodsOld.getGoodsResources()){
			str=str+""+goodsResource.getUrl()+"|";
		}
		goodsOld.setGoodsResourcesUrlStr(str);
		
		model.addAttribute("categoryProperty",GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId()));
		
		//获取商品下所有产品的规格，库存，存放位置信息
		List<Produce> produceList = produceService.getFullProduceWithStockAndLocateByGoods(goods.getId());
		goodsOld.setProduces(produceList);
		model.addAttribute("goods", goodsOld);
		
		//关联商品数据
		String ids = goodsOld.getRelateGoodsIds();
		List<Goods> relateGoodsList = goodsService.listGoodsByIds(ids);
		model.addAttribute("relateGoodsList", relateGoodsList);
		
		//关联标签数据
		List<Tags> tagsList = tagsService.listTagsByGoodsId(goodsOld);
		model.addAttribute("tagsList", tagsList);
		
		List<Supplier> supplierList = supplierProduceService.listSupplierByGoods(goods.getId());
		model.addAttribute("supplierList", supplierList);
		return "modules/lgt/ps/goodsSynInfo";
	}
	
	
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "edit")
	public String edit(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model,"友情提示：未能获取到修改商品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(goods.getId());
		if(!Goods.STATUS_NEW.equals(goodsOld.getStatus())){
			addMessage(model,"只有新建状态的商品才能修改");
			return list(goods, request, response, model);
		}
		//转换图册结构
		String str="";
		int a = 0;
		for(GoodsResource goodsResource:goodsOld.getGoodsResources()){
			if(a != goodsOld.getGoodsResources().size()-1) {
				str=str+""+goodsResource.getUrl()+"|";
			} else {
				str=str+""+goodsResource.getUrl();
			}
			a++;
		}
		String str1="";
		int b = 0;
		for(GoodsResource goodsResource:goodsOld.getSingleResources()){
			if(b != goodsOld.getSingleResources().size()-1) {
				str1=str1+""+goodsResource.getUrl()+"|";
			} else {
				str1=str1+""+goodsResource.getUrl();
			}
			b++;
		}
		goodsOld.setGoodsResourcesUrlStr(str);
		goodsOld.setSingleResourcesUrlStr(str1);
		if(goods != null && goodsOld.getShowVideo() != null){
			Video video = new Video();
			video.setFileUrl(goodsOld.getShowVideo());
			List<Video> selVideoList =videoService.findList(video);
			if(selVideoList != null && selVideoList.size()>0){
				goodsOld.setDeo(selVideoList.get(0));
			}
		}
		List<Property> copyPropertyList = genGoodsPropertyByGoods(goodsOld);
		
		model.addAttribute("categoryProperty",copyPropertyList);
		
		model.addAttribute("goods", goodsOld);
		return "modules/lgt/ps/goodsFormEdit";
	}
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "editNew")
	public String editNew(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model,"友情提示：未能获取到修改商品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(goods.getId());
		List<Property> copyPropertyList = genGoodsPropertyByGoods(goodsOld);

		model.addAttribute("categoryProperty",copyPropertyList);

		model.addAttribute("goods", goodsOld);
		return "modules/lgt/ps/goodsFormEditNew";
	}
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "editors")
	public String editors(Goods goods, Model model,HttpServletRequest request, HttpServletResponse response) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model,"友情提示：未能获取到修改商品信息");
			return "error/400";
		}
		Goods goodsOld=goodsService.find(goods.getId());
//		if(!Goods.STATUS_DOWN.equals(goodsOld.getGoodsStatus())){
//			addMessage(model,"只有下架状态的商品才能编辑");
//			return list(goods, request, response, model);
//		}
		//转换图册结构
		String str="";
		int a = 0;
		for(GoodsResource goodsResource:goodsOld.getGoodsResources()){
			if(a != goodsOld.getGoodsResources().size()-1) {
				str=str+""+goodsResource.getUrl()+"|";
			} else {
				str=str+""+goodsResource.getUrl();
			}
			a++;
		}
		String str1="";
		int b = 0;
		for(GoodsResource goodsResource:goodsOld.getSingleResources()){
			if(b != goodsOld.getSingleResources().size()-1) {
				str1=str1+""+goodsResource.getUrl()+"|";
			} else {
				str1=str1+""+goodsResource.getUrl();
			}
			b++;
		}
		goodsOld.setGoodsResourcesUrlStr(str);
		goodsOld.setSingleResourcesUrlStr(str1);
		if(goods != null && goodsOld.getShowVideo() != null){
			Video video = new Video();
			video.setFileUrl(goodsOld.getShowVideo());
			List<Video> selVideoList =videoService.findList(video);
			if(selVideoList != null && selVideoList.size()>0){
				goodsOld.setDeo(selVideoList.get(0));
			}
		}
		List<Property> copyPropertyList = genGoodsPropertyByGoods(goodsOld);
		
		model.addAttribute("categoryProperty",copyPropertyList);
		model.addAttribute("goods", goodsOld);
		return "modules/lgt/ps/goodsFormEditors";
	}
	
	
	public List<Property> genGoodsPropertyByGoods(Goods goods) {
		//目前的商品属性有1，2，3，4，5，6
		List<Property> propertyList = GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId());
		
		List<Property> copyPropertyList = Lists.newArrayList();
		
		try {
			Property copyPro = null;
			for(Property pro : propertyList) {
				copyPro = new Property();
				BeanUtils.copyProperties(copyPro, pro);
				copyPropertyList.add(copyPro);
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//商品的属性有1，2，4，5，6，7（这里的7原来是商品属性，不过现在改成了价格决策类，但是在修改商品属性时，如果这个属性还未被产品使用，需要展示出来）
		List<GoodsProp> goodsPropList = goods.getGoodsProp();
		
		//产品已用的属性有5
		List<ProducePropvalue> producePropVList = producePropvalueService.findListByGoodsId(goods.getId());
		
		//这里的整个操作就是把属性4，6，7 加入到商品属性里面去展示出来
		for(Property property : copyPropertyList) {
			//商品原来的属性，要加上
			for(GoodsProp gp : goodsPropList) {
				if(property.getId().equals(gp.getProperty().getId())) {
					//如果这个属性被产品用了，就要过滤掉
					boolean isAdd = true;
					for(ProducePropvalue ppv : producePropVList) {
						if(ppv.getProperty().getId().equals(gp.getProperty().getId())) {
							isAdd = false;
							break;
						}
					}
					if(isAdd) {
						property.setPropType(Property.PROPTYPE_DESCRIPTION);//这一步就是还原当前这个属性的属性类型
					}
				}
				
			}
		}
		return copyPropertyList;
	}
	
	
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "save")
	public String save(String operateType,Goods goods,String [] procducePropValue,  Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, goods)){
			return form(goods, model,request, response);
		}
		boolean isSave=true;
		List<String> errList=new ArrayList<String>();
		//检测分类信息是否丢失
		if(StringUtils.isBlank(goods.getCategory().getId())){
			errList.add("商品分类信息获取失败");
			isSave=false;
		}
/*		//数据格式检测
		if(!StringUtils.isBlank(goods.getSellNum())&&!MyUtils.isInteger(goods.getSellNum())){
			errList.add("商品销量必须为数字");
			isSave=false;
		}
*/		//获取分类下所有属性
		List<Property> list = GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId());
		for(Property property:list){
			for(GoodsProp goodsProperty:goods.getGoodsProp()){
				//验证必填信息是否填写
				if(property.getNecessaryFlag().equals(GoodsProp.TRUE_FLAG)&&goodsProperty.getProperty()!=null&&goodsProperty.getProperty().getId().equals(property.getId())){
					//选择类型
					if(goodsProperty.getGoodsPropvalue().size()<=0){
						errList.add("商品保存失败："+property.getPropName()+"未填写");
						isSave=false;
						continue;
					}
					for(GoodsPropvalue val:goodsProperty.getGoodsPropvalue()){
						//输入类型
						if(property.getValueType().equals(Property.GOODS_PROPERTY_INPUT)&&StringUtils.isBlank(val.getPvalue())){
							errList.add("商品保存失败："+property.getPropName()+"未填写");
							isSave=false;
							continue;
						}
						//单选类型
						if(property.getValueType().equals(Property.GOODS_PROPERTY_SELECT)&&goodsProperty.getGoodsPropvalue().size()!=1){
							errList.add("商品保存失败："+property.getPropName()+"填写错误");
							isSave=false;
							continue;
						}
						//多选类
						if(property.getValueType().equals(Property.GOODS_PROPERTY_CHECKBOX)&&goodsProperty.getGoodsPropvalue().size()<=0){
							errList.add("商品保存失败："+property.getPropName()+"填写错误");
							isSave=false;
							continue;
						}
					}
				}else{
					//非必填项且没有填写则不保存关联属性
					if(goodsProperty.getGoodsPropvalue().size()<=0){
						continue;
					}
				}
			}
		}
		//匹配检测
		if(!isSave){
			addMessage(model, errList);
			return form(goods, model,request, response);
		}
		try{
			if(goods != null && goods.getDeo() != null){
				Video selVideo =videoService.get(goods.getDeo().getId());
				if(selVideo != null){
					goods.setShowVideo(selVideo.getFileUrl());
				}
			}
			goodsService.save(goods, operateType);
		}catch(ServiceException e){
			errList.add("商品保存失败："+e.getMessage());
			addMessage(model, errList);
			return form(goods, model,request, response);
		}
		addMessage(redirectAttributes, "商品保存成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goods/list?repage";
//		return list(goods, request, response, model);
	}
	
	
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "update")
	public String update(Goods goods, String [] procducePropValue, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goods/list?repage";
	}

	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "updateNew")
	public String updateNew(Goods goods,Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, goods)){
			return form(goods, model,request, response);
		}
		goodsService.updateRemarks(goods);
		addMessage(redirectAttributes, "商品保存成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goods/list?repage";
//		return list(goods, request, response, model);
	}
	
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "delete")
	public String delete(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(goods==null||StringUtils.isBlank(goods.getId())){
			addMessage(model, "友情提示：未能获取到商品信息");
			return "error/400";
		}
		Goods goodsOld = goodsService.get(goods.getId());
		if(!goodsOld.getStatus().equals(Goods.STATUS_NEW)){
			addMessage(model, "只有新建状态下的商品才能删除");
			return list(goods, request, response, model);
		}
		goodsService.delete(goods);
		addMessage(model, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goods/list?repage";
	}
	
	/**
	 * 
	 * @Title GoodsController
	 * @throws 
	 * @param goodId
	 * @param operationType;// 操作类型，主要用作逻辑判断，发布=1， 上架=2，下架=3 
	 * @param redirectAttributes
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(String goodId, String operationType, RedirectAttributes redirectAttributes, Model model) {
		String redirectUrl = "redirect:" + Global.getAdminPath() + "/lgt/ps/goods/list?repage";
		
		if(StringUtils.isBlank(goodId)){
			addMessage(redirectAttributes, "商品状态变更失败：未能获取到商品信息");
			return redirectUrl;
		}
		
		String opName = "";
		String nextStatus = "";
		Goods goods = new Goods();
		goods.setId(goodId);
		
		switch(operationType) {
			case "1": 
				opName = "发布"; 
				nextStatus = Goods.STATUS_DOWN; 
				goods.setStatus(nextStatus);
			break;
			case "2": 
				opName = "上架"; 
				nextStatus = Goods.STATUS_UP; 
				goods.setStatus(nextStatus);
			break;
			case "3": 
				opName = "下架"; 
				nextStatus = Goods.STATUS_DOWN;
				goods.setStatus(nextStatus);
			break;
			default: 
				opName = "未获取到操作类型"; 
			break;
		}
		
		if(StringUtils.isBlank(nextStatus)){
			addMessage(redirectAttributes, "商品状态变更失败：未能获取到商品状态信息");
			return redirectUrl;
		}
		
		Goods goodsOld = goodsService.get(goodId);
		
		//如果商品为新建状态，下一步必须是发布操作。没有发布的商品，不允许执行上/下架操作
		if(!"1".equals(operationType)) {
			if(Goods.STATUS_NEW.equals(goodsOld.getStatus())){
				addMessage(redirectAttributes, "商品状态变更失败：请先发布商品");
				return redirectUrl;
				
			} else if(Goods.STATUS_DOWN.equals(nextStatus)){//下架
				
				if(!goodsOld.getStatus().equals(Goods.STATUS_UP)){
					addMessage(redirectAttributes, "商品状态变更失败：只有上架状态下才能下架商品");
					return redirectUrl;
				}
				goodsService.updateGoodsStatus(goods, operationType);
				addMessage(redirectAttributes, opName+"操作成功");
				return redirectUrl;
				
			} else if(Goods.STATUS_UP.equals(nextStatus)){//上架
				
				if(!goodsOld.getStatus().equals(Goods.STATUS_DOWN)){
					addMessage(redirectAttributes, "商品状态变更失败：只有下架状态下才能上架商品");
					return redirectUrl;
				}
				goodsService.updateGoodsStatus(goods, operationType);
				addMessage(redirectAttributes, opName+"操作成功");
				return redirectUrl;
				
			} 
		} else {
			if(Goods.STATUS_NEW.equals(goodsOld.getStatus())){
				goodsService.updateGoodsStatus(goods, operationType);
				addMessage(redirectAttributes, opName+"操作成功");
				return redirectUrl;
			}
		}
		addMessage(redirectAttributes, opName+"操作失败");
		return redirectUrl;
		
	}
	
	//批量发布，上架，下架
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "batchOp")
	public String batchOp(String idsArr, String operationType, RedirectAttributes redirectAttributes, Model model) {
		String redirectUrl = "redirect:" + Global.getAdminPath() + "/lgt/ps/goods/list?repage";
		String opName = "";
		try {
			if(StringUtils.isBlank(idsArr)) {
				addMessage(redirectAttributes, "无效参数!");
				return redirectUrl;
			}
			String nextStatus = "";
			Goods goods = new Goods();
			
			switch(operationType) {
				case "1": 
					opName = "发布"; 
					nextStatus = Goods.STATUS_DOWN; 
					goods.setStatus(nextStatus);
				break;
				case "2": 
					opName = "上架"; 
					nextStatus = Goods.STATUS_UP; 
					goods.setStatus(nextStatus);
				break;
				case "3": 
					opName = "下架"; 
					nextStatus = Goods.STATUS_DOWN;
					goods.setStatus(nextStatus);
				break;
				default: 
					opName = "未获取到操作类型"; 
				break;
			}
			String[] ids = idsArr.split(",");
			for(String id : ids) {
				goods.setId(id);
				Goods goodsOld = goodsService.get(id);
				
				//如果商品为新建状态，下一步必须是发布操作。没有发布的商品，不允许执行上/下架操作
				if(!"1".equals(operationType)) {
					if(Goods.STATUS_NEW.equals(goodsOld.getStatus())){
						addMessage(redirectAttributes, "商品状态变更失败：请先发布商品");
						return redirectUrl;
					} else if(Goods.STATUS_DOWN.equals(nextStatus)){//下架
						if(!goodsOld.getStatus().equals(Goods.STATUS_UP)){
							addMessage(redirectAttributes, "商品状态变更失败：只有上架状态下才能下架商品");
							return redirectUrl;
						}
						goodsService.updateGoodsStatus(goods, operationType);
					} else if(Goods.STATUS_UP.equals(nextStatus)){//上架
						
						if(!goodsOld.getStatus().equals(Goods.STATUS_DOWN)){
							addMessage(redirectAttributes, "商品状态变更失败：只有下架状态下才能上架商品");
							return redirectUrl;
						}
						goodsService.updateGoodsStatus(goods, operationType);
					} 
				} else {
					if(Goods.STATUS_NEW.equals(goodsOld.getStatus())){
						goodsService.updateGoodsStatus(goods, operationType);
					} else {
						addMessage(redirectAttributes, "商品状态变更失败：非新建状态不允许发布!");
						return redirectUrl;
					}
				}
			}
			addMessage(redirectAttributes, opName+"操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, opName+"操作失败");
		}
		return redirectUrl;
	}
	
	
	/**
	 * 商品预览
	 * @return
	 */
	@RequestMapping(value = "goodsView")
	public String goodsView(String goodsId, Model model){
		Goods goods=goodsService.get(new Goods(goodsId));
		model.addAttribute("goods", goods);
		return "modules/lgt/ps/adminGoodsDetail";
	}
	/**
	 * 商品选择器  仅支持多选
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = {"select", ""})
	public String goodsSelect(Goods goods, String pageKey, @RequestParam(required = false, defaultValue="selectedIds")String selectedIds, HttpServletRequest request, HttpServletResponse response, Model model) {
		goods.setIsSelectedGoods("1");
		Page<Goods> page = goodsService.findPage(new Page<Goods>(request, response), goods); 
		model.addAttribute("page", page);
		model.addAttribute("selectedIds", selectedIds);
		model.addAttribute("pageKey", pageKey);
		return "modules/lgt/ps/goodsSelect";
	}
	
	/**
	 * 商品选择器 仅支持单选
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "selectRadio")
	public String goodsSelectRadio(Goods goods, @RequestParam(required = false, defaultValue="selectedIds")String selectedIds, HttpServletRequest request, HttpServletResponse response, Model model) {
		goods.setIsSelectedGoods("1");
		Page<Goods> page = goodsService.findPage(new Page<Goods>(request, response), goods); 
		model.addAttribute("page", page);
		model.addAttribute("selectedIds", selectedIds);
		return "modules/lgt/ps/goodsSelectRadio";
	}
	
	
	
	/**
	 * 商品关联多选择器
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "relateReadyList")
	public String goodsRelateReadyList(Goods goods, String goodsId, HttpServletRequest request, HttpServletResponse response, Model model) {
		goods.setId(goodsId);
		Goods g = goodsService.get(goodsId);
		if(g != null) {
			goods.setName(g.getName());
		}
		goods.setStatus(Goods.STATUS_NEW);
//		Page<Goods> page = goodsService.listWaitRelatedGoods(new Page<Goods>(request, response), goods); 
//		model.addAttribute("page", page);
		
		String ids = goodsService.get(goodsId).getRelateGoodsIds();
		List<Goods> goodsList = goodsService.listGoodsByIds(ids);
		model.addAttribute("goodsList", goodsList);
		
		model.addAttribute("goodsId", goodsId);
		model.addAttribute("ids", ids);
		return "modules/lgt/ps/goodsRelateReadyList";
	}
	
	/**
	 * 商品关联多选择器
	 * @param lgtPsGoods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "relateselect")
	public String goodsRelateSelect(Goods goods, String goodsId, HttpServletRequest request, HttpServletResponse response, Model model) {
		goods.setId(goodsId);
		goods.setStatus(Goods.STATUS_NEW);
		Page<Goods> page = goodsService.listWaitRelatedGoods(new Page<Goods>(request, response), goods); 
		model.addAttribute("page", page);
		model.addAttribute("goodsId", goodsId);
		model.addAttribute("ids", goodsService.get(goodsId).getRelateGoodsIds());
		return "modules/lgt/ps/goodsRelateList";
	}
	
	/**
	 * 商品关联 json方法
	 * @param goodsId 父商品ID
	 * @param addId 待添加商品ID
	 * @param isSave true 添加  false 移除
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "relateadd")
	public String goodsRelate(String goodsId,@RequestParam(value="addIds[]",required=false)String[] addIds,HttpServletResponse response) {
		if(StringUtils.isBlank(goodsId)){
			return renderString(response, "友情提示：未能获取到需添加商品信息");
		}
		try {
			Goods goodsOld=goodsService.get(goodsId);
			StringBuffer sbBuffer=new StringBuffer();
			if (addIds != null) {
				for (int i=0;i<addIds.length;i++) {
					if (i == addIds.length -1) {
						sbBuffer.append(addIds[i]);
					}else {
						sbBuffer.append(addIds[i]+",");
					}
				}
			}	
			goodsOld.setRelateGoodsIds(goodsOld.getRelateGoodsIds()+","+sbBuffer.toString());
			goodsService.update(goodsOld);
			return renderString(response, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return renderString(response, "操作失败！");
		}
		
	}
	
	/**
	 * 商品取消关联 json方法
	 * @param goodsId 父商品ID
	 * @param addId 待添加商品ID
	 * @param isSave true 添加  false 移除
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:view")
	@RequestMapping(value = "relateRemove")
	public String goodsRelateRemove(String goodsId,@RequestParam(value="addIds[]",required=false)String[] addIds,HttpServletResponse response) {
		if(StringUtils.isBlank(goodsId)){
			return renderString(response, "友情提示：未能获取到需添加商品信息");
		}
		try {
			Goods goodsOld=goodsService.get(goodsId);
			StringBuffer sbBuffer=new StringBuffer();
			if (addIds != null) {
				for (int i=0;i<addIds.length;i++) {
					if (i == addIds.length -1) {
						sbBuffer.append(addIds[i]);
					}else {
						sbBuffer.append(addIds[i]+",");
					}
				}
			}	
			goodsOld.setRelateGoodsIds(sbBuffer.toString());
			goodsService.update(goodsOld);
			return renderString(response, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return renderString(response, "操作失败！");
		}
		
	}
	
	
	/**
	 * 根据分类查询商品数据 json格式
	 * @return
	 */
	@RequestMapping(value = "goodsJsonSelect")
	public String goodsJsonDataByCategory(@RequestParam(required=false) String categoryId, HttpServletResponse response){
		if(StringUtils.isBlank(categoryId))
			return renderString(response, "请选择您要查询的分类");
		//return renderString(response, goodsService.findGoodsByCategory(categoryId));
		return null;
	}
	
	//------------新增产品规格    2016-09-30
	
	/**
	 * 新增产品规格
	 * @param produce
	 * @param goodsId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "addProduce")
	public String addProduce(String goodsId, int pageNo, int pageSize, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(goodsId)){
			addMessage(model, "新增产品失败：未能获取到商品信息");
			return "redirect:" + Global.getAdminPath() + "/lgt/ps/goods/list?repage";
		}	
		Goods goods=goodsService.find(goodsId);
		if(Goods.STATUS_UP.equals(goods.getStatus())){
			addMessage(model, "新增产品失败：商品已上架,请先下架后再执行新增产品");
			return "redirect:" + Global.getAdminPath() + "/lgt/ps/goods/list?repage";
		}
		Page<Goods> page = new Page<Goods>(pageNo, pageSize);
		goods.setPage(page);
		model.addAttribute("goods", goods);
		
		
		List<Property> copyPropertyList = genProducePropvalueByGoods(goods);
		model.addAttribute("categoryProperty", copyPropertyList);
		
		//获取商品下所有产品的规格参数
		List<ProducePropvalue> list = producePropvalueService.findListByGoodsId(goods.getId());
		model.addAttribute("producePropvalue", list);
		
		return "modules/lgt/ps/produceAddForm";
	}
	
	public List<Property> genProducePropvalueByGoods(Goods goods) {
		//目前的所有属性
		List<Property> propertyList = GoodsPropertyCacheUtil.getPropertyByCategoryId(goods.getCategory().getId());
		
		List<Property> copyPropertyList = Lists.newArrayList();
		
		try {
			Property copyPro = null;
			for(Property pro : propertyList) {
				copyPro = new Property();
				BeanUtils.copyProperties(copyPro, pro);
				copyPropertyList.add(copyPro);
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//获取商品下所有产品的规格参数
		List<ProducePropvalue> list = producePropvalueService.findListByGoodsId(goods.getId());
		
		//这一步是将原来是价格决策类的且产品已经使用，但是后来又将这个属性改成非价格决策类的属性类型还原，展示到产品修改界面上去
		for(Property property : copyPropertyList) {
			for(ProducePropvalue ppv : list) {
				if(property.getId().equals(ppv.getProperty().getId())) {
					property.setPropType(Property.PROPTYPE_DECISION);
				}
			}
		}
		return copyPropertyList;
	}
	
	/**
	 * 批量新增产品规格
	 * @param goods
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goods:edit")
	@RequestMapping(value = "saveBatch")
	public String saveBatch(Goods goods,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(goods==null||StringUtils.isBlank(goods.getId())||goods.getProduces()==null||goods.getProduces().size()<=0){
			addMessage(redirectAttributes, "新增产品规格失败：未能获取到新增产品信息");
			return  "redirect:" + Global.getAdminPath() + "/lgt/ps/goods/list?repage";
		}
		Goods goodsOld=goodsService.find(goods.getId());
		try{
			produceService.saveList(goods.getProduces(),goodsOld);
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(model, "保存产品失败，请重新填写");
			model.addAttribute("categoryProperty",genProducePropvalueByGoods(goods));
			model.addAttribute("producePropvalue", producePropvalueService.findListByGoodsId(goods.getId()));
			model.addAttribute("goods", goods);
			return "modules/lgt/ps/produceAddForm";
		}
		addMessage(model, "保存产品成功");
		goods.setId("");
		goods.setCategory(null);
		return  list(goods, request, response, model);
	}
	
	//===========Syn Mobile 操作 START====================
	
	/**
	 * 根据查询关键字检索对应的商品/产品/货品信息
	 * @param key  查询关键字【商品编码/商品名称（模糊）/产品编码/货品编码】
	 * @return 根据输入的查询关键字，返回对应的商品/产品/货品集合
	 * @throws
	 */
	@RequestMapping(value = "findGoodsBySearchKey")
	public String findGoodsBySearchKey(String key, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		/*if(StringUtils.isBlank(key)) {
			addMessage(model, "参数不能为空");
			return "modules/lgt/ps/findGoodsBySearchKeyList";
		}*/
		List<Goods> gList = goodsService.getBySearchKey(key);//商品需要显示编码
		model.addAttribute("key", key);
		if(gList != null && gList.size() > 0) {
			model.addAttribute("gList", gList);
			return "modules/lgt/ps/findGoodsBySearchKeyList";
		}
		Produce produce = produceService.getByCode(key);//产品需要显示库存
		if(produce != null)  {
			model.addAttribute("produce", produce);
			return "modules/lgt/ps/findGoodsBySearchKeyList";
		}
		Product product = productService.getByCodeWithOutDel(key);//货品需要显示货位
		if(product != null)	{
			model.addAttribute("product", product);
			return "modules/lgt/ps/findGoodsBySearchKeyList";
		}
		return "modules/lgt/ps/findGoodsBySearchKeyList";
	}
	
	//===========Syn Mobile 操作 END====================
	
}