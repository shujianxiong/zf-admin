/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.bb;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.dao.bb.BankbookTempDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookTemp;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 会员资金账户临时条目表Service
 * @author 陈适
 * @version 2015-11-23
 */
@Service
@Transactional(readOnly = true)
public class BankbookTempService extends CrudService<BankbookTempDao, BankbookTemp> {

	@Autowired
	private BankbookBalanceService bankbookBalanceService;
	@Autowired
	private BankbookItemService bankbookItemService;
	@Autowired
	private MemberService memberService;
	
	
	public BankbookTemp get(String id) {
		return super.get(id);
	}
	
	public List<BankbookTemp> findList(BankbookTemp bankbookTemp) {
		return super.findList(bankbookTemp);
	}
	
	public Page<BankbookTemp> findPage(Page<BankbookTemp> page, BankbookTemp bankbookTemp) {
		return super.findPage(page, bankbookTemp);
	}
	
	/**张金俊
	 * 根据资金账户ID查询其审核通过的存折条目总数量
	 * @param balanceId
	 * @return
	 */
	public Integer getTempsPassedCountByBalanceId(String balanceId){
		return dao.getTempsPassedCountByBalanceId(balanceId);
	}
	
	/**
	 * 后台存折条目新增
	 */
	@Transactional(readOnly = false)
	public void save(BankbookTemp bankbookTemp) throws ServiceException{
		Member member = memberService.getByUsercode(bankbookTemp.getBankbookBalance().getMember().getUsercode());
		bankbookItemService.checkBankbookBalanceOperateable(member);
		BankbookBalance bankbookBalance = bankbookBalanceService.getByMemberIdForUpdate(member.getId());
		
		bankbookTemp.setBankbookBalance(bankbookBalance);
		bankbookTemp.setCreateType("U");
		bankbookTemp.setStatus("1");
		super.save(bankbookTemp);
	}
	
	/**
	 * 后台存折条目审核
	 */
	@Transactional(readOnly = false)
	public void checkTemp(BankbookTemp bankbookTemp, String checkType) throws ServiceException{
		BankbookTemp temp = dao.get(bankbookTemp.getId());
		if(temp != null && "0".equals(temp.getDelFlag())){
			if("pass".equals(checkType)){
				//审核通过
				bankbookItemService.updateBalanceOperate(bankbookTemp.getBankbookBalance().getMember().getId(),
						bankbookTemp.getChangeType(), bankbookTemp.getMoneyType(), bankbookTemp.getMoney(),
						bankbookTemp.getId());
				int tempsCountOfBalance = dao.getTempsPassedCountByBalanceId(bankbookTemp.getBankbookBalance().getId());
				bankbookTemp.setTempSerialNo(tempsCountOfBalance + 1);
				bankbookTemp.setStatus("2");				//审核通过
				bankbookTemp.setCheckBy(UserUtils.getUser().getId());
				bankbookTemp.setCheckTime(new Date());
				bankbookTemp.setCheckMsg("OK");
				bankbookTemp.preUpdate();
				dao.update(bankbookTemp);
			}else if("refuse".equals(checkType)){
				//审核拒绝
				bankbookTemp.setStatus("3");				//审核拒绝
				bankbookTemp.setCheckBy(UserUtils.getUser().getId());
				bankbookTemp.setCheckTime(new Date());
				bankbookTemp.setCheckMsg("REFUSE");
				bankbookTemp.preUpdate();
				dao.update(bankbookTemp);
			}
		}else{
			throw new ServiceException("存折条目已删除，无法进行审核操作");
		}

	}
	
	
	
//	private void checkMoney(BankbookBalance balance, BankbookTemp bookItem) throws ServiceException{
//		if(null == balance){
//			throw new ServiceException("账户余额不足，无法进行扣款操作");
//		}
//		if(BankbookItem.CHANGETYPE_USABLEBALANCE_DEC.equals(bookItem.getChangeType())||
//				BankbookItem.CHANGETYPE_U2F.equals(bookItem.getChangeType())||
//				BankbookItem.CHANGETYPE_U2D.equals(bookItem.getChangeType())){
//			if(balance.getUsableBalance().compareTo(bookItem.getMoney().abs()) < 0 ){
//				throw new ServiceException("账户可用余额不足，无法进行扣款操作");
//			}
//		}else if(BankbookItem.CHANGETYPE_FROZENBALANCE_DEC.equals(bookItem.getChangeType())||
//					BankbookItem.CHANGETYPE_F2U.equals(bookItem.getChangeType())||
//				   BankbookItem.CHANGETYPE_F2D.equals(bookItem.getChangeType())){
//			if(balance.getFrozenBalance().compareTo(bookItem.getMoney().abs()) < 0 ){
//				throw new ServiceException("账户冻结金额不足，无法进行扣款操作");
//			}
//		}else if(BankbookItem.CHANGETYPE_DEPOSITBALANCE_DEC.equals(bookItem.getChangeType())||
//					BankbookItem.CHANGETYPE_D2U.equals(bookItem.getChangeType())||
//					BankbookItem.CHANGETYPE_D2F.equals(bookItem.getChangeType())){
//			if(balance.getDepositBalance().compareTo(bookItem.getMoney().abs()) < 0 ){
//				throw new ServiceException("账户押金不足，无法进行扣款操作");
//			}
//		}
//	}
	
//	/**
//	 * 根据资金变动类型不同操作不同类型金额
//	 * @param bookItem
//	 */
//	private void changeMoney(BankbookItem bookItem){
//		if(BankbookItem.CHANGETYPE_USABLEBALANCE_ADD.equals(bookItem.getChangeType())){
//			bookItem.addUsableBalance(bookItem.getMoney().abs());
//		}else if(BankbookItem.CHANGETYPE_FROZENBALANCE_ADD.equals(bookItem.getChangeType())){
//			bookItem.addFrozenBalance(bookItem.getMoney().abs());
//		}else if(BankbookItem.CHANGETYPE_DEPOSITBALANCE_ADD.equals(bookItem.getChangeType())){
//			bookItem.addDepositBalance(bookItem.getMoney().abs());
//		}else if(BankbookItem.CHANGETYPE_USABLEBALANCE_DEC.equals(bookItem.getChangeType())){
//			bookItem.DecUsableBalance(bookItem.getMoney().abs().negate());
//		}else if(BankbookItem.CHANGETYPE_FROZENBALANCE_DEC.equals(bookItem.getChangeType())){
//			bookItem.DecFrozenBalance(bookItem.getMoney().abs().negate());
//		}else if(BankbookItem.CHANGETYPE_DEPOSITBALANCE_DEC.equals(bookItem.getChangeType())){
//			bookItem.DecDepositBalance(bookItem.getMoney().abs().negate());
//		}else if(BankbookItem.CHANGETYPE_U2F.equals(bookItem.getChangeType())){
//			bookItem.TransU2F(bookItem.getMoney());
//		}else if(BankbookItem.CHANGETYPE_U2D.equals(bookItem.getChangeType())){
//			bookItem.TransU2D(bookItem.getMoney());
//		}else if(BankbookItem.CHANGETYPE_F2U.equals(bookItem.getChangeType())){
//			bookItem.TransF2U(bookItem.getMoney());
//		}else if(BankbookItem.CHANGETYPE_F2D.equals(bookItem.getChangeType())){
//			bookItem.TransF2D(bookItem.getMoney());
//		}else if(BankbookItem.CHANGETYPE_D2F.equals(bookItem.getChangeType())){
//			bookItem.TransD2F(bookItem.getMoney());
//		}else if(BankbookItem.CHANGETYPE_D2U.equals(bookItem.getChangeType())){
//			bookItem.TransD2U(bookItem.getMoney());
//		}
//		
//	}

//	/**
//	 * 检测资金账户是否存在 不存在则创建 存在则返回查询到的
//	 * @param temp
//	 * @return
//	 */
//	private BankbookBalance checkBalance(BankbookTemp temp){
//		BankbookBalance blance = bankbookBalanceService.getBankbookBalanceForUpdate(temp.getBankbookBalance().getMember().getId());
//		if(null == blance){
//			blance = new BankbookBalance();
//			blance.createBalance(temp.getBankbookBalance().getMember());
//		}else{
//			blance.setMember(temp.getBankbookBalance().getMember());
//		}
//		return blance;
//	}
	
	@Transactional(readOnly = false)
	public void delete(BankbookTemp bankbookTemp) {
		super.delete(bankbookTemp);
	}
	
}