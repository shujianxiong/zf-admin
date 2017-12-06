/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.bb;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;

/**
 * 会员资金账户余额表DAO接口
 * @author 张金俊
 * @version 2015-11-20
 */
@MyBatisDao
public interface BankbookBalanceDao extends CrudDao<BankbookBalance> {
	
	/**
	 * 通过会员ID获取会员资金账户余额记录
	 * @param memberId
	 * @return
	 */
	public BankbookBalance getByMemberId(String memberId);
	
	/**
	 * 通过会员ID获取会员资金账户余额记录（同时锁定资金账户余额表）
	 * @param memberId
	 * @return
	 */
	public BankbookBalance getByMemberIdForUpdate(String memberId);
	
	/**
	 * 更新会员资金账户余额备注
	 * @param bankbookBalance
	 */
	public void updateRemarks(BankbookBalance bankbookBalance);
	
}
