/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ir;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ir.InvoiceRecord;

/**
 * 发票开票记录DAO接口
 * @author 张金俊
 * @version 2017-08-07
 */
@MyBatisDao
public interface InvoiceRecordDao extends CrudDao<InvoiceRecord> {
	
}