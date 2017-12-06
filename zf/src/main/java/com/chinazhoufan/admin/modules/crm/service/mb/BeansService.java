/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mb;

import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;
import com.chinazhoufan.admin.modules.crm.dao.mb.BeansDao;

/**
 * 会员魅力豆Service
 * @author 张金俊
 * @version 2017-08-03
 */
@Service
@Transactional(readOnly = true)
public class BeansService extends CrudService<BeansDao, Beans> {

	@Autowired
	private MemberDao memberDao;

	public Beans get(String id) {
		return super.get(id);
	}
	
	public List<Beans> findList(Beans beans) {
		return super.findList(beans);
	}
	
	public Page<Beans> findPage(Page<Beans> page, Beans beans) {
		return super.findPage(page, beans);
	}
	
	@Transactional(readOnly = false)
	public void save(Beans beans) {
		super.save(beans);
	}
	
	@Transactional(readOnly = false)
	public void delete(Beans beans) {
		super.delete(beans);
	}
	/**舒建雄
	 * 通过会员ID获取会员魅力豆账户记录
	 * @param memberId
	 * @return beans
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public Beans getByMemberId(String memberId) {
		return  dao.getByMemberId(memberId);
	}

	/**舒建雄
	 * 通过会员ID获取会员魅力豆账户余额记录（同时锁定魅力豆账户余额表）（如果查询结果为空，则为会员新增魅力豆账户）
	 * @param memberId
	 * @return beans
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public Beans getByMemberIdForUpdate(String memberId) throws ServiceException {
		Beans beans = dao.getByMemberIdForUpdate(memberId);

		if(beans == null || StringUtils.isBlank(beans.getId())){
			beans = new Beans();
			beans.setMember(new Member(memberId));
			beans.setCurrentBeans(0);
			beans.setHistoryBeans(0);
			this.save(beans);
		}
		return beans;
	}

	/**舒建雄
	 * 检测会员魅力豆账户可操作状态
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