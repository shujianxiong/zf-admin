/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckDetail;

/**
 * 货品质检单管理DAO接口
 * @author 刘晓东
 * @version 2015-10-13
 */
@MyBatisDao
public interface QualitycheckDetailDao extends CrudDao<QualitycheckDetail> {

	/**
	 * 批量插入数据
	 * @param list
	 */
	public void batchInsert(List<QualitycheckDetail> list);
	
	/**
	 * 批量更新数据
	 * @param list
	 */
	public void batchUpdate(List<QualitycheckDetail> list);
}