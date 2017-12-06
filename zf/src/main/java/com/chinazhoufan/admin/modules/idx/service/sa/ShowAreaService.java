/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.sa;

import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.sa.ShowArea;
import com.chinazhoufan.admin.modules.idx.dao.sa.ShowAreaDao;

/**
 * 周范秀场Service
 * @author 张金俊
 * @version 2017-08-07
 */
@Service
@Transactional(readOnly = true)
public class ShowAreaService extends CrudService<ShowAreaDao, ShowArea> {
	@Autowired
	private MemberService memberService;

	public ShowArea get(String id) {
		return super.get(id);
	}
	
	public List<ShowArea> findList(ShowArea showArea) {
		return super.findList(showArea);
	}
	
	public Page<ShowArea> findPage(Page<ShowArea> page, ShowArea showArea) {
		return super.findPage(page, showArea);
	}
	
	@Transactional(readOnly = false)
	public void save(ShowArea showArea) {
		if(showArea.getMember().getUsercode() != null){
			Member member = memberService.getByUsercode(showArea.getMember().getUsercode());
			checkMemberOperateable(member);
			showArea.setMember(member);
		}
		super.save(showArea);
	}
	
	@Transactional(readOnly = false)
	public void delete(ShowArea showArea) {
		super.delete(showArea);
	}
	/**
	 * 检测会员账户可操作状态
	 * @param member 会员
	 * @throws ServiceException
	 */
	public void checkMemberOperateable(Member member) throws ServiceException{
		if(member == null || StringUtils.isBlank(member.getId())){
			throw new ServiceException("警告：对应会员不存在");
		}
		if(!Member.USERCODESTATUS_NORMAL.equals(member.getUsercodeStatus())){
			throw new ServiceException("警告：对应会员账号状态异常");
		}
	}
}