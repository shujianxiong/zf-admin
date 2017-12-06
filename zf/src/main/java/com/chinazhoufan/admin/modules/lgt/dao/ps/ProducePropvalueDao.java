/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;

/**
 * 产品组合属性值DAO接口
 * @author 陈适
 * @version 2015-10-22
 */
@MyBatisDao
public interface ProducePropvalueDao extends CrudDao<ProducePropvalue> {

	List<ProducePropvalue> findListByGoodsId(Map<String, Object> map);
	
	public void deleteByProduce(Produce produce);

}