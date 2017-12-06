/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.dao.ar;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgRecord;

/**
 * 消息发送记录DAO接口
 * @author 张金俊
 * @version 2016-05-30
 */
@MyBatisDao
public interface MsgRecordDao extends CrudDao<MsgRecord> {
	
}