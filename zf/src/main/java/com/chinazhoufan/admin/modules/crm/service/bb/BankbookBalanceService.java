/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.bb;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.dao.bb.BankbookBalanceDao;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 会员资金账户余额表Service
 * @author 张金俊
 * @version 2015-11-20
 */
@Service
@Transactional(readOnly = true)
public class BankbookBalanceService extends CrudService<BankbookBalanceDao, BankbookBalance> {

	@Autowired
	private MemberDao memberDao;
	
	public BankbookBalance get(String id) {
		return super.get(id);
	}
	
	/**张金俊
	 * 通过会员ID获取会员资金账户余额记录
	 * @param memberId
	 * @return bankbookBalance
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public BankbookBalance getByMemberId(String memberId) {
		return  dao.getByMemberId(memberId);
	}
	
	/**张金俊
	 * 通过会员ID获取会员资金账户余额记录（同时锁定资金账户余额表）（如果查询结果为空，则为会员新增电子账户）
	 * @param memberId
	 * @return bankbookBalance
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public BankbookBalance getByMemberIdForUpdate(String memberId) throws ServiceException {
		BankbookBalance bankbookBalance = dao.getByMemberIdForUpdate(memberId);
		
		if(bankbookBalance == null || StringUtils.isBlank(bankbookBalance.getId())){
			bankbookBalance = new BankbookBalance();
			bankbookBalance.setMember(new Member(memberId));
			bankbookBalance.setUsableBalance(BigDecimal.ZERO);
			bankbookBalance.setFrozenBalance(BigDecimal.ZERO);
			save(bankbookBalance);
		}
		return bankbookBalance;
	}
	
	public List<BankbookBalance> findList(BankbookBalance bankbookBalance) {
		return super.findList(bankbookBalance);
	}
	
	public Page<BankbookBalance> findPage(Page<BankbookBalance> page, BankbookBalance bankbookBalance) {
		if((bankbookBalance != null) && StringUtils.isNotBlank(bankbookBalance.getSearchParameter().getKeyWord())){
			Member m = new Member();
			m.setSearchParameter(bankbookBalance.getSearchParameter());
			Member member =	memberDao.getByUsercode(bankbookBalance.getSearchParameter().getKeyWord());
			bankbookBalance.setMember(member);
		}
		return super.findPage(page, bankbookBalance);
	}
	
	@Transactional(readOnly = false)
	public void save(BankbookBalance bankbookBalance) {
		super.save(bankbookBalance);
	}
	
	@Transactional(readOnly = false)
	public void saveRemarks(BankbookBalance bankbookBalance) {
		dao.updateRemarks(bankbookBalance);
	}
	
	@Transactional(readOnly = false)
	public void insert(BankbookBalance bankbookBalance) {
		dao.insert(bankbookBalance);
	}
	
	@Transactional(readOnly = false)
	public void delete(BankbookBalance bankbookBalance) {
		super.delete(bankbookBalance);
	}
	
	/**张金俊
	 * 检测会员资金账户可操作状态
	 * @param usercode 会员账号
	 * @throws ServiceException
	 */
	public void checkMemberStatus1(String usercode) throws ServiceException{
		if(StringUtils.isBlank(usercode)){
			throw new ServiceException("友情提示：请输入会员账号");
		}
		Member member = memberDao.getByUsercode(usercode);
		if(member == null){
			throw new ServiceException("友情提示：对应会员不存在");
		}
		if(!Member.USERCODESTATUS_NORMAL.equals(member.getUsercodeStatus())){
			throw new ServiceException("友情提示：对应会员账号状态异常");
		}
	}
}