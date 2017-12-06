/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mb;

import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.dao.mb.BeansDao;
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansDetail;
import com.chinazhoufan.admin.modules.crm.dao.mb.BeansDetailDao;

/**
 * 会员魅力豆流水Service
 * @author 张金俊
 * @version 2017-08-03
 */
@Service
@Transactional(readOnly = true)
public class BeansDetailService extends CrudService<BeansDetailDao, BeansDetail> {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BeansService beansService;

	@Autowired
	private BeansDao beansDao;

	public BeansDetail get(String id) {
		return super.get(id);
	}
	
	public List<BeansDetail> findList(BeansDetail beansDetail) {
		return super.findList(beansDetail);
	}
	
	public Page<BeansDetail> findPage(Page<BeansDetail> page, BeansDetail beansDetail) {
		return super.findPage(page, beansDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(BeansDetail beansDetail) {
		super.save(beansDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(BeansDetail beansDetail) {
		super.delete(beansDetail);
	}

	/**
	 * 会员魅力豆账户操作通用方法
	 */
	@Transactional(readOnly = false)
	public void updateBalanceOperate(final String memberId, final String changeType, final Integer number, final String operateSourceNo,final String changeReasonType)
			throws ServiceException {
		// 验证传入参数（会员）
		Member member = memberService.get(memberId);
		this.checkBankbookBalanceOperateable(member);
		// 验证传入参数（变动数量）
		if(number==null || number.compareTo(new Integer("0"))<=0){
			throw new ServiceException("警告：魅力豆账户变动数量不能为空且必须大于0，请核对！");
		}

		// 获取会员魅力豆账户余额（同时锁定余额表），没有则新增会员魅力豆账户余额记录
		Beans beans = beansService.getByMemberIdForUpdate(memberId);

		// 判断是否重复操作（来源业务ID的各变动类型的记录必须唯一）
		if(!StringUtils.isBlank(operateSourceNo)){
			BeansDetail lastBeansByCU = dao.getByChangeTypeAndUniqueNo(changeType, operateSourceNo);
			if(lastBeansByCU != null){
				throw new ServiceException("警告：当前来源业务编号已存在该操作类型的魅力豆流水记录，请核对！");
			}
		}

		// 获取会员最后一条魅力豆账户流水记录
		BeansDetail lastBeansItem = dao.getLastByMemberId(memberId);
		// 无魅力豆账户流水记录（新账户），则临时new最后一条流水记录，供下面的"判断魅力豆操作对应的账户余额是否足够"及"设置当前资金账户流水的上一次各项余额"用
		if(lastBeansItem == null){
			lastBeansItem = new BeansDetail();
			lastBeansItem.setCurrentBeans(0);
			lastBeansItem.setHistoryBeans(0);
		}
		// 判断资金操作对应的账户余额是否足够
		this.checkBankbookBalanceEnough(lastBeansItem, changeType, number);

		// 新增魅力豆账户流水
		BeansDetail beansDetail = new BeansDetail();
		beansDetail.setItemNo(this.getItemsCountTotal() + 1);
		beansDetail.setBeans(beans);
		beansDetail.setChangeType(changeType);
		beansDetail.setNum(number);
		beansDetail.setOperateSourceNo(operateSourceNo);
		beansDetail.setPreItemNo(lastBeansItem.getItemNo()==null ? 0 : lastBeansItem.getItemNo());
		beansDetail.setPreCurrentBeans(lastBeansItem.getCurrentBeans());	// 设置当前资金账户流水的上一次各项余额
		beansDetail.setPreHistoryBeans(lastBeansItem.getHistoryBeans());
		beansDetail.setChangeReasonType(changeReasonType);
		this.computeCurrentBalanceForItem(beansDetail);
		beansDetail.preInsert();
		dao.insert(beansDetail);

		// 更新魅力豆账户余额
		beans.setCurrentBeans(beansDetail.getCurrentBeans());
		beans.setHistoryBeans(beansDetail.getHistoryBeans());
		beans.setLastItemNo(beansDetail.getItemNo());
		beans.preUpdate();
		beansDao.update(beans);
	}
	
	/**
	 * 检测会员资金账户可操作状态
	 * @param member 会员
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
	 * 检验会员魅力豆账户余额是否足够进行资金操作
	 * @param beansDetail
	 * @param changeType
	 * @param number
	 */
	private void checkBankbookBalanceEnough(BeansDetail beansDetail, String changeType, Integer number) throws ServiceException{
		if(BeansDetail.CHANGETYPE_DECREASE.equals(changeType)){
			if(beansDetail.getCurrentBeans().compareTo(number)<0){
				throw new ServiceException("警告：会员魅力豆账户可用余额不足，不能进行该操作，请核对！");
			}
		}
	}
	
	/**
	 * 查询魅力豆流水总数量（所有）
	 * @return
	 */
	private Integer getItemsCountTotal(){
		return dao.getItemsCountTotal();
	}

	/**
	 * 根据资金账户流水记录的变动类型、变动金额、上一次各项金额，更新该流水变动后的各项金额
	 * @param beansDetail
	 */
	private void computeCurrentBalanceForItem(BeansDetail beansDetail) throws ServiceException{
		switch (beansDetail.getChangeType()) {
			case BeansDetail.CHANGETYPE_ADD:
				beansDetail.setHistoryBeans(beansDetail.getPreHistoryBeans()+beansDetail.getNum());
				beansDetail.setCurrentBeans(beansDetail.getPreCurrentBeans()+beansDetail.getNum());
				break;
			case BeansDetail.CHANGETYPE_DECREASE:
				beansDetail.setHistoryBeans(beansDetail.getPreHistoryBeans());
				beansDetail.setCurrentBeans(beansDetail.getPreCurrentBeans()-beansDetail.getNum());
				break;
			default:
				throw new ServiceException("警告：更新对应流水变动后的各项魅力豆异常，未匹配到对应的魅力豆账户变动类型");
		}
	}

}