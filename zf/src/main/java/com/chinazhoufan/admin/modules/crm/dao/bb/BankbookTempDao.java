/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.bb;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookTemp;

/**
 * 会员资金账户临时条目表DAO接口
 * @author 陈适
 * @version 2015-11-23
 */
@MyBatisDao
public interface BankbookTempDao extends CrudDao<BankbookTemp> {
	
	/**张金俊
	 * 根据资金账户ID查询其审核通过的存折条目总数量
	 * @param balanceId
	 * @return
	 */
	public Integer getTempsPassedCountByBalanceId(String balanceId);
	
}