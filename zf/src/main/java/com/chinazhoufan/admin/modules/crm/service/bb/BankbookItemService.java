/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.bb;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.dao.bb.BankbookBalanceDao;
import com.chinazhoufan.admin.modules.crm.dao.bb.BankbookItemDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookItem;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;

/**
 * 会员资金账户表管理Service
 * @author 张金俊
 * @version 2015-11-23
 */
@Service
@Transactional(readOnly = true)
public class BankbookItemService extends CrudService<BankbookItemDao, BankbookItem> {

	@Autowired
	private MemberService memberService;
	@Autowired
	private BankbookBalanceService bankbookBalanceService;
	@Autowired
	private BankbookBalanceDao bankbookBalanceDao;
	
	public BankbookItem get(String id) {
		return super.get(id);
	}
	
	/**
	 * 查询资金流水总数量（所有）
	 * @param balanceId
	 * @return
	 */
	private Integer getItemsCountTotal(){
		return dao.getItemsCountTotal();
	}
	
	public List<BankbookItem> findList(BankbookItem bankbookItem) {
		return super.findList(bankbookItem);
	}
	
	public Page<BankbookItem> findPage(Page<BankbookItem> page, BankbookItem bankbookItem) {
		return super.findPage(page, bankbookItem);
	}
	
	@Transactional(readOnly = false)
	public void save(BankbookItem bankbookItem) {
		super.save(bankbookItem);
	}

	/**
	 * 会员资金账户操作通用方法
	 * @param memberId		   账户所属会员ID	不能为空
	 * @param changeType	   变动类型			不能为空
	 * @param moneyType 	   资金类型			不能为空
	 * @param money 		   变动金额 			不能为空
	 * @param uniqueNo 		   来源业务编号		可为空（下单扣款则为订单ID，后台临时存折条目扣补则为存折条目ID）
	 */
	@Transactional(readOnly = false)
	public void updateBalanceOperate(final String memberId, final String changeType, final String moneyType, final BigDecimal money, final String uniqueNo) 
			throws ServiceException{
		// 验证传入参数（会员）
		Member member = memberService.get(memberId);
		this.checkBankbookBalanceOperateable(member);
		// 验证传入参数（变动金额）
		if(money==null || money.compareTo(new BigDecimal("0"))<=0){
			throw new ServiceException("警告：资金账户变动金额不能为空且必须大于0，请核对！");
		}
		
		// 获取会员资金账户余额（同时锁定余额表），没有则新增会员资金账户余额记录
		BankbookBalance bankbookBalance = bankbookBalanceService.getByMemberIdForUpdate(memberId);
		
		// 判断是否重复操作（来源业务ID的各变动类型的记录必须唯一）
		if(!StringUtils.isBlank(uniqueNo)){
			BankbookItem lastBankbookItemByCU = dao.getByChangeTypeAndUniqueNo(changeType, uniqueNo);
			if(lastBankbookItemByCU != null){
				throw new ServiceException("警告：当前来源业务编号已存在该操作类型的资金流水记录，请核对！");
			}
		}
		
		// 获取会员最后一条资金账户流水记录
		BankbookItem lastBankbookItem = dao.getLastByMemberId(memberId);
		// 无资金账户流水记录（新资金账户），则临时new最后一条流水记录，供下面的"判断资金操作对应的账户余额是否足够"及"设置当前资金账户流水的上一次各项余额"用
		if(lastBankbookItem == null){
			lastBankbookItem = new BankbookItem();
			lastBankbookItem.setUsableBalance(BigDecimal.ZERO);
			lastBankbookItem.setFrozenBalance(BigDecimal.ZERO);
		}
		// 判断资金操作对应的账户余额是否足够
		this.checkBankbookBalanceEnough(lastBankbookItem, changeType, money);
		
		// 新增资金账户流水
		BankbookItem bankbookItem = new BankbookItem();
		bankbookItem.setItemNo(this.getItemsCountTotal() + 1);
		bankbookItem.setBankbookBalance(bankbookBalance);
		bankbookItem.setChangeType(changeType);
		bankbookItem.setMoneyType(moneyType);
		bankbookItem.setMoney(money);
		bankbookItem.setLastItemNo(lastBankbookItem.getItemNo()==null ? 0 : lastBankbookItem.getItemNo());
		bankbookItem.setLastUsableBalance(lastBankbookItem.getUsableBalance());	// 设置当前资金账户流水的上一次各项余额
		bankbookItem.setLastFrozenBalance(lastBankbookItem.getFrozenBalance());
		bankbookItem.setUniqueNo(uniqueNo);
		this.computeCurrentBalanceForItem(bankbookItem);
		bankbookItem.preInsert();
		dao.insert(bankbookItem);
		
		// 更新资金账户余额
		bankbookBalance.setUsableBalance(bankbookItem.getUsableBalance());
		bankbookBalance.setFrozenBalance(bankbookItem.getFrozenBalance());
		bankbookBalance.setLastItemNo(bankbookItem.getItemNo());
		bankbookBalance.preUpdate();
		bankbookBalanceDao.update(bankbookBalance);
	}

	/**
	 * 检测会员资金账户可操作状态
	 * @param memberId 会员ID
	 * @throws ServiceException
	 */
	public void checkBankbookBalanceOperateable(Member member) throws ServiceException{
		if(member == null || StringUtils.isBlank(member.getId())){
			throw new ServiceException("警告：对应会员不存在");
		}
		if(!Member.USERCODESTATUS_NORMAL.equals(member.getUsercodeStatus())){
			throw new ServiceException("警告：对应会员账号状态异常");
		}
	}
	
	/**
	 * 检验会员资金账户余额是否足够进行资金操作
	 * @param lastBankbookItem
	 * @param changeType
	 * @param money
	 */
	private void checkBankbookBalanceEnough(BankbookItem lastBankbookItem, String changeType, BigDecimal money) throws ServiceException{
		if(BankbookItem.CHANGETYPE_UBD.equals(changeType)
				|| BankbookItem.CHANGETYPE_UB2FB.equals(changeType)){
			if(lastBankbookItem.getUsableBalance().compareTo(money)<0){
				throw new ServiceException("警告：会员资金账户可用余额不足，不能进行该扣款或转账操作，请核对！");
			}
		}
		if(BankbookItem.CHANGETYPE_FBD.equals(changeType)
				|| BankbookItem.CHANGETYPE_FB2UB.equals(changeType)){
			if(lastBankbookItem.getFrozenBalance().compareTo(money)<0){
				throw new ServiceException("警告：会员资金账户冻结余额不足，不能进行该扣款或转账操作，请核对！");
			}
		}
	}
	
	/**
	 * 根据资金账户流水记录的变动类型、变动金额、上一次各项金额，更新该流水变动后的各项金额
	 * @param bankbookItem
	 */
	private void computeCurrentBalanceForItem(BankbookItem bankbookItem) throws ServiceException{
		switch (bankbookItem.getChangeType()) {
		case BankbookItem.CHANGETYPE_UBA:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance().add(bankbookItem.getMoney()));
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance());
			break;
		case BankbookItem.CHANGETYPE_UBD:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance().subtract(bankbookItem.getMoney()));
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance());
			break;
		case BankbookItem.CHANGETYPE_UB2FB:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance().subtract(bankbookItem.getMoney()));
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance().add(bankbookItem.getMoney()));
			break;
		case BankbookItem.CHANGETYPE_FBA:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance());
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance().add(bankbookItem.getMoney()));
			break;
		case BankbookItem.CHANGETYPE_FBD:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance());
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance().subtract(bankbookItem.getMoney()));
			break;
		case BankbookItem.CHANGETYPE_FB2UB:
			bankbookItem.setUsableBalance(bankbookItem.getLastUsableBalance().add(bankbookItem.getMoney()));
			bankbookItem.setFrozenBalance(bankbookItem.getLastFrozenBalance().subtract(bankbookItem.getMoney()));
			break;
		default:
			throw new ServiceException("警告：更新对应流水变动后的各项金额异常，未匹配到对应的资金账户变动类型");
		}
	}
	
	@Transactional(readOnly = false)
	public void insert(BankbookItem bankbookItem) {
		dao.insert(bankbookItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(BankbookItem bankbookItem) {
		super.delete(bankbookItem);
	}
	
}