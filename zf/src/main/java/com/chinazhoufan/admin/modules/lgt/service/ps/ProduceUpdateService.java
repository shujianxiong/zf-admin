/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceUpdateDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceUpdate;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 产品更新审批Service
 * @author liut
 * @version 2017-03-22
 */
@Service
@Transactional(readOnly = true)
public class ProduceUpdateService extends CrudService<ProduceUpdateDao, ProduceUpdate> {

	@Autowired
	private ProduceService produceService;
	
	public ProduceUpdate get(String id) {
		return super.get(id);
	}
	
	public List<ProduceUpdate> findList(ProduceUpdate produceUpdate) {
		return super.findList(produceUpdate);
	}
	
	public Page<ProduceUpdate> findPage(Page<ProduceUpdate> page, ProduceUpdate produceUpdate) {
		return super.findPage(page, produceUpdate);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceUpdate produceUpdate) {
		super.save(produceUpdate);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceUpdate produceUpdate) {
		super.delete(produceUpdate);
	}
	
	@Transactional(readOnly = false)
	public void approve(ProduceUpdate produceUpdate) {
		
		produceUpdate.setCheckBy(UserUtils.getUser());
		produceUpdate.setCheckTime(new Date());
		
		if(ProduceUpdate.CHECK_STATUS_OK.equals(produceUpdate.getCheckStatus())) {
			//审批通过，更新产品对应的数据
			Produce produce = produceService.getProduceOnly(produceUpdate.getProduce());
			produce.setIsBuy(produceUpdate.getDesIsBuy());
			produce.setIsExperience(produceUpdate.getDesIsExperience());
			produce.setIsForeBuy(produceUpdate.getDesIsForebuy());
			produce.setIsForeExperience(produceUpdate.getDesIsForeexperience());
//			produce.setPriceBuy(produceUpdate.getDesPriceBuy());
			produce.setPriceOperation(produceUpdate.getDesPriceOperation());
			produce.setPricePurchase(produceUpdate.getDesPricePurchase());
			produce.setDiscountScale(produceUpdate.getDesScaleDiscount());
//			produce.setScaleExperience(produceUpdate.getDesScaleExperience());
			produceService.save(produce);
		}
		super.save(produceUpdate);
		//审批驳回，审批状态变更为新建状态，对应产品数据不做调整
	}
	
	/**
	 * 根据产品ID和状态，获取未审批通过的产品改价申请
	 * @param produceUpdate
	 * @return    设定文件
	 * @throws
	 */
	public List<ProduceUpdate> findUnOkList(ProduceUpdate produceUpdate) {
		produceUpdate.setCheckStatus(ProduceUpdate.CHECK_STATUS_OK);
		return dao.findUnOkList(produceUpdate);
	}
}