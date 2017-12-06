/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pm;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.entity.pm.PointGoods;
import com.chinazhoufan.admin.modules.spm.dao.pm.PointGoodsDao;

/**
 * 积分商品Service
 * @author 张金俊
 * @version 2016-12-02
 */
@Service
@Transactional(readOnly = true)
public class PointGoodsService extends CrudService<PointGoodsDao, PointGoods> {

	public PointGoods get(String id) {
		return super.get(id);
	}
	
	public List<PointGoods> findList(PointGoods pointGoods) {
		return super.findList(pointGoods);
	}
	
	public Page<PointGoods> findPage(Page<PointGoods> page, PointGoods pointGoods) {
		return super.findPage(page, pointGoods);
	}
	
	@Transactional(readOnly = false)
	public void save(PointGoods pointGoods) {
		if(StringUtils.isBlank(pointGoods.getId())) {//积分商品，新建时，默认可使用数量，和总库存数量一致
			pointGoods.setUsableNum(pointGoods.getTotalNum());
		}
		super.save(pointGoods);
	}
	
	@Transactional(readOnly = false)
	public void delete(PointGoods pointGoods) {
		super.delete(pointGoods);
	}
	
	@Transactional(readOnly = false)
	public void updateUpFlag(PointGoods pointGoods) {
		dao.updateUpFlag(pointGoods);
	}
}