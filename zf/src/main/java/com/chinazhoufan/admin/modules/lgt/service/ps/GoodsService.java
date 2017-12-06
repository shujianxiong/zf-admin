/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.BarCodeService;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;
import com.chinazhoufan.admin.modules.lgt.service.bs.DesignerService;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;

/**
 * 商品表Service
 * @author 杨晓辉
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class GoodsService extends CrudService<GoodsDao, Goods> {

	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	@Autowired
	private CategoriesService categoryService;
	@Autowired
	private GoodsPropvalueService goodsPropvalueService;
	@Autowired
	private GoodsPropService goodsPropService;
	@Autowired
	private ProduceService produceService;
	@Autowired
	private ProducePropvalueService producePropvalueService;
	@Autowired
	private BarCodeService<GoodsDao, Goods> barCodeService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private GoodsResourceService goodsResourceService;
	@Autowired
	private GoodsResourceService resoureceService;
	@Autowired
	private DesignerService designerService;
	@Autowired
	private WhProduceService whProduceService;

	public Goods get(String id) {

		return super.get(id);
	}
	
	/**
	 * 获取商品的全信息，包括属性，图册，分类
	 * @param id
	 * @return
	 */
	public Goods find(String id){
		Goods goods=super.get(id);
		goods.setCategory(categoryService.get(goods.getCategory().getId()));
		//获取图册
		GoodsResource goodsResource = new GoodsResource();
		goodsResource.setGoods(goods);
		goodsResource.setUseType(GoodsResource.GOODS_RESOURCES_USE_ATLAS);
		goods.setGoodsResources(goodsResourceService.findListByGoodsId(goodsResource));
		goodsResource.setUseType(GoodsResource.GOODS_RESOURCES_USE_SINGLE_ATLAS);
		goods.setSingleResources(goodsResourceService.findListByGoodsId(goodsResource));
		//获取属性
		goods.setGoodsProp(goodsPropService.findByGoodsId(id));
		return goods;
	}
	
	public List<Goods> findList(Goods lgtPsGoods) {
		return super.findList(lgtPsGoods);
	}
	
	public List<Goods> findAllList(Goods lgtPsGoods) {
		return goodsDao.findAllList(lgtPsGoods);
	}
	
	public Page<Goods> findPage(Page<Goods> page, Goods lgtPsGoods) {
		return super.findPage(page, lgtPsGoods);
	}
	
	//save 只适用于新建状态下的产品新增、修改， 下架状态下的编辑
	@Transactional(readOnly = false)
	public void save(Goods goods, String operateType) throws ServiceException {
		
		//属性合法性验证,检测属性是否存在
		/***待实现***/
		
		if(StringUtils.isBlank(goods.getId())){
			//新增
			goods.setStatus(Goods.STATUS_NEW);//保存商品状态
//			goods.setCode(barCodeService.createGoodsBarCode(goods, goodsDao));//保存商品编码
			goods.setCode(codeGeneratorService.generateCode("lgt_ps_goods_code"));
			
			//保存商品
			super.save(goods);
			//保存商品关联属性和属性值
			goodsPropService.saveList(goods.getGoodsProp(),goods);
			
			//更新商品表里面的属性字符串
			updateGoodsPropertyStr(goods);
			
			//保存产品 只有新增才保存产品
			produceService.saveList(goods.getProduces(),goods);
			
		}else{
			Goods oldGoods=get(goods.getId());
			if(Goods.STATUS_UP.equals(oldGoods.getStatus()))
				throw new ServiceException("警告：商品状态不处于新建/下架状态，不允许编辑");
			goods.setStatus(oldGoods.getStatus());
			//2016-10-18  编辑商品时，保留商品之前已关联商品结果
			goods.setRelateGoodsIds(oldGoods.getRelateGoodsIds());
			//修改 商品修改不支持产品修改
			goods.preUpdate();
			//更新商品
			goodsDao.update(goods);
			//真删除原有图册
			goodsResourceService.remove(goods.getId());
			//真删除商品关联属性
			goodsPropService.remove(goodsPropService.findByGoodsId(goods.getId()), goods.getId());
			
			//保存商品关联属性和属性值
			goodsPropService.saveList(goods.getGoodsProp(),goods);
			
			//更新商品表里面的属性字符串
			updateGoodsPropertyStr(goods);
			
			List<Produce> produceList = produceService.findListByGoodsId(goods.getId());
			if(produceList != null && produceList.size() > 0) {
				for(Produce p : produceList) {
					//更新产品表里面的属性全字符串及sku字符串,,,,这里会同步更新商品属性字符串的
					produceService.updateProducePropertyStrAndSkuStr(p, goods);
				}
			}
		}
		
		//保存商品图册
		if(!StringUtils.isBlank(goods.getGoodsResourcesUrlStr())){
			//拆分商品图册字符串
			String[] urls=goods.getGoodsResourcesUrlStr().split("\\|");
			List<GoodsResource> list=Lists.newArrayList();
			for(String url:urls){
				if(!StringUtils.isBlank(url))
					list.add(new GoodsResource(GoodsResource.TYPE_PHOTO,GoodsResource.GOODS_RESOURCES_USE_ATLAS,url));
			}
			goodsResourceService.saveList(list,goods);
		}
		//保存单品图册
		if(!StringUtils.isBlank(goods.getSingleResourcesUrlStr())){
			//拆分商品图册字符串
			String[] urls=goods.getSingleResourcesUrlStr().split("\\|");
			List<GoodsResource> list=Lists.newArrayList();
			for(String url:urls){
				if(!StringUtils.isBlank(url))
					list.add(new GoodsResource(GoodsResource.TYPE_PHOTO,GoodsResource.GOODS_RESOURCES_USE_SINGLE_ATLAS,url));
			}
			goodsResourceService.saveList(list,goods);
		}
		
	}
	
	
	/**
	 * 变更
	 * @param goods
	 */
	@Transactional(readOnly = false)
	public void updateGoodsPropertyStr(Goods goods) {
		List<GoodsProp> goodsPropList = goods.getGoodsProp();
		StringBuffer sb = new StringBuffer();
		sb.append(",");
		for(GoodsProp gp : goodsPropList) {
			for(GoodsPropvalue gpp : gp.getGoodsPropvalue()) {
				sb.append(gp.getProperty().getId()+":"+gpp.getPropvalue().getId()+",");
			}
		}
		goods.setPropertyStr(sb.toString());
		goodsDao.updateGoodsPropertyStr(goods);
	}
	
	
	/**
	 * 修改商品、商品属性 
	 *
	 * @param lgtPsGoods
	 */
	@Transactional(readOnly = false)
	public void update(Goods goods){
		goods.preUpdate();
		goodsDao.update(goods);
	}
	/**
	 * 修改商品描述，备注以及设计师，品牌
	 *
	 */
	@Transactional(readOnly = false)
	public void updateRemarks(Goods goods){
		Goods oldGoods=get(goods.getId());
		oldGoods.setIntroduction(goods.getIntroduction());
		oldGoods.setRemarks(goods.getRemarks());
		oldGoods.setBrand(goods.getBrand());
		oldGoods.setDesigner(goods.getDesigner());
		oldGoods.setOrigin(goods.getOrigin());
		//更新商品
		goodsDao.update(oldGoods);
	}
	/**
	 * 商品上下架
	 *
	 * @param lgtPsGoods
	 */
	@Transactional(readOnly = false)
	public void updateGoodsStatus(Goods goods, String operationType){
		goods.preUpdate();
		goodsDao.updateGoodsStatus(goods);
		
		if(!"1".equals(operationType)) {//因 operationType的值，只有三种，发布（=1），上架（=2），下架（=3），故非1的皆需要同步变更产品状态
			List<Produce> list = produceService.findListByGoodsId(goods.getId());
			if(list != null && list.size() > 0) {
				String afterStatus = "";
				int flag = 0;
				switch(goods.getStatus()) {
					case Goods.STATUS_UP: flag = 1; afterStatus = Produce.STATUS_UP; break;
					case Goods.STATUS_DOWN: flag = 2; afterStatus = Produce.STATUS_DOWN; break;
					default: break;
				}
				if(StringUtils.isBlank(afterStatus)) {
					try {
						throw new Exception("未获取到商品的上下架信息，请检查操作");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				for(Produce p:list){
					// 2016-10-08 商品和产品目前唯一的状态关联就是  【商品下架的时候，对应的上架状态的产品下架】
					if(flag == 2) {//商品下架
						if(Produce.STATUS_UP.equals(p.getStatus())) {
							produceService.updateStatus(p.getId(), afterStatus);
						}
					} 
				}	
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Goods goods) {
		super.delete(goods);
		//删除商品的时候，需要一并删除同为新建状态下的产品数据
		Produce produce = new Produce(goods);
		produce.setStatus(Produce.STATUS_NEW);
		whProduceService.deleteByProduce(produce);
		produceService.deleteByGoodsId(produce);
	}
	
	public List<Goods> findGoodsByCategory(String categoryId){
		return goodsDao.findGoodsByCategory(Goods.DEL_FLAG_NORMAL, categoryId);
	}
	
	//已发布产品列表
	public Page<Goods> findGoodsAnProducePage(Page<Goods> page, Goods goods, String warehouseId) {
		goods.setPage(page);
		Produce produce = new Produce();
		page.setList(goodsDao.findGoodsAndProduceList(goods, warehouseId, produce));
		return page;
	}
	
	//已发布产品货品信息列表
	public Page<Goods> findGoodsAnProductPage(Page<Goods> page, Goods goods, String produceId, String warehouseId) {
		List<Goods> list = goodsDao.findGoodsAndProductList(page, goods, produceId, warehouseId);
		goods.setPage(page);
		page.setList(list);
		return page;
	}
	
	//所有产品列表
	public Page<Goods> findProducePage(Page<Goods> page, Goods goods, String warehouseId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("goods", goods);
		map.put("warehouseId", warehouseId);
		map.put("page", page);
		page.setList(goodsDao.findProduceList(map));
		return page;
	}
	
	public List<Goods> findAllListNoNew(Goods goods) {
		return goodsDao.findAllListNoNew(goods);
	}
	
	/**
	 * 查找关联商品
	 * @param goods
	 * @return
	 */
	public List<Goods> findRelateGoods(Goods goods) {
		List<String> relateGoodsIds = Lists.newArrayList();
		String goodsids = goods.getRelateGoodsIds().substring(0,goods.getRelateGoodsIds().length()-1);
		String[] str = goodsids.split(",");
		relateGoodsIds = Arrays.asList(str);
		return goodsDao.findRelateGoods(relateGoodsIds);
	}
	
	
	public Page<Goods> findPageNoNew(Page<Goods> page, Goods goods) {
		goods.setPage(page);
		page.setList(dao.findAllListNoNew(goods));
		return page;
	}
	
	/*****************web********************/
	
	
	/**
	 * 获取商品列表数据
	 * @param goodsData
	 * @return
	 */
	public Page<Goods> findGoodsSearch(String keyWord, List<String> propertyValueIds, Page<Goods> page){
		/*List<String> keyWordList = Lists.newArrayList();
		Map<String, Object> map = Maps.newConcurrentMap();
		if(StringUtils.isNotEmpty(keyWord)){
			String resultKey = IKAnalyzerUtils.participleString(keyWord, true);
			keyWordList = Arrays.asList(resultKey.split(","));
		}
		map.put("delFlag", BaseEntity.DEL_FLAG_NORMAL);
		map.put("page", page);
		map.put("keyWordList", keyWordList);
		map.put("gpvids", propertyValueIds);
		return page;*/
		return null;
	}
	
	/**
	 * 组装产品属性值
	 * @param goods Map<属性名,List<ProducePropvalue>> 
	 */
	private Map<String, List<ProducePropvalue>> reconstrProperty(Goods goods){
		Map<String, List<ProducePropvalue>> resultMap = Maps.newHashMap();
		
		 for(Produce produceTemp : goods.getProduces()){
			 List<ProducePropvalue> propvalueList = produceTemp.getProducePropValues();
			 for(ProducePropvalue propvalueTemp : propvalueList){
				 List<ProducePropvalue>  ps = resultMap.get(propvalueTemp.getProperty().getPropName());
				 for(ProducePropvalue ppv1 : propvalueList){
					 if(null == ps){
						 ps = Lists.newArrayList();
					 }
					 if(!propvalueTemp.getProperty().getPropName().equals(ppv1.getProperty().getPropName())){
							continue;
					 }
					 ps.add(ppv1);
				 }
				 resultMap.put(propvalueTemp.getProperty().getPropName(), ps);
			 }
		 }
		 
		 // 过滤重复的属性值
		 Iterator<String> keys = resultMap.keySet().iterator(); 
		 while(keys.hasNext()) {
			 String key = keys.next();
//			 System.out.println(key);
		     List<ProducePropvalue> values = resultMap.get(key);
		     Set<String> ids = Sets.newHashSet();
		     for(ProducePropvalue p : values){
		    	 ids.add(p.getPropvalue().getId());
		     }
		     List<ProducePropvalue> temp = Lists.newArrayList();
		     for(ProducePropvalue p : values){
		    	 if(ids.contains(p.getPropvalue().getId()) || StringUtils.isNotEmpty(p.getPvalue())){
		    		 temp.add(p);
		    		 ids.remove(p.getPropvalue().getId());
		    	 }
		     }
		     resultMap.put(key, temp);
		} 
		return resultMap;
	}
	
	/**
	 * 根据属性/属性值id、设置商品属性、属性值对象 
	 * @param goodsProp
	 */
	private void setGoodsPropAndVal(List<GoodsProp> goodsProp){
		for(GoodsProp p : goodsProp){
			String pId = p.getProperty().getId();
			p.setProperty(GoodsPropertyCacheUtil.getProperty(pId));
			for(GoodsPropvalue gpv : p.getGoodsPropvalue()){
				if(null != gpv.getPropvalue() && StringUtils.isNotBlank(gpv.getPropvalue().getId())){
					String pvId = gpv.getPropvalue().getId();
					Propvalue pv = GoodsPropertyCacheUtil.getPropvalueByPropvalueId(pvId);
					gpv.setPropvalue(pv);
				}
			}
		}
	}

	/**
	 * 商品简介
	 * @param goods
	 * @return
	 */
	public Goods findGoodsInfoSimpleById(Goods goods) {
		goods = goodsDao.findSimpleGoodsById(goods);
		if(goods == null){
			return new Goods();
		}
		return goods;
	}
	
	
	/**
	 * 列出待关联商品列表（排除当前被关联商品数据，同时关联商品数据必须为非新建状态）
	 * @Param @param goods
	 * @param goods
	 * @return
	 */
	public Page<Goods> listWaitRelatedGoods(Page<Goods> page, Goods goods) {
		goods.setPage(page);
		page.setList(goodsDao.listWaitRelatedGoods(goods));
		return page;
	};
	
	/**
	 * 根据商品ID集合，来获取对应的商品信息
	 * @param ids
	 * @return
	 */
	public List<Goods> listGoodsByIds(String ids) {
		if(StringUtils.isBlank(ids)) return null;
		String[] strs = ids.split(",");
		List<String> idList = Arrays.asList(strs);
		return goodsDao.listGoodsByIds(idList);
	};
	
	//==================Syn Mobile Operator Interface START===============
	/**
	 * 根据商品编码或者商品名称查询货品（不包含伪删状态）
	 * @param key 查询关键字(商品编码或者商品名称)
	 * @return
	 */
	public List<Goods> getBySearchKey(String searchKey) {
		if(StringUtils.isBlank(searchKey)) return null;
		return dao.getBySearchKey(searchKey);
	}
	
	//===============Syn Mobile Operator Interface END===============
}