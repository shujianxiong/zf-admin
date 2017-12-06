/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Config;

/**
 * 系统业务参数表DAO接口
 * @author 刘晓东
 * @version 2015-12-21
 */
@MyBatisDao
public interface ConfigDao extends CrudDao<Config> {
	
	/**
	 * 根据配置代码和值来查询对应系统设置记录
	 * @param config
	 * @return    设定文件
	 * @throws
	 */
	public List<Config> getConfigByCode(Config config);
	
}