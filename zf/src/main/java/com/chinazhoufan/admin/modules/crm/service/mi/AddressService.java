/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mi;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.IdGen;
import com.chinazhoufan.admin.modules.crm.dao.mi.AddressDao;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;
import com.chinazhoufan.admin.modules.sys.dao.AreaDao;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 会员物流地址管理Service
 * @author 刘晓东
 * @version 2015-12-22
 */
@Service
@Transactional(readOnly = true)
public class AddressService extends CrudService<AddressDao, Address> {
	
	@Autowired
	MemberDao memberDao;
	@Autowired
	AreaDao areaDao;

	public Address get(String id) {
		return super.get(id);
	}
	
	public List<Address> findList(Address address) {
		return super.findList(address);
	}
	
	public Page<Address> findPage(Page<Address> page, Address address) {
		return super.findPage(page, address);
	}
	
	@Transactional(readOnly = false)
	public void save(Address address) {

		/**
		 * 1.会员只能有一个默认地址
		 * 2.当新保存的地址默认标志为“1”时，先判断是否已有默认地址，
		 *   有则将旧地址默认标志更新为“0”,无则直接保存
		 */
		if (address.getDefaultFlag().equals(Address.TRUE_FLAG)) {
			if (dao.countByMember(address.getMember().getId()) > 0) {
				dao.updateByMember(address.getMember().getId());
			}
		}
		//保存地址
		if (address.getIsNewRecord()) {
			address.setId(IdGen.uuid());
			address.setCreateBy(UserUtils.getAdmin());
			address.setCreateDate(new Date());
			address.setUpdateBy(UserUtils.getAdmin());
			address.setUpdateDate(new Date());
			dao.insert(address);
		}else {
			address.setUpdateBy(UserUtils.getAdmin());
			address.setUpdateDate(new Date());
			dao.update(address);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Address address) {
		super.delete(address);
	}


	/**
	 * 前台地址删除
	 * @param addressId
	 */
	@Transactional(readOnly = false)
	public void delete(String addressId) {
		delete(new Address(addressId));
	}

	/**
	 * 前台查询地址列表数据接口
	 * @param memberId
	 * @param page
	 * @return 
	 */
	public List<Address> findByMember(String memberId) {
		return dao.findByMember(memberId);
	}

	/**
	 * 根据ID查找会员默认收货地址
	 * @param memberId
	 * @return 未查询到则返回空，否则返回结果集第一个
	 */
	public Address findDefaultByMember(String memberId){
		List<Address> addressList = dao.findDefaultByMember(memberId);
		return (addressList==null || addressList.size()==0) ? null : addressList.get(0);
	}
	
	/**
	 * 设置为默认地址
	 * @param addressId
	 */
	@Transactional(readOnly = false)
	public void updateDefaultFlag(String addressId) {
		/**
		 * 首先把改会员所有地址修改为非默认
		 * 然后再将对应地址改为默认
		 */
		Address address = get(addressId);
		dao.updateByMember(address.getMember().getId());
		
		address.setDefaultFlag(Address.TRUE_FLAG);
		address.preUpdate();
		dao.update(address);
	}
	
}