/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service.gold;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.dao.gold.BasGoldPriceGatherDao;
import com.chinazhoufan.admin.modules.bas.entity.gold.BasGoldPriceGather;

/**
 * 实时金价采集列表Service
 * @author 贾斌
 * @version 2015-11-04
 */
@Service
@Transactional(readOnly = true)
public class BasGoldPriceGatherService extends CrudService<BasGoldPriceGatherDao, BasGoldPriceGather> {

	private BasGoldPriceGatherDao basGoldPriceGatherDao;
	public BasGoldPriceGather get(String id) {
		return super.get(id);
	}
	
	public List<BasGoldPriceGather> findList(BasGoldPriceGather basGoldPriceGather) {
		return super.findList(basGoldPriceGather);
	}
	
	public List<BasGoldPriceGather> findList() {
		return basGoldPriceGatherDao.findAllList( new BasGoldPriceGather());
	}
	
	public Page<BasGoldPriceGather> findPage(Page<BasGoldPriceGather> page, BasGoldPriceGather basGoldPriceGather) {
		return super.findPage(page, basGoldPriceGather);
	}
	
	@Transactional(readOnly = false)
	public void save(BasGoldPriceGather basGoldPriceGather) {
		super.save(basGoldPriceGather);
	}
	
	@Transactional(readOnly = false)
	public void delete(BasGoldPriceGather basGoldPriceGather) {
		super.delete(basGoldPriceGather);
	}
	
}