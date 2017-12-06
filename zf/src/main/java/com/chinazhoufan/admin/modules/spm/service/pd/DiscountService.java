/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pd;

import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceItem;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceItemService;
import com.chinazhoufan.admin.modules.spm.dao.pd.DiscountDao;
import com.chinazhoufan.admin.modules.spm.dao.pd.DiscountPropertyDao;
import com.chinazhoufan.admin.modules.spm.dao.pd.DiscountPropvalueDao;
import com.chinazhoufan.admin.modules.spm.entity.pd.Discount;
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountProperty;
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountPropvalue;

/**
 * 产品促销表Service
 * @author liut
 * @version 2017-07-04
 */
@Service
@Transactional(readOnly = true)
public class DiscountService extends CrudService<DiscountDao, Discount> {

	@Autowired
	private DiscountPropertyDao discountPropertyDao;
	@Autowired
	private DiscountPropvalueDao discountPropvalueDao; 
	@Autowired
	private ProduceDao produceDao;
	@Autowired
	private ProduceItemService produceItemService;
	
	public Discount get(String id) {
		return super.get(id);
	}
	
	public List<Discount> findList(Discount discount) {
		return super.findList(discount);
	}
	
	public Page<Discount> findPage(Page<Discount> page, Discount discount) {
		return super.findPage(page, discount);
	}
	
	@Transactional(readOnly = false)
	public void save(Discount discount) {
		// 将促销折扣信息写入产品表
		String str = discount.getProduceIdList();
		if(StringUtils.isBlank(str)) {
			throw new ServiceException("请先筛选要促销的产品信息!");
		}
		String[] produceIdArr = str.split(",");
		
		discount.setProduceNum(produceIdArr.length);
		super.save(discount);
		
		if (StringUtils.isNotBlank(discount.getPropertyArr())) {
			String[] propertyArr = discount.getPropertyArr().split(",");
			
			DiscountProperty dp = null;
			
			DiscountPropvalue dpv = null;
			
			for(String pArr : propertyArr) {
				dp = new DiscountProperty();
				dp.setDiscount(discount);
				String[] arr = pArr.split("=");
				dp.setPid(arr[0]);
				dp.preInsert();
				discountPropertyDao.insert(dp);
				
				String[] pvArr = arr[1].split("〓");
				dpv = new DiscountPropvalue();
				for(String pvid : pvArr) {
					dpv.setDiscountProperty(dp);
					dpv.setPvid(pvid);
					dpv.preInsert();
					discountPropvalueDao.insert(dpv);
				}
			}
			
		}
		
		
		Produce produce = null;
		ProduceItem item = null;
		ProduceItem lastItem = null;
		int maxSerialNo = produceItemService.getMaxSerialNo();
		for (String produceId : produceIdArr) {
			lastItem = produceItemService.getLastItemByProduce(produceId);
			produce = produceDao.get(produceId); //获取产品信息
			//判断是否已有产品变更记录，如没有先保存一条原记录
			if (lastItem == null) {
				lastItem = produceItemService.copyFromProduce(produce);
				lastItem.setSrcId(discount.getId());
				lastItem.setSrcType(ProduceItem.SRCTYPE_DISCOUNT);
				lastItem.setSerialNo(++maxSerialNo);
				produceItemService.save(lastItem);
			}
			//更新产品打折信息
			produce.setDiscountFilterScale(discount.getDiscountFilterScale());
			produce.setDiscountFilterStart(discount.getDiscountFilterStart());
			produce.setDiscountFilterEnd(discount.getDiscountFilterEnd());
			produce.setPriceDecPoint(discount.getPriceDecPoint());
			produce.setScaleExperienceDeposit(discount.getScaleExperienceDeposit());
			produce.preUpdate();
			produceDao.update(produce);
			//生成变更记录
			item = produceItemService.copyFromProduce(produce);
			item.setSrcId(discount.getId());
			item.setSrcType(ProduceItem.SRCTYPE_DISCOUNT);
			item.setPreItem(lastItem);
			item.setSerialNo(++maxSerialNo);
			item.setScaleExperienceDeposit(discount.getScaleExperienceDeposit());
			item.setPriceDecPoint(discount.getPriceDecPoint());
			produceItemService.save(item);
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(Discount discount) {
		super.delete(discount);
	}
	
	
	/**
	 * 根据产品促销主表获取查询条件
	 * @param discount
	 * @return
	 */
	public Discount getDiscountDetail(Discount discount) {
		Discount disc = dao.getDiscountDetail(discount);
		ProduceItem produceItem = new ProduceItem();
		produceItem.setSrcType(ProduceItem.SRCTYPE_DISCOUNT);
		produceItem.setSrcId(discount.getId());
		disc.setProduceItemList(produceItemService.listProduceItemBySrc(produceItem));
		return disc;
	};
	
}