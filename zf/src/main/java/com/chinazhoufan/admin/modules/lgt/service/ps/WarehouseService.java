/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;

/**
 * 仓库管理Service
 * @author 贾斌
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class WarehouseService extends CrudService<WarehouseDao, Warehouse> {

	@Autowired
	private WarehouseDao warehouseDao;
	@Autowired
	private WhProduceService whProduceService;
	public Warehouse get(String id) {
		return super.get(id);
	}
	
	public List<Warehouse> findList(Warehouse warehouse) {
		return super.findList(warehouse);
	}
	
	public List<Warehouse> findList() {
		return warehouseDao.findAllList(new Warehouse());
	}
	
	public Page<Warehouse> findPage(Page<Warehouse> page, Warehouse warehouse) {
		return super.findPage(page, warehouse);
	}
	
	/**
	 * 新增仓库时，同时新增一套该仓库的产品库存结构（在LGT_PS_WH_PRODUCE仓库产品表中，为该仓库新增所有的产品库存数据）
	 */
	@Transactional(readOnly = false)
	public void save(Warehouse warehouse) {
		boolean isNewRecord = warehouse.getIsNewRecord();
		super.save(warehouse);
		if (isNewRecord){
			whProduceService.addWhProducesByWarehouseId(warehouse.getId());
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Warehouse warehouse) {
		//先伪删除仓库关联的货位数据
		dao.deleteWareplaceByWhouseId(warehouse);
		//再伪删除仓库关联的货屉数据
		dao.deleteWarecounterByWhouseId(warehouse);
		//再伪删除仓库关联的货架数据
		dao.deleteWareareaByWhouseId(warehouse);
		
		super.delete(warehouse);
	}

	/**
	 * 根据货位查找仓库
	 * @param wareplaceId 货位id
	 * @return
	 */
	public Warehouse findWareHouseByWareplaceId(String wareplaceId) {
		return dao.findWareHouseByWareplaceId(wareplaceId);
	}

	/**
	 * 根据仓库查询仓库下所有区域、货架、货位集合
	 * @param house
	 * @return
	 */
	public List<Warehouse> findWareHourseById(String id) {
		return dao.findWareHourseById(id);
	}

	/**
	 * 仓库状态更新
	 * @param warehouseOld
	 */
	@Transactional(readOnly=false)
	public void update(Warehouse warehouseOld) {
		warehouseOld.preUpdate();
		dao.update(warehouseOld);
	}
	
}