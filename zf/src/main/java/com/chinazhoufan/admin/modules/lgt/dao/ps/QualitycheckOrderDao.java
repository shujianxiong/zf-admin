/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckDetail;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckOrder;

/**
 * 货品质检单管理DAO接口
 * @author 刘晓东
 * @version 2015-10-13
 */
@MyBatisDao
public interface QualitycheckOrderDao extends CrudDao<QualitycheckOrder> {

	void saveQualitycheckDetail(QualitycheckDetail qualitycheckDetail);

	void updateQualitycheckDetail(QualitycheckDetail qualitycheckDetail);

	/**
	 * 开始质检
	 * @param qualitycheckOrderDao
	 */
	void qualityStart(QualitycheckOrder qualitycheckOrder);
}