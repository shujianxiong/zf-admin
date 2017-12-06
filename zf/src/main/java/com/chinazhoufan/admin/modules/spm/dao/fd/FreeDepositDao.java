/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.fd;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.fd.FreeDeposit;

/**
 * 免押金活动配置表DAO接口
 * @author liuxiaodong
 * @version 2017-10-15
 */
@MyBatisDao
public interface FreeDepositDao extends CrudDao<FreeDeposit> {

	int countByStartTime(FreeDeposit freeDeposit);
	
}