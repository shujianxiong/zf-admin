/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.wp;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatRefundRecord;

/**
 * 微信退款记录DAO接口
 * @author 舒剑雄
 * @version 2017-09-06
 */
@MyBatisDao
public interface WechatRefundRecordDao extends CrudDao<WechatRefundRecord> {
	
}