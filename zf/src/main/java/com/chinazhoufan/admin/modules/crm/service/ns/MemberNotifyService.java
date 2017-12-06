/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.ns;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.emay.SendMsgUtil;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.dao.ns.MemberNotifyDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.MemberNotify;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;

/**
 * 会员消息Service
 * @author 张金俊
 * @version 2017-07-18
 */
@Service
@Transactional(readOnly = true)
public class MemberNotifyService extends CrudService<MemberNotifyDao, MemberNotify> {

	@Autowired
	NotifyService notifyService;
	@Autowired
	SubscribeService subscribeService;
	@Autowired
	ProduceService produceService;
	@Autowired
	private MemberDao memberDao;
	
	public MemberNotify get(String id) {
		return super.get(id);
	}
	
	public List<MemberNotify> findList(MemberNotify memberNotify) {
		return super.findList(memberNotify);
	}
	
	public Page<MemberNotify> findPage(Page<MemberNotify> page, MemberNotify memberNotify) {
		return super.findPage(page, memberNotify);
	}
	
	@Transactional(readOnly = false)
	public void save(MemberNotify memberNotify) {
		super.save(memberNotify);
	}
	
	@Transactional(readOnly = false)
	public void delete(MemberNotify memberNotify) {
		super.delete(memberNotify);
	}
	
	/**
	 * 根据消息生成会员消息
	 * @param notify 	消息
	 * @param member 	会员
	 * @param args		替换参数
	 * @throws ServiceException
	 * @throws IOException 
	 */
	@Transactional(readOnly=false)
	public void createByNotify(Notify notify, Member member, Object... args) throws ServiceException, IOException{
		MemberNotify memberNotify = new MemberNotify(member, notify, MemberNotify.FALSE_FLAG);
		memberNotify.setContent(String.format(notify.getContent(), args));
		save(memberNotify);
		if (Notify.TRUE_FLAG.equals(notify.getSmsFlag())) {
			if (StringUtils.isBlank(member.getUsercode())) {
				member = memberDao.get(member);
			}
			SendMsgUtil.send(member.getUsercode(), String.format(notify.getContent(), args));
		}
	}
	
	/**
	 * 根据消息编码生成会员消息
	 * @param notifyCode 	消息编码
	 * @param member 		会员
	 * @param args			替换参数
	 * @throws ServiceException
	 * @throws IOException 
	 */
	@Transactional(readOnly=false)
	public void createByNotifyCode(String notifyCode, Member member, Object... args) throws ServiceException, IOException{
		Notify notify = notifyService.getPublishedByCode(notifyCode);
		if(notify == null) {
			throw new ServiceException("警告：未找到编码对应的已发布的信息类消息模板，请核查!");
		}
		MemberNotify memberNotify = new MemberNotify(member, notify, MemberNotify.FALSE_FLAG);
		memberNotify.setContent(String.format(notify.getContent(), args));
		save(memberNotify);
		if (Notify.TRUE_FLAG.equals(notify.getSmsFlag())) {
			if (StringUtils.isBlank(member.getUsercode())) {
				member = memberDao.get(member);
			}
			SendMsgUtil.send(member.getUsercode(), String.format(notify.getContent(), args));
		}
	}
	
	
}