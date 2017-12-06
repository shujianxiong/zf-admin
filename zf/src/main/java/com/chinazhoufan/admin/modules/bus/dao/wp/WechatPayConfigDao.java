/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.wp;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayConfig;

/**
 * 微信支付配置表DAO接口
 * @author liut
 * @version 2017-05-08
 */
@MyBatisDao
public interface WechatPayConfigDao extends CrudDao<WechatPayConfig> {
	
	
}