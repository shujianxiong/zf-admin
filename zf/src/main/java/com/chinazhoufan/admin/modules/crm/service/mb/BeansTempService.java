/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mb;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansTemp;
import com.chinazhoufan.admin.modules.crm.dao.mb.BeansTempDao;

/**
 * 会员魅力豆临时条目Service
 * @author 张金俊
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class BeansTempService extends CrudService<BeansTempDao, BeansTemp> {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BeansDetailService beansDetailService;

	@Autowired
	private BeansService beansService;
	public BeansTemp get(String id) {
		return super.get(id);
	}
	
	public List<BeansTemp> findList(BeansTemp beansTemp) {
		return super.findList(beansTemp);
	}
	
	public Page<BeansTemp> findPage(Page<BeansTemp> page, BeansTemp beansTemp) {
		return super.findPage(page, beansTemp);
	}
	
	@Transactional(readOnly = false)
	public void save(BeansTemp beansTemp) {
		Member member = memberService.getByUsercode(beansTemp.getBeans().getMember().getUsercode());
		beansDetailService.checkBankbookBalanceOperateable(member);

		Beans beans = beansService.getByMemberIdForUpdate(member.getId());
		beansTemp.setBeans(beans);
		beansTemp.setCreateType("U");
		beansTemp.setCheckStatus(BeansTemp.STATUS_NEW);//新建状态

		super.save(beansTemp);
	}
	
	@Transactional(readOnly = false)
	public void delete(BeansTemp beansTemp) {
		super.delete(beansTemp);
	}
	/**
	 * 后台存折条目审核
	 */
	@Transactional(readOnly = false)
	public void checkTemp(BeansTemp beansTemp, String checkType) throws ServiceException {
		//校验条目是否删除
		BeansTemp temp = dao.get(beansTemp.getId());
		if(temp != null && "0".equals(temp.getDelFlag())){
			if("pass".equals(checkType)){
				//审核通过
				beansDetailService.updateBalanceOperate(beansTemp.getBeans().getMember().getId(),
						beansTemp.getChangeType(), beansTemp.getNum(),
						beansTemp.getId(),beansTemp.getChangeReasonType());
				int tempsCountOfBalance = dao.getTempsPassedCountByBeansId(beansTemp.getBeans().getId());
				beansTemp.setTempSerialNo(tempsCountOfBalance + 1);
				beansTemp.setCheckStatus(BeansTemp.STATUS_PASS);		//审核通过
				beansTemp.setCheckBy(UserUtils.getUser().getId());
				beansTemp.setCheckTime(new Date());
				beansTemp.preUpdate();
				dao.update(beansTemp);
			}else if("refuse".equals(checkType)){
				//审核拒绝
				beansTemp.setCheckStatus(BeansTemp.STATUS_REFUSE);		//审核拒绝
				beansTemp.setCheckBy(UserUtils.getUser().getId());
				beansTemp.setCheckTime(new Date());
				beansTemp.preUpdate();
				dao.update(beansTemp);
			}
		}else{
			throw new ServiceException("该存折条目已被删除，请核对！");
		}
	}
}