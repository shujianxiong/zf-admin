/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceItem;

/**
 * 产品变更记录DAO接口
 * @author 张金俊
 * @version 2017-07-11
 */
@MyBatisDao
public interface ProduceItemDao extends CrudDao<ProduceItem> {

	ProduceItem getLastItemByProduce(@Param("produceId")String produceId);

	
	/**
	 * 根据来源类型及ID获取前后关联数据
	 * @param produceItem
	 * @return
	 */
	public List<ProduceItem> listProduceItemBySrc(ProduceItem produceItem);


	Integer getMaxSerialNo();
	
	
	
}