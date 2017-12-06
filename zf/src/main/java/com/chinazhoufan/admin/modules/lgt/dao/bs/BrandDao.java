/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.bs;

import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;

/**
 * 品牌管理DAO接口
 * @author 贾斌
 * @version 2015-11-04
 */
@MyBatisDao
public interface BrandDao extends CrudDao<Brand> {

	public void remove(Map<String, Object> map);

	public void saveCateBrand(Map<String, Object> map);

	public int findCount(Map<String, Object> map);
	
}