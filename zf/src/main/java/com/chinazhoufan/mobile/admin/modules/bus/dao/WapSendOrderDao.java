package com.chinazhoufan.mobile.admin.modules.bus.dao;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;

/**
 * WAP发货单DAO 
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 */

@MyBatisDao
public interface WapSendOrderDao extends CrudDao<SendOrder> {

	/**
	 * 获取全部状态为：待发货的发货单
	 */
	public List<SendOrder> listAll(SendOrder sendOrder);
	
	
}
