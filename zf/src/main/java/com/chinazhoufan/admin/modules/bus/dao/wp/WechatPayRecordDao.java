/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.wp;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayRecord;

/**
 * 微信支付记录DAO接口
 * @author 张金俊
 * @version 2017-05-12
 */
@MyBatisDao
public interface WechatPayRecordDao extends CrudDao<WechatPayRecord> {
	
	/**
	 * 查询涉及退款的微信支付记录(退款编号不为空)
	 * @param wechatPayRecord
	 * @return
	 */
	public List<WechatPayRecord> findRefundList(WechatPayRecord wechatPayRecord);
	
}