/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;

/**
 * 扫描电子码DAO接口
 * @author 张金俊
 * @version 2016-11-16
 */
@MyBatisDao
public interface ScanCodeDao extends CrudDao<ScanCode> {
	
	/**
	 * 获取电子码表最后一条记录（同时锁定电子码表）
	 * @return
	 */
	public ScanCode getLastForUpdate();
	
	/**
	 * 通过code查询电子码记录
	 * @param code
	 * @return
	 */
	public ScanCode getByCode(String code);
	
	
	/**
	 * 查询某类型的最后一个电子码记录
	 * @param type
	 * @return
	 */
	public ScanCode getScanCodeLastByType(String type);
	
	
}