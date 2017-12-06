/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.IpConfig;

/**
 * IP白名单管理DAO接口
 * @author 陈适
 * @version 2015-11-20
 */
@MyBatisDao
public interface IpConfigDao extends CrudDao<IpConfig> {
	
	/**
	 * 检测录入的IP是否全局唯一
	 * @param code
	 * @throws
	 */
	public Integer getUniqueByIP(String ip);
}