/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.lgt.service.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 货品明细管理Service
 * @author 陈适
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class WapProduceService extends CrudService<ProduceDao, Produce> {
	
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
		if(produce == null || StringUtils.isBlank(produce.getFullWareplace())) return null;
		List<Produce> list = dao.searchByWareplace(produce);
		produce.setPage(page);
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
	
	
	
}

