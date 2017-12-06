/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.service.uw;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningConfigDao;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.admin.modules.msg.service.uw.aop.WarningVO;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 员工报警中心Service
 * @author 刘晓东
 * @version 2015-12-10
 */
@Service
@Transactional(readOnly = true)
public class WarningService extends CrudService<WarningDao, Warning> {

	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private ProduceService produceService;
	@Autowired
	private ProductService productService;
	@Autowired
	private WarehouseService warehouseService;
	@Autowired
	private WarningConfigDao warningConfigDao;
	
	public Warning get(String id) {
		return super.get(id);
	}
	
	public List<Warning> findList(Warning warning) {
		return super.findList(warning);
	}
	
	public Page<Warning> findPage(Page<Warning> page, Warning warning) {
		return super.findPage(page, warning);
	}
	
	public Page<Warning> findMyPage(Page<Warning> page, Warning warning) {
		warning.setReceiveUser(UserUtils.getUser());
		return super.findPage(page, warning);
	}
	
	public void poMethod(){
		
	}
	
	@Transactional(readOnly = false)
	public void save(Warning warning) {
		if(Warning.STATUS_FINISH.equals(warning.getStatus())) {
			warning.setDealEndTime(new Date());
		}
		super.save(warning);
	}
	
	@Transactional(readOnly = false)
	public void delete(Warning warning) {
		super.delete(warning);
	}
	
	/**
	 * 查看
	 */
	@Transactional(readOnly = false)
	public Warning view(Warning warning) {
		//设置状态为已查看
		warning.setStatus(Warning.STATUS_TO_DEAL);
		//设置查看时间为当前时间
		warning.setViewTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
		warning.preUpdate();
		dao.update(warning);
		warning = super.get(warning.getId());
		return warning;
	}
	
	/**
	 * 移动管理端我的预警记录列表接口
	 * @param page
	 * @param sysUserId
	 * @param category
	 * @param type
	 * @param status
	 * @return
	 */
	public Page<Warning> findMyPageByUser(Page<Warning> page, String sysUserId,
			String category, String type, String status) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("page", page);
		map.put("sysUserId", sysUserId);
		map.put("category", category);
		map.put("type", type);
		map.put("status", status);
		page.setList(dao.findMyPageByUser(map));
		return page;
	}

//	/**
//	 * 管理端报警查看
//	 * 如果消息未查看，则更新状态后返回
//	 * 如果已查看则直接返回
//	 * @param warningId
//	 */
//	@Transactional(readOnly = false)
//	public Warning view(String warningId) {
//		Warning warning = get(warningId);
//		if (warning!= null && warning.getStatus().equals(Warning.STATUS_TO_VIEW)) {
//			return view(warning);
//		}else {
//			return warning;
//		}
//	}
	
	/**
	 *	克重异常监控
	 *  检测 克重异常
	 ** @param warningVO 传递警报参数VO
	 */
	@Transactional(readOnly = false)
	public void checkWeightWarning(WarningVO warningVO){
		Product product = productService.findByBarCode(warningVO.getProductCode());
		WhProduce wp = warningVO.getWhProduce();
		wp = whProduceService.getWhProduceByWarehouseIdAnProduceId(wp);
		if(wp == null){
			throw new ServiceException("警告：不存在仓库产品");
		}
		Warehouse warehouse = warehouseService.get(wp.getWarehouse().getId());
		Produce produce = produceService.get(wp.getProduce().getId());
		Config config = ConfigUtils.getConfig(ConfigUtils.CONFIG_WEIGHT_FLOAT_PERMIT);
		BigDecimal weightTemp = BigDecimal.valueOf(Double.parseDouble(config.getConfigValue()));
		if ((product.getWeight().subtract(warningVO.getWeight())).abs().compareTo(weightTemp) > 0) {
			WarningConfig warningConfig = warningConfigDao.getByType(Warning.CATEGORY_TRANSFER,Warning.TYPE_WEIGHT);
			//如果没有/没有启用的报警异常，则抛出异常，有则生成对应的报警记录
			if (warningConfig == null || warningConfig.getUsableFlag().equals(WarningConfig.TRUE_FLAG)) {
				throw new ServiceException("警告：未找到启用的报警设置，请联系系统管理人员");
			}else {
//				Warning warning = builderWarning(warningConfig, warehouse, produce);
//				save(warning);
			}
		}
	}
	
	/**
	 *	库存监控
	 *  检测 库存警报(不包含克重异常)
	 * @param warningVO 传递警报参数VO
	 */
	@Transactional(readOnly = false)
	public void checkStockWarning(WarningVO warningVO){
		// 根据仓库判断警戒、安全、超标库存
		WhProduce wp = warningVO.getWhProduce();
		wp = whProduceService.getWhProduceByWarehouseIdAnProduceId(wp);
		if(wp == null){
			throw new ServiceException("警告：不存在仓库产品");
		}
		Warehouse warehouse = warehouseService.get(wp.getWarehouse().getId());
		Produce produce = produceService.get(wp.getProduce().getId());
		
		WarningConfig warningConfig = getWarningConfig(wp);
		
//		Warning warning = builderWarning(warningConfig, warehouse, produce);
//		save(warning);
	}
	
	/**
	 * 构造警报消息
	 * @param config
	 * @param warehouse
	 * @param produce
	 * @return
	 */
	public void builderWarning(WarningConfig config, Warehouse warehouse, Produce produce){
		Warning warning = new Warning(config.getCategory(), config.getType(), config.getTitle());
		User receiveUser = config.getReceiveUser();
		//设置指派时
		if (WarningConfig.RECEIVETYPE_USER.equals(config.getReceiveType())) {
			warning.setReceiveUser(receiveUser);
		}
		warning.setTitle(config.getTitle());
		String content = String.format(config.getContentModel(), receiveUser.getName(), warehouse.getName() + "下; 产品："+produce.getName()+"("+produce.getCode()+")");
		warning.setContent(content);
		save (warning);
	}
	
	/**
	 * 获取警报配置
	 * @param wp
	 * @return 警报配置
	 */
	private WarningConfig getWarningConfig(WhProduce wp){
		WarningConfig warningConfig  = null;
		if(wp.getStockNormal() < wp.getStockSafe()){				// 总库存低于安全库存
			warningConfig = warningConfigDao.getByType(Warning.CATEGORY_STOCK, Warning.TYPE_SAFETY);
		}else if(wp.getStockNormal() < wp.getStockWarning()){	// 总库存低于警戒库存
			warningConfig = warningConfigDao.getByType(Warning.CATEGORY_STOCK, Warning.TYPE_AlARM);
		}else if(wp.getStockNormal() > wp.getStockStandard()){	// 总库存大于标准库存
			warningConfig = warningConfigDao.getByType(Warning.CATEGORY_STOCK, Warning.TYPE_OVER);
		}
		if (warningConfig == null || warningConfig.getUsableFlag().equals(WarningConfig.TRUE_FLAG)) {
			throw new ServiceException("警告：未找到启用的报警设置，请联系系统管理人员");
		}
		return warningConfig;
	}
}