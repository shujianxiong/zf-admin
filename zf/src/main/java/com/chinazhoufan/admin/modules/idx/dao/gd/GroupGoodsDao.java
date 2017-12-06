/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.gd;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.GroupGoods;

/**
 * 搭配分组商品DAO接口
 * @author liut
 * @version 2017-03-15
 */
@MyBatisDao
public interface GroupGoodsDao extends CrudDao<GroupGoods> {
	
	/**
	 * 根据搭配分组ID，删除对应的分组商品
	 * @param collocationGroupId    设定文件
	 * @throws
	 */
	public void deleteByCollocationGroup(GroupGoods groupGoods);
	
	
	/**
	 * 根据搭配ID，删除对应的分组商品
	 * @param collocationGroupId    设定文件
	 * @throws
	 */
	public void deleteByCollocation(GroupGoods groupGoods);
}