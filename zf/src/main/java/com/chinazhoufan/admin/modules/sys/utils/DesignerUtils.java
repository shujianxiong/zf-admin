package com.chinazhoufan.admin.modules.sys.utils;

import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.lgt.dao.bs.DesignerDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Designer;

/**
 *	设计师工具类
 *
 */
public class DesignerUtils {

	private static DesignerDao designerDao = SpringContextHolder.getBean(DesignerDao.class);
	
	public static Designer getDesignerById(String id){
		
		return designerDao.get(id);
	}
}
