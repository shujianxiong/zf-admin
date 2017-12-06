/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao.pv;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.pv.PvRecord;

/**
 * 页面访问记录DAO接口
 * @author liut
 * @version 2017-03-03
 */
@MyBatisDao
public interface PvRecordDao extends CrudDao<PvRecord> {
	
	/**
	 * 根据页面类型统计浏览量
	 * @param pvRecord
	 * @return    设定文件
	 * @throws
	 */
	public List<PvRecord> statPageViewByPageType(PvRecord pvRecord);
}