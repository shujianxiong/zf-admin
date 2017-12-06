/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ci;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ci.CouponTemplate;

/**
 * 优惠券模板DAO接口
 * @author 张金俊
 * @version 2016-12-02
 */
@MyBatisDao
public interface CouponTemplateDao extends CrudDao<CouponTemplate> {
	
	/**
	 * select选择器    筛选未过期的优惠券模板
	 * @param couponTemplate
	 * @return    设定文件
	 * @throws
	 */
	public List<CouponTemplate> select(CouponTemplate couponTemplate);
	
}