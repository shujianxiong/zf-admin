/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mi.CreditDetail;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.dao.mi.CreditDetailDao;

/**
 * 会员信誉流水Service
 * @author 张金俊
 * @version 2017-04-26
 */
@Service
@Transactional(readOnly = true)
public class CreditDetailService extends CrudService<CreditDetailDao, CreditDetail> {

	@Autowired
	MemberService memberService;
	
	public CreditDetail get(String id) {
		return super.get(id);
	}
	
	public List<CreditDetail> findList(CreditDetail creditDetail) {
		return super.findList(creditDetail);
	}
	
	public Page<CreditDetail> findPage(Page<CreditDetail> page, CreditDetail creditDetail) {
		return super.findPage(page, creditDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(CreditDetail creditDetail) {
		super.save(creditDetail);
	}
	
	/**
	 * 变更会员信誉
	 */
	@Transactional(readOnly = false)
	public void updateCredit(CreditDetail creditDetail) {
		Member member = memberService.getByUsercode(creditDetail.getMember().getUsercode());
		memberService.updateCreditOperate(member.getId(), creditDetail.getChangeType(), creditDetail.getChangeCredit(), 
				creditDetail.getChangeReasonType(), CreditDetail.OPERATER_TYPE_STAFF, null);
	}
	
	@Transactional(readOnly = false)
	public void delete(CreditDetail creditDetail) {
		super.delete(creditDetail);
	}
	
}