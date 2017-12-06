/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ci;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.ShareCodeUtil;
import com.chinazhoufan.admin.modules.spm.dao.ci.CouponDao;
import com.chinazhoufan.admin.modules.spm.dao.ci.CouponTemplateDao;
import com.chinazhoufan.admin.modules.spm.entity.ci.Coupon;
import com.chinazhoufan.admin.modules.spm.entity.ci.CouponTemplate;

/**
 * 优惠券模板Service
 * @author 张金俊
 * @version 2016-12-02
 */
@Service
@Transactional(readOnly = true)
public class CouponTemplateService extends CrudService<CouponTemplateDao, CouponTemplate> {
	
	@Autowired
	private CouponDao couponDao;
	
	public CouponTemplate get(String id) {
		return super.get(id);
	}
	
	public List<CouponTemplate> findList(CouponTemplate couponTemplate) {
		return super.findList(couponTemplate);
	}
	
	public Page<CouponTemplate> findPage(Page<CouponTemplate> page, CouponTemplate couponTemplate) {
		return super.findPage(page, couponTemplate);
	}
	
	public Page<CouponTemplate> selectPage(Page<CouponTemplate> page, CouponTemplate couponTemplate) {
		couponTemplate.setCurrentDate(new Date());
		couponTemplate.setPage(page);
		page.setList(dao.select(couponTemplate));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(CouponTemplate couponTemplate) {
		if(StringUtils.isBlank(couponTemplate.getId())) {
			couponTemplate.setNumCreated(0);
			couponTemplate.setNumProvided(0);
		} 
		super.save(couponTemplate);
	}
	
	@Transactional(readOnly = false)
	public void delete(CouponTemplate couponTemplate) {
		super.delete(couponTemplate);
	}

	@Transactional(readOnly = false)
	public void generateCoupon(CouponTemplate couponTemplate, Integer num) {
		Coupon c = null;
		for(int i = 0; i < num; i++) {
			c = new Coupon(couponTemplate);
			c.setCode(ShareCodeUtil.generateSerialCode(ShareCodeUtil.COUPON_CODE_LENGTH, ShareCodeUtil.COUPON_CODE_DATA_TYPE));
			c.setName(couponTemplate.getCouponName());
			c.setType(couponTemplate.getCouponType());
			c.setStatus(Coupon.STATUS_UNRECEIVED);		// 未领取（后台新生成优惠券）
			c.setReceiveType(Coupon.RECEIVETYPE_GIVE);	// 领取方式：发放（非积分商城兑换生成）
			c.setType(couponTemplate.getCouponType());
			c.setStartTime(couponTemplate.getStartTime());
			c.setEndTime(couponTemplate.getEndTime());
			c.setReachMoney(couponTemplate.getReachMoney());
			c.setDecreaseMoney(couponTemplate.getDecreaseMoney());
			c.setDiscountScale(couponTemplate.getDiscountScale());
			c.setDiscountMoneyMax(couponTemplate.getDiscountMoneyMax());
			c.preInsert();
			couponDao.insert(c);
		}
		//更新优惠券模板的生成数量
		couponTemplate.setNumCreated(couponTemplate.getNumCreated() + num);
		dao.update(couponTemplate);
	}
	
	
	
	
}