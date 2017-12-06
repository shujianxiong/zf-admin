/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.wp;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPrepayRecord;

/**
 * 微信预支付记录DAO接口
 * @author 张金俊
 * @version 2017-05-26
 */
@MyBatisDao
public interface WechatPrepayRecordDao extends CrudDao<WechatPrepayRecord> {
	
}