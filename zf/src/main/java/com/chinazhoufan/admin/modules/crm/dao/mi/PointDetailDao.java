/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mi;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;

/**
 * 积分管理DAO接口
 * @author 刘晓东
 * @version 2015-11-04
 */
@MyBatisDao
public interface PointDetailDao extends CrudDao<PointDetail> {
	
	List<PointDetail> getPointDetailByMember(Map<String, Object> map);
}