/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.dao.um;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.msg.entity.um.MessageConfig;

/**
 * 员工消息发送设置DAO接口
 * @author 刘晓东
 * @version 2015-12-11
 */
@MyBatisDao
public interface MessageConfigDao extends CrudDao<MessageConfig> {

	public void updateUsableflag(MessageConfig messageConfig);
	
}