/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ob;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyProduce;
import com.chinazhoufan.admin.modules.bus.dao.ob.BuyProduceDao;

/**
 * 购买产品Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class BuyProduceService extends CrudService<BuyProduceDao, BuyProduce> {

	public BuyProduce get(String id) {
		return super.get(id);
	}
	
	public List<BuyProduce> findList(BuyProduce buyProduce) {
		return super.findList(buyProduce);
	}
	
	public Page<BuyProduce> findPage(Page<BuyProduce> page, BuyProduce buyProduce) {
		return super.findPage(page, buyProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(BuyProduce buyProduce) {
		super.save(buyProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(BuyProduce buyProduce) {
		super.delete(buyProduce);
	}

	/**
	 * 查询会员总购买数量
	 * @param memberId
	 * @return
	 */
	public int getTotalNumByMember(String memberId){
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("STATUSSYSTEM_CLOSE", BuyOrder.STATUSSYSTEM_CLOSE);
		return dao.getTotalNumByMember(map);
	}


}