/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.as;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkorder;

/**
 * 质检工单列表DAO接口
 * @author 舒剑雄
 * @version 2017-10-13
 */
@MyBatisDao
public interface QualityWorkorderDao extends CrudDao<QualityWorkorder> {

    public QualityWorkorder getDetail(QualityWorkorder qualityWorkorder);

    public QualityWorkorder getByOrder(String orderType, String orderId);
	
}