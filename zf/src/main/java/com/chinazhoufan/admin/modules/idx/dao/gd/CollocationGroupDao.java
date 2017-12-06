/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.gd;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.CollocationGroup;

/**
 * 搭配分组DAO接口
 * @author liut
 * @version 2017-03-15
 */
@MyBatisDao
public interface CollocationGroupDao extends CrudDao<CollocationGroup> {

	
	/**
	 * 获取搭配分组，同时带出分组商品
	 * @param collocationGroup
	 * @return    设定文件
	 * @throws
	 */
	public CollocationGroup getCollocationWithGroupGoods(CollocationGroup collocationGroup);
	
	
	/**
	 * 根据搭配删除搭配分组信息及关联商品信息
	 * @param collocationId    设定文件
	 * @throws
	 */
	public void deleteGroupByCollocation(CollocationGroup collocationGroup);

	/**
	 * 根据搭配ID，修改启用禁用状态
	 * @throws
	 */
	public void updateUsable(CollocationGroup collocationGroup);
	
	
}