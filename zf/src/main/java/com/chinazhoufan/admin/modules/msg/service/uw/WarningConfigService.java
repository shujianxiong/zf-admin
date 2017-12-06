/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.service.uw;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.warning.exception.WarningValidException;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WhProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningConfigDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.api.common.service.ServiceException;

/**
 * 报警发送设置Service
 * @author 刘晓东
 * @version 2015-12-11
 */
@Service
@Transactional(readOnly = true)
public class WarningConfigService extends CrudService<WarningConfigDao, WarningConfig> {

	@Autowired
	WarehouseDao warehouseDao;
	@Autowired
	WhProduceDao whProduceDao;
	@Autowired
	WarningService warningService;
	
	public WarningConfig get(String id) {
		return super.get(id);
	}
	
	public List<WarningConfig> findList(WarningConfig warningConfig) {
		return super.findList(warningConfig);
	}
	
	public WarningConfig find(WarningConfig warningConfig) {
		List<WarningConfig> result = super.findList(warningConfig);
		return result.isEmpty()?null:result.get(0);
	}
	
	public Page<WarningConfig> findPage(Page<WarningConfig> page, WarningConfig warningConfig) {
		return super.findPage(page, warningConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(WarningConfig warningConfig) {
		super.save(warningConfig);
	}
	
	
	@Transactional(readOnly = false)
	public int saveWarningConfig(WarningConfig warningConfig) {
		int resultType = 0;
		//警报类别，警报类型，接收类型，接收人一致，只允许生成一条记录
		WarningConfig wc = new WarningConfig();
		wc.setCategory(warningConfig.getCategory());
		wc.setType(warningConfig.getType());
		wc.setReceiveType(warningConfig.getReceiveType());
		wc.setReceiveUser(warningConfig.getReceiveUser());
		List<WarningConfig> wcList = dao.findList(wc);
		if(wcList != null && wcList.size() > 0) {
			wc = wcList.get(0);
			if(!wc.getId().equals(warningConfig.getId())) {
				resultType = 1;
			}
		}
		if(resultType == 0) {
			super.save(warningConfig);
		}
		return resultType;
	}
	
	
	@Transactional(readOnly = false)
	public void delete(WarningConfig warningConfig) {
		super.delete(warningConfig);
	}

	@Transactional(readOnly = false)
	public void enable(WarningConfig warningConfig) {
		warningConfig.setUsableFlag(WarningConfig.TRUE_FLAG);
		warningConfig.preUpdate();
		dao.update(warningConfig);
	}

	@Transactional(readOnly = false)
	public void disable(WarningConfig warningConfig) {
		warningConfig.setUsableFlag(WarningConfig.FALSE_FLAG);
		warningConfig.preUpdate();
		dao.update(warningConfig);
	}

	@Transactional(readOnly = false)
	public void disableMonitor(WarningConfig warningConfig) {
		warningConfig.setMonitorFlag(WarningConfig.FALSE_FLAG);
		warningConfig.preUpdate();
		dao.update(warningConfig);
	}
	
	@Transactional(readOnly = false)
	public void enableMonitor(WarningConfig warningConfig) {
		warningConfig.setMonitorFlag(WarningConfig.TRUE_FLAG);
		warningConfig.preUpdate();
		dao.update(warningConfig);
	}

	public WarningConfig getByType(String category, String type){
		return dao.getByType(category, type); 
	}
	
	@Transactional(readOnly = false)
	public void warningValid(WarningConfig warningConfig,Object[] args){
		for (int i = 0; i < args.length; i++) {
        	//如果是库存监控
			 if (args[i] instanceof ProductWpIo && WarningConfig.CATEGORY_STOCK.equals(warningConfig.getCategory())) {
				//调用对应的service method;
              	//(ProductWpIo)args[i];
				 ProductWpIo productWpIo = (ProductWpIo) args[i] ;
				 Product product = productWpIo.getProduct();
				 if (product.getProduce() == null || !StringUtils.isBlank(product.getProduce().getId())) {
					 Produce produce = new Produce(product.getProduce().getId()); //监控产品
					 Warehouse warehouse = warehouseDao.getByWareplace(productWpIo.getIoWareplace()); //根据货位获取监控仓库
					 WhProduce whProduce = whProduceDao.getWhProduceByWidAndPid(warehouse.getId(), produce.getId());
					 //判断是否开启监控
					 if (WhProduce.MOTINORSTATUS_WORKING.equals(whProduce.getMotinorStatus())) {
						 //警戒库存
						if (whProduce.getStockNormal() < whProduce.getStockWarning()) {
							//生成报警记录
							warningService.builderWarning(warningConfig, warehouse, produce);
						}else if (whProduce.getStockNormal() < whProduce.getStockSafe()) { //安全库存
							//生成报警记录
							warningService.builderWarning(warningConfig, warehouse, produce);
						}
						
					}
				}
			 }
        }
		throw new WarningValidException("方法中缺失指定类型参数");
	}
	
}