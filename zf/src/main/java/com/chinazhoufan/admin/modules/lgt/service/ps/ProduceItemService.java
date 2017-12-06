/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceItem;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceItemDao;

/**
 * 产品变更记录Service
 * @author 张金俊
 * @version 2017-07-11
 */
@Service
@Transactional(readOnly = true)
public class ProduceItemService extends CrudService<ProduceItemDao, ProduceItem> {

	public ProduceItem get(String id) {
		return super.get(id);
	}
	
	public List<ProduceItem> findList(ProduceItem produceItem) {
		return super.findList(produceItem);
	}
	
	public Page<ProduceItem> findPage(Page<ProduceItem> page, ProduceItem produceItem) {
		return super.findPage(page, produceItem);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceItem produceItem) {
		super.save(produceItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceItem produceItem) {
		super.delete(produceItem);
	}
	
	/**
	 * 查询产品最后一条变更记录
	 * @param produceId
	 * @return
	 */
	public ProduceItem getLastItemByProduce(String produceId) {
		return dao.getLastItemByProduce(produceId);
	}
	
	/**
	 * 查询当前最大序列号
	 * @return
	 */
	public Integer getMaxSerialNo() {
		return dao.getMaxSerialNo();
	}
	
	/**
	 * 复制产品属性到产品变更记录（返回的产品变更记录，需要设置“新旧标记”和“旧记录ID”）
	 * @param produce
	 * @return ProduceItem
	 */
	public ProduceItem copyFromProduce(Produce produce) {
		ProduceItem pi = new ProduceItem();
		pi.setProduce(produce);
		pi.setCode(produce.getCode());
		pi.setPropertyStr(produce.getPropertyStr());
		pi.setPropertySkuStr(produce.getPropertySkuStr());
		pi.setFactoryCode(produce.getFactoryCode());
		pi.setName(produce.getName());
		pi.setStyleType(produce.getStyleType());
		pi.setStatus(produce.getStatus());
		pi.setStandardWeight(produce.getStandardWeight());
		pi.setPricePurchase(produce.getPricePurchase());
		pi.setPriceOperation(produce.getPriceOperation());
		pi.setRatioOperation(produce.getRatioOperation());
		pi.setPriceSrc(produce.getPriceSrc());
		pi.setScaleExperienceFee(produce.getScaleExperienceFee());
		pi.setScaleExperienceDeposit(produce.getScaleExperienceDeposit());
		pi.setPriceDecPoint(produce.getPriceDecPoint());
		pi.setDiscountPrice(produce.getDiscountPrice());
		pi.setDiscountScale(produce.getDiscountScale());
		pi.setDiscountFilterScale(produce.getDiscountFilterScale());
		pi.setDiscountFilterStart(produce.getDiscountFilterStart());
		pi.setDiscountFilterEnd(produce.getDiscountFilterEnd());
		pi.setIsBuy(produce.getIsBuy());
		pi.setIsExperience(produce.getIsExperience());
		pi.setIsForebuy(produce.getIsForeBuy());
		pi.setIsForeexperience(produce.getIsForeExperience());
		pi.setIsForeexperienceDate(produce.getIsForeexperienceDate());
		pi.setSellNum(produce.getSellNum());
		pi.setRemarks(produce.getRemarks());
		return pi;
	}
	
	
	/**
	 * 根据来源类型及ID获取前后关联数据
	 * @param produceItem
	 * @return
	 */
	public List<ProduceItem> listProduceItemBySrc(ProduceItem produceItem) {
		return dao.listProduceItemBySrc(produceItem);
	}
	
}