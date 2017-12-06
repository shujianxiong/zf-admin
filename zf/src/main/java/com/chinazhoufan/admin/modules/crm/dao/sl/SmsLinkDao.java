/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.sl;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.sl.SmsLink;

/**
 * 短信链接模块DAO接口
 * @author 舒剑雄
 * @version 2017-09-26
 */
@MyBatisDao
public interface SmsLinkDao extends CrudDao<SmsLink> {
	
}