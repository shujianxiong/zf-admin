/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;

/**
 * 添加测试数据DAO接口
 * @author 张金俊
 * @version 2016-11-16
 */
@MyBatisDao
public interface AddTestDataDao extends CrudDao<Object> {
	
	/**
	 * 查询某类型的最后一个电子码记录
	 * @param type
	 * @return
	 */
	public ScanCode getScanCodeLastByType(String type);
	
	/**
	 * 清空所有货品的电子码
	 */
	public void clearScanCodeForProduct();
	
	/**
	 * 清空所有货位的电子码
	 */
	public void clearScanCodeForWareplace();
}