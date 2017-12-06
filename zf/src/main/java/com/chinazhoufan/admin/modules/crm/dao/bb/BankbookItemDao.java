/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.bb;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookItem;

/**
 * 会员资金账户表管理DAO接口
 * @author 陈适
 * @version 2015-11-23
 */
@MyBatisDao
public interface BankbookItemDao extends CrudDao<BankbookItem> {
	
	/**
	 * 根据操作类型和来源业务编号查询最后一条资金流水记录
	 * @param changeType 操作类型
	 * @param uniqueNo   来源业务编号
	 * @return
	 */
	public BankbookItem getByChangeTypeAndUniqueNo(@Param("changeType") String changeType, @Param("uniqueNo") String uniqueNo);
	
	/**
	 * 根据会员ID查询会员最后一条资金流水记录
	 * @param memberId 会员ID
	 * @return
	 */
	public BankbookItem getLastByMemberId(String memberId);
	
	/**
	 * 查询资金流水总数量（所有）
	 * @param balanceId
	 * @return
	 */
	public Integer getItemsCountTotal();
	
}