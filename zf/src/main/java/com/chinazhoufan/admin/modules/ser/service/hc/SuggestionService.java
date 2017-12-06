/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.hc;

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
import com.chinazhoufan.admin.modules.ser.entity.hc.Suggestion;
import com.chinazhoufan.admin.modules.ser.dao.hc.SuggestionDao;

/**
 * 帮助中心建议Service
 * @author 张金俊
 * @version 2017-07-31
 */
@Service
@Transactional(readOnly = true)
public class SuggestionService extends CrudService<SuggestionDao, Suggestion> {
	@Autowired
	private MemberService memberService;

	public Suggestion get(String id) {
		return super.get(id);
	}
	
	public List<Suggestion> findList(Suggestion suggestion) {
		return super.findList(suggestion);
	}
	
	public Page<Suggestion> findPage(Page<Suggestion> page, Suggestion suggestion) {
		return super.findPage(page, suggestion);
	}
	
	@Transactional(readOnly = false)
	public void save(Suggestion suggestion) {
		Member member = memberService.getByUsercode(suggestion.getMember().getUsercode());
		checkMemberOperateable(member);
		suggestion.setMember(member);
		super.save(suggestion);
	}
	
	@Transactional(readOnly = false)
	public void delete(Suggestion suggestion) {
		super.delete(suggestion);
	}

	/**
	 * 检测会员账户可操作状态
	 * @param memberId 会员ID
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