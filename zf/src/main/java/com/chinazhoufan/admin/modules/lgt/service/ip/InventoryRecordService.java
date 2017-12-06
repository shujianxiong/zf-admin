/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ip;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ip.InventoryRecordDao;
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryRecord;

/**
 * 盘点记录Service
 * @author 张金俊
 * @version 2016-03-17
 */
@Service
@Transactional(readOnly = true)
public class InventoryRecordService extends CrudService<InventoryRecordDao, InventoryRecord> {

	public InventoryRecord get(String id) {
		return super.get(id);
	}
	
	public List<InventoryRecord> findList(InventoryRecord inventoryRecord) {
		return super.findList(inventoryRecord);
	}
	
	public Page<InventoryRecord> findPage(Page<InventoryRecord> page, InventoryRecord inventoryRecord) {
		return super.findPage(page, inventoryRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(InventoryRecord inventoryRecord) {
		super.save(inventoryRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(InventoryRecord inventoryRecord) {
		super.delete(inventoryRecord);
	}
	
}