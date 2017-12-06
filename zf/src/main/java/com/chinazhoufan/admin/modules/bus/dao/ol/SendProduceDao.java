/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;

/**
 * 发货产品DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface SendProduceDao extends CrudDao<SendProduce> {
	
	
	/**
	 * 根据发货单ID获取对应关联的发货产品信息包含对应的商品信息
	 * @param sendOrderId
	 * @return
	 */
	public List<SendProduce> findSendProduceBySendOrder(@Param("sendOrderId")String sendOrderId);
	
	
	
	
}