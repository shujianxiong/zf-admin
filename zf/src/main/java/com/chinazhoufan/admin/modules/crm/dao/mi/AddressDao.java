/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mi;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;

/**
 * 会员物流地址管理DAO接口
 * @author 刘晓东
 * @version 2015-12-22
 */
@MyBatisDao
public interface AddressDao extends CrudDao<Address> {

	public List<Address> findByMember(String memberId);
	
	/**
	 * 根据ID查找会员默认收货地址
	 * @param memberId
	 * @return
	 */
	public List<Address> findDefaultByMember(String memberId);

	public int countByMember(String memberId);

	public void updateByMember(@Param("memberId")String memberId);

}