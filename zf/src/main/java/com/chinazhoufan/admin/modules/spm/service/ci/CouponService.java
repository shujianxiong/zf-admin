/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ci;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ci.Coupon;
import com.chinazhoufan.admin.modules.spm.dao.ci.CouponDao;

/**
 * 优惠券Service
 * @author 张金俊
 * @version 2016-12-02
 */
@Service
@Transactional(readOnly = true)
public class CouponService extends CrudService<CouponDao, Coupon> {

	public Coupon get(String id) {
		return super.get(id);
	}
	
	public List<Coupon> findList(Coupon coupon) {
		return super.findList(coupon);
	}
	
	public Page<Coupon> findPage(Page<Coupon> page, Coupon coupon) {
		return super.findPage(page, coupon);
	}
	
	@Transactional(readOnly = false)
	public void save(Coupon coupon) {
		super.save(coupon);
	}
	
	@Transactional(readOnly = false)
	public void delete(Coupon coupon) {
		super.delete(coupon);
	}
	
}