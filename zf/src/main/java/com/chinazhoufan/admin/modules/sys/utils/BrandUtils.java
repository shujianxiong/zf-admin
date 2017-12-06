package com.chinazhoufan.admin.modules.sys.utils;

import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.lgt.dao.bs.BrandDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;


/**
 * 品牌工具；类
 * @author chenshi
 *
 */
public class BrandUtils {
	
	private static BrandDao brandDao = SpringContextHolder.getBean(BrandDao.class);
	
	public static Brand getBrandById(String id){
		return brandDao.get(id);
	}
}
