/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.BarCodeService;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceItem;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningConfigDao;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;

/**
 * 产品明细列表Service
 * @author 陈适
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class ProduceService extends CrudService<ProduceDao, Produce> {

	@Autowired
	private ProduceDao produceDao;
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private WarningDao warningDao;
	@Autowired
	private WarningConfigDao warningConfigDao;
	@Autowired
	private WarehouseDao warehouseDao;	
	@Autowired
	private ProductService productService;
	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private BarCodeService<GoodsDao, Goods> barCodeService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ProducePropvalueService producePropvalueService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ProduceItemService produceItemService;
	
	
	public Produce get(String id) {
		return super.get(id);
	}
	
	public Produce getInfo(String id) {
		return dao.getInfo(id);
	}
	
	public List<Produce> findList(Produce lgtPsProduce) {
		return super.findList(lgtPsProduce);
	}
	
	public Page<Produce> findPage(Page<Produce> page, Produce produce) {
		return super.findPage(page, produce);
	}
	
	/**
	 * 查询产品列表（列表展示页替代findList()方法，查询出产品的商品信息及库存信息）
	 * @param page
	 * @param produce
	 * @return
	 */
	public Page<Produce> findPageWithGoodsAndStock(Page<Produce> page, Produce produce) {
		produce.setPage(page);
		page.setList(dao.findListWithGoodsAndStock(produce));
		return page;
	}
	
	/**
	 * 新增产品时，需同时新增一套该产品的库存结构
	 */
	@Transactional(readOnly = false)
	public void save(Produce produce) {
		Boolean isNewRecord = produce.getIsNewRecord();
		super.save(produce);
		if (isNewRecord) {
			whProduceService.addWhProducesByProduceId(produce.getId());
		}
		
		//产品修改的还是，需要生成产品更新记录
		if(!isNewRecord) {
			int maxSerialNo = produceItemService.getMaxSerialNo();
			ProduceItem lastItem = produceItemService.getLastItemByProduce(produce.getId());
			//判断是否已有产品变更记录，如没有先保存一条原记录
			if (lastItem == null) {
				lastItem = produceItemService.copyFromProduce(produce);
				lastItem.setSrcId(produce.getId());
				lastItem.setSrcType(ProduceItem.SRCTYPE_PRODUCE_EDIT);
				lastItem.setSerialNo(++maxSerialNo);
				produceItemService.save(lastItem);
			}
			//生成变更记录
			ProduceItem item = produceItemService.copyFromProduce(produce);
			item.setSrcId(produce.getId());
			item.setSrcType(ProduceItem.SRCTYPE_PRODUCE_EDIT);
			item.setPreItem(lastItem);
			item.setSerialNo(++maxSerialNo);
			produceItemService.save(item);
		}
	}
	
	@Transactional(readOnly = false)
	public void saveList(List<Produce> produces,Goods goods) throws ServiceException {
		//创建产品名称
		for(Produce produce : produces){
			String produceName = (StringUtils.isBlank(produce.getName()) ? "" : produce.getName())+" ";
			String produceTitle = (StringUtils.isBlank(produce.getTitle()) ? "" : produce.getTitle())+" ";
			for(ProducePropvalue propValue : produce.getProducePropValues()){
				if(!StringUtils.isBlank(propValue.getPvalue())){
					produceName = produceName + propValue.getPvalue() + " ";	// 创建产品名称 名称定义规则由属性值 + 空格 填写值
					if(propValue.getTitleFlag()!=null && propValue.getTitleFlag().equals(Produce.TRUE_FLAG)){
						produceTitle = produceTitle + propValue.getPvalue() + " ";	// 创建产品标题 名称定义规则由属性值 + 空格 填写值
					}
				}else if(propValue.getPropvalue()!=null && !StringUtils.isBlank(propValue.getPropvalue().getId())){
					Propvalue p = GoodsPropertyCacheUtil.getPropvalueByPropvalueId(propValue.getPropvalue().getId());
					if(p==null){
						throw new ServiceException("产品保存失败：产品规格信息获取失败;propvalue is null");
					}
					produceName = produceName + p.getPvalueName() + " ";		// 创建产品名称 名称定义规则由属性值 + 空格 选择值
					if(propValue.getTitleFlag()!=null && propValue.getTitleFlag().equals(Produce.TRUE_FLAG)) {
						produceTitle = produceTitle + p.getPvalueNickname() + " ";    // 创建产品名称 名称定义规则由属性值 + 空格 选择值
					}
				}
			}
			produce.setName(produceName.trim());
			produce.setTitle(produceTitle.trim());
		}
		//将商品中已存在的产品追加到产品集合
		//produces.addAll(goods.getProduces());
		
		//检测产品名是否有重复(支持新增产品和已添加产品名称检测)
		for(int i=0; i<produces.size(); i++){
			String name = produces.get(i).getName();
			String title = produces.get(i).getTitle();
			boolean isRepeat=false;
			for(int j=0; j<produces.size(); j++){
				if(i==j)
					continue;
				if(name.equals(produces.get(j).getName())
						|| title.equals(produces.get(j).getTitle())){
					isRepeat=true;
					continue;
				}
			}
			if(isRepeat){
				throw new ServiceException("产品保存失败，name["+name+"]或title["+title+"]填写重复;");
			}
		}
		
		int existNum = countByGoods(goods.getId());
		
		Produce produce = null;

		int n = 0;
		
		//产品加价系数
		Config pbConfig = ConfigUtils.getConfig(Produce.PRICE_BUY_RATIO);
		BigDecimal pbRatio = pbConfig.getConfigValue()==null ? null : BigDecimal.valueOf(Double.parseDouble(pbConfig.getConfigValue().toString()));
		
		for (int i = 0; i < produces.size(); i++) {
			produce = produces.get(i);
			produce.setGoods(goods);
//			produce.setCode(barCodeService.createProduceBarCode(produce, produceDao));
			if(StringUtils.isBlank(produce.getId())) {
				n++;
				produce.setStatus(Produce.STATUS_NEW);
				produce.setCode(String.valueOf(Integer.valueOf(goods.getCode())*100+existNum+n));
				produce.setPricePurchase(BigDecimal.ZERO);
				produce.setPriceOperation(BigDecimal.ZERO);
				produce.setPriceSrc(BigDecimal.ZERO);
				produce.setScaleExperienceFee(new BigDecimal(0.06));
				produce.setScaleExperienceDeposit(new BigDecimal(1));
				produce.setIsBuy(Produce.TRUE_FLAG);
				produce.setIsExperience(Produce.TRUE_FLAG);
				produce.setIsForeBuy(Produce.FALSE_FLAG);
				produce.setIsForeExperience(Produce.FALSE_FLAG);
				produce.setIsForeexperienceDate(Produce.FALSE_FLAG);
				produce.setRatioOperation(pbRatio);
				if(produce.getSellNum() == null) {
					produce.setSellNum(0);
				}
				produce.setStyleType(Produce.ELITE_EDITION_STYLE);
				save(produce);
			} else {
				Produce p = produceDao.get(produce);
				p.setName(produce.getName());
				p.setTitle(produce.getTitle());
				save(p);
				
				produce.setPropertyStr(p.getPropertyStr());
				produce.setPropertySkuStr(p.getPropertySkuStr());
				produce.getProducePropValues().addAll(p.getProducePropValues());
			}
			//保存产品关联属性
			producePropvalueService.saveList(produce.getProducePropValues(), produce);
			
			//更新产品表里面的属性全字符串及sku字符串
			updateProducePropertyStrAndSkuStr(produce, goods);
		}
	}
	
	
	public int countByGoods(String goodsId) {
		return dao.countByGoods(goodsId);
	}
	
	
	/**
	 * 更新产品里面的全属性字符串，及产品属性字符串
	 * @param produce
	 * @param goods  主要是获取商品里面的propertyStr
	 */
	@Transactional(readOnly = false)
	public void updateProducePropertyStrAndSkuStr(Produce produce, Goods goods) {
		List<ProducePropvalue> propList = produce.getProducePropValues();
		StringBuffer sb = new StringBuffer();
		if(propList != null && propList.size() > 0) {
			sb.append(",");
		}
		for(ProducePropvalue ppv : propList) {
			sb.append(ppv.getProperty().getId()+":"+ppv.getPropvalue().getId()+",");
		}
		String goodsPropertyStr = StringUtils.isBlank(goods.getPropertyStr())? "":goods.getPropertyStr().substring(0, goods.getPropertyStr().length()-1);
		if(StringUtils.isBlank(produce.getPropertySkuStr())) {
			produce.setPropertyStr(goodsPropertyStr+sb.toString());
			produce.setPropertySkuStr(sb.toString());
		} else {
			produce.setPropertyStr(goodsPropertyStr+sb.toString()+produce.getPropertySkuStr().substring(1));
			produce.setPropertySkuStr(sb.toString()+produce.getPropertySkuStr().substring(1));
		}
		produceDao.updateProducePropertyStrAndSkuStr(produce);
		
		//更新商品表里面的属性字符串
		goodsService.updateGoodsPropertyStr(goods);
	}
	
	@Transactional(readOnly = false)
	public void update(Produce produce){
		produce.preUpdate();
		produceDao.update(produce);
	}
	
	@Transactional(readOnly = false)
	public void delete(Produce produce) {
		produce=get(produce.getId());
		if(produce != null && !produce.getStatus().equals(Produce.STATUS_NEW))
			throw new ServiceException("产品删除失败：只有新建状态的产品才允许删除");
		producePropvalueService.deleteByProduce(produce);
		whProduceService.deleteByProduce(produce);
		produceDao.delete(produce);
	}
	
	@Transactional(readOnly = false)
	public void deleteByGoodsId(Produce produce) {
		produceDao.deleteByGoodsId(produce);
	}
	
	/**
	 * 更新产品状态
	 * @param id		要更新的产品ID
	 * @param status	要更新的新状态
	 */
	@Transactional(readOnly = false)
	public void updateStatus(String id, String status){
		Produce produce=new Produce(id);
		produce.setStatus(status);	// 冻结产品时，不更新产品下货品状态为“锁定”
		produce.preUpdate();
		produceDao.updateStatus(produce);
	}

	public List<Produce> findListByGoodsId(String goodsId) {
		return produceDao.findListByGoodsId(goodsId);
	}
	
	/**
	 * 货品出/入库
	 * @param product 产品
	 * @param InventoryType 出入库类型
	 * @param num 出入库数量
	 */
	@Transactional(readOnly = false)
	public synchronized void inventoryChange(Product product,String wareplaceId, String InventoryType, int num){
		Produce produce = produceDao.get(product.getProduce().getId());
//		String wareplaceId = product.getWareplace().getId();
		//检测库存（同时会更新当前产品的库存数量）
		check(wareplaceId, produce, InventoryType, num);
		//更新库存
		save(produce);
	}
	
	/**
	 * 检测安全库存
	 * @param InventoryType 库存变更类型
	 */
	private void check(String wareplaceId, Produce produce, String InventoryType, int num) throws ServiceException{
		try {
//			Goods goods = goodsDao.get(produce.getGoods().getId());
			//增加库存等操作
//			if(Produce.IN_SALE.equals(InventoryType) || Produce.IN_AFTERMARKET.equals(InventoryType)||
//					Produce.IN_INVENTORY.equals(InventoryType)|| Produce.IN_TRANSFER.equals(InventoryType)){
//				produce.setStockExist(produce.getStockExist() + num);
//				if("0".equals(goods.getIsHireable())){//判断是不是可租赁状态
//					produce.setStockHireable(produce.getStockHireable() + num);
//				}
//			// 减少库存等操作
//			}else if(Produce.OUT_SALE.equals(InventoryType) || Produce.OUT_AFTERMARKET.equals(InventoryType)||
//					Produce.OUT_INVENTORY.equals(InventoryType) || Produce.OUT_TRANSFER.equals(InventoryType)){
//				produce.setStockExist(produce.getStockExist() - num);
//				if("0".equals(goods.getIsHireable())){
//					produce.setStockHireable(produce.getStockHireable() - num);
//				}
//			}else{
//				throw new ServiceException("产品出入库状态不存在，请检查");
//			}

			Warning war = SafeStock(produce, InventoryType);
			if(null != war){
				warningConfig(wareplaceId, war, produce);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("警告：产品出入库库存检测异常：");
		}
	}
	
	/**
	 * 安全检查
	 * @param produce
	 * @return false 正常库存； true 产生库存警报
	 */
	private Warning SafeStock(Produce produce, String inventoryType){
		Warning war = null;
//		if(produce.getStockExist() > produce.getStockStandard()){// 库存超标
//			war = new Warning(Warning.WARNING_CATEGORY_DELAY, Warning.WARNING_TYPE_OVER);
//		}else if(produce.getStockExist() < produce.getStockSafe()){// 低于安全库存
//			war = new Warning(Warning.WARNING_CATEGORY_DELAY, Warning.WARNING_TYPE_SAFETY);
//		}else if(produce.getStockExist() < produce.getStockWarning()){// 低于警报库存
//			war = new Warning(Warning.WARNING_CATEGORY_DELAY, Warning.WARNING_TYPE_AlARM);
//		}
		return war;
	}
	
	/**
	 * 保存警报消息
	 * @param war  警报消息对象
	 * @param goodsId 警报消息商品
	 */
	private void warningConfig(String wareplaceId, Warning war, Produce produce){
		WarningConfig warningConfig = new WarningConfig(Warning.CATEGORY_STOCK, war.getType(), "1");
		WarningConfig config = warningConfigDao.findByWarningConfigType(warningConfig);
		if(null == config){
			throw new ServiceException("警告：不存在警报消息配置；请联系管理员配置报警发送设置！！！");
		}
		
		User sentUser = UserUtils.get(config.getReceiveUser().getId());
		Goods good = goodsDao.get(produce.getGoods().getId());
		String content = String.format(config.getContentModel(), sentUser.getName(), good.getName()+"-"+produce.getName());
		String title = config.getTitle();
		Warehouse house = warehouseDao.findWareHouseByWareplaceId(wareplaceId);
		war.setReceiveUser(house.getResponsibleUser());
		war.setContent(content);
		war.setTitle(title);
		war.preInsert();
		warningDao.insert(war);
	}

	public List<Produce> findProduceByIds(List<String> produceIds) {
		List<Produce> produces = produceDao.findProduceByIds(produceIds);
		for(Produce produce : produces){
			List<ProducePropvalue> ppvs = produce.getProducePropValues();
			for(ProducePropvalue ppv : ppvs){
				Property property = ppv.getProperty();
				property = GoodsPropertyCacheUtil.getProperty(property.getId());
				if(null != property && !Property.GOODS_PROPERTY_INPUT.equals(property.getValueType())){
					Propvalue propvalue = GoodsPropertyCacheUtil.getPropvalueByPropvalueId(ppv.getPropvalue().getId());
					ppv.setProperty(property);
					ppv.setPropvalue(propvalue);
				}
			}
		}
		
		return produces;
	}
	
	/**
	 * 产品选择器
	 * @param page
	 * @param produce
	 * @return
	 */
	public Page<Produce> findProduceSelectPage(Page<Produce> page,Produce produce) {
		produce.setPage(page);
		List<Produce> list = dao.findSelectList(produce);
		//过滤掉在库库存为0的产品数据
		//TODO 待优化
		/*List<Produce> produceList = Lists.newArrayList();
		if(!CollectionUtils.isEmpty(list)) {
			for(Produce p : list) {
				if(p.getStockWarehouse() > 0) {
					produceList.add(p);
				}
			}
		}
		page.setList(produceList);*/
		page.setList(list);
		return page;
	}
	
	/**
	 * 根据产品ID，获取产品的基本信息，不做级联查询
	 * @param produce
	 * @return    设定文件
	 * @throws
	 */
	public Produce getProduceOnly(Produce produce) {
		return dao.getProduceOnly(produce);
	}
	
	public Produce findByBarCode(String barCode) {
		return dao.findByBarCode(barCode);
	}
	
	/**
	 * 产品打印接口
	 * @param produce
	 * @return
	 */
	public List<Produce> printPreview(Produce produce) {
		return dao.printPreview(produce);
	};
	
	
	//==================Syn Mobile Operator Interface START===============
	/**
	 * 根据产品编码查询产品（不包含伪删状态）
	 * @param code 产品编码
	 * @param code
	 * @return
	 */
	public Produce getByCode(String code) {
		if(StringUtils.isBlank(code)) return null;
		return dao.getByCode(code);
	}
	
	/**
	 * 根据货位获取存放产品全名+库存+完整货位地址
	 * @param wareplaceCode
	 * @return    设定文件
	 * @throws
	 */
	public Page<Produce> searchByWareplace(Page<Produce> page, Produce produce) {
		if(produce == null || StringUtils.isBlank(produce.getFullWareplace())) return page;
		produce.setPage(page);
		List<Produce> list = dao.searchByWareplace(produce);
		page.setList(list);
		return page;
	};
	
	
	/**
	 * 根据商品ID获取对应的产品规格信息及产品对应的存放货位和可用库存数量 
	 * @param goodsId
	 * @throws
	 */
	public List<Produce> getFullProduceWithStockAndLocateByGoods(String goodsId) {
		if(StringUtils.isBlank(goodsId)) return null;
		return dao.getFullProduceWithStockAndLocateByGoods(goodsId);
	}
	//==================Syn Mobile Operator Interface END===============
	
	/**
	 * 产品促销筛查接口
	 * @param page
	 * @param produce
	 * @param pageFromNum
	 * @param pageSize
	 * @param searchType  C=总数， S=分页查询
	 * @return
	 */
	public List<Produce> filterListPage(Produce produce, int pageFromNum, int pageSize, String searchType) {
		String propvalueStr = produce.getPropvalueArr();
		Map<String, Object> maps = new HashMap<String, Object>();
		if(!StringUtils.isBlank(propvalueStr)) {
			String[] arr = propvalueStr.split(",");
			List<String> searchKeyList = null;
			for(String s : arr) {
				searchKeyList = Lists.newArrayList();
				String[] tArr = s.split("T");
				String[] pvArr = tArr[1].split("=");
				String pid = pvArr[0];
				String[] pvidArr = pvArr[1].split("〓");
				for(String pvid : pvidArr) {
					searchKeyList.add(","+pid+":"+pvid+",");
				}
				maps.put(pid, searchKeyList);
			}
		}
		return dao.filterList(maps, pageFromNum, pageSize, searchType, produce);
	};
	
	
	/**
	 * 根据产品DI集合，返回产品及对应的商品信息
	 * @param produceIds
	 * @return
	 */
	public List<Produce> findProduceByIdsWithGoods(@Param(value="produceIds") List<String> produceIds) {
		return dao.findProduceByIdsWithGoods(produceIds);
	}

	public BigDecimal getBuyDiscountPrice(Produce produce){
		if (produce.getDiscountPrice() != null&&produce.getDiscountPrice().doubleValue() > 0) {
			return produce.getDiscountPrice();
		}else if (produce.getDiscountScale() != null && produce.getDiscountScale().doubleValue() > 0) {
			if (produce.getDiscountScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
				produce.setDiscountScale(produce.getExperiencePackScale());
			}
			return produce.getDiscountScale().multiply(produce.getPriceSrc());
		}else if (produce.getDiscountFilterScale() != null && produce.getDiscountFilterScale().doubleValue() > 0) {
			if (produce.getDiscountFilterStart() == null && produce.getDiscountFilterEnd() == null) {
				if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
					produce.setDiscountFilterScale(produce.getExperiencePackScale());
				}
				return produce.getDiscountFilterScale().multiply(produce.getPriceSrc());
			}else if (produce.getDiscountFilterStart() != null && produce.getDiscountFilterEnd() == null) {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) > 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale().multiply(produce.getPriceSrc());
				}
			}else if (produce.getDiscountFilterStart() == null && produce.getDiscountFilterEnd() != null) {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) < 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale().multiply(produce.getPriceSrc());
				}
			}else {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) > 0 && DateUtils.compare_date(produce.getDiscountFilterEnd()) < 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale().multiply(produce.getPriceSrc());
				}
			}
		}
		BigDecimal platformScale = new BigDecimal(ConfigUtils.getConfig(Produce.DISCOUNT_SCALE_PLATFORM).getConfigValue());
		if (platformScale.doubleValue() > produce.getExperiencePackScale().doubleValue()) {
			platformScale = produce.getExperiencePackScale();
		}
		return platformScale.multiply(produce.getPriceSrc());
	}
	
	public BigDecimal getBuyDiscount(Produce produce) {
		if (produce.getDiscountPrice() != null&&produce.getDiscountPrice().doubleValue() > 0) {
			return null;
		}else if (produce.getDiscountScale() != null && produce.getDiscountScale().doubleValue() > 0) {
			if (produce.getDiscountScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
				produce.setDiscountScale(produce.getExperiencePackScale());
			}
			return produce.getDiscountScale();
		}else if (produce.getDiscountFilterScale() != null && produce.getDiscountFilterScale().doubleValue() > 0) {
			if (produce.getDiscountFilterStart() == null && produce.getDiscountFilterEnd() == null) {
				if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
					produce.setDiscountFilterScale(produce.getExperiencePackScale());
				}
				return produce.getDiscountFilterScale();
			}else if (produce.getDiscountFilterStart() != null && produce.getDiscountFilterEnd() == null) {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) > 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale();
				}
			}else if (produce.getDiscountFilterStart() == null && produce.getDiscountFilterEnd() != null) {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) < 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale();
				}
			}else {
				if (DateUtils.compare_date(produce.getDiscountFilterStart()) > 0 && DateUtils.compare_date(produce.getDiscountFilterEnd()) < 0) {
					if (produce.getDiscountFilterScale().doubleValue() > produce.getExperiencePackScale().doubleValue()) {
						produce.setDiscountFilterScale(produce.getExperiencePackScale());
					}
					return produce.getDiscountFilterScale();
				}
			}
		}
		BigDecimal platformScale = new BigDecimal(ConfigUtils.getConfig(Produce.DISCOUNT_SCALE_PLATFORM).getConfigValue());
		if (platformScale.doubleValue() > produce.getExperiencePackScale().doubleValue()) {
			platformScale = produce.getExperiencePackScale();
		}
		return platformScale;
	}
	
}