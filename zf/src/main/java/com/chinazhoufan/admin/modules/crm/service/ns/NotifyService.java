/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.ns;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.emay.SendMsgUtil;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.MemberNotify;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.dao.ns.MemberNotifyDao;
import com.chinazhoufan.admin.modules.crm.dao.ns.NotifyDao;
import com.google.common.collect.Maps;

/**
 * 消息Service
 * @author 张金俊
 * @version 2017-07-18
 */
@Service
@Transactional(readOnly = true)
public class NotifyService extends CrudService<NotifyDao, Notify> {

	@Autowired
	RedisCacheService<String, Object> redisCacheService;
	@Autowired
	MemberNotifyDao memberNotifyDao;
	@Autowired
	MemberService memberService;
	
	public Notify get(String id) {
		return super.get(id);
	}
	
	public List<Notify> findList(Notify notify) {
		return super.findList(notify);
	}
	
	public Page<Notify> findPage(Page<Notify> page, Notify notify) {
		return super.findPage(page, notify);
	}
	
	/**
	 * 查询某时间点之后的公告类消息
	 * @param notify
	 * @return
	 */
	public List<Notify> findAnnounceAfterTime(Notify notify) {
		return dao.findAnnounceAfterTime(notify);
	}
	
	@Transactional(readOnly = false)
	public void save(Notify notify) {
		if(Notify.STATUS_PUBLISHED.equals(notify.getStatus())){
			throw new ServiceException("发布状态下不能修改！");
		}
		switch (notify.getType()) {
		case Notify.TYPE_MESSAGE:
			if(countByCode(notify.getMessageCode(), notify.getId()) > 0){
				throw new ServiceException("该"+notify.getMessageCode()+"消息编码已存在！");
			}
			notify.setRemindTargetAction(null);
			notify.setRemindTargetType(null);
			break;
		case Notify.TYPE_REMIND:
			if (countByTargetTypeAndAction(notify.getRemindTargetType(), notify.getRemindTargetAction(), notify.getId()) > 0) {
				throw new ServiceException("该目标类型、目标动作类型已存在！");
			}
			notify.setMessageCode(null);
			break;
		default:
			notify.setRemindTargetAction(null);
			notify.setRemindTargetType(null);
			notify.setMessageCode(null);
			break;
		}
		if (notify.getIsNewRecord()) {
			notify.setStatus(Notify.STATUS_NEW);
		}else {
			Notify notifyOld = get(notify);
			if (!notifyOld.getStatus().equals(notify.getStatus())) {
				throw new ServiceException("消息类型不得变更！");
			}
		}
		super.save(notify);
		if (StringUtils.isNotBlank(notify.getRemindTargetAction())) {
			redisCacheService.del("Notify"+notify.getRemindTargetAction());
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Notify notify) {
		if (!Notify.STATUS_NEW.equals(notify.getStatus())) {
			throw new ServiceException("只能删除新建状态消息！");
		}
		super.delete(notify);
	}
	
	public int countByCode(String messageCode, String id) {
		return dao.countByCode(messageCode, id);
	}

	public Notify getByCode(String messageCode) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("messageCode", messageCode);
		map.put("DEL_FLAG_NORMAL", Notify.DEL_FLAG_NORMAL);
		return dao.getByCode(map);
	}
	
	/**
	 * 通过编码获取已发布的消息
	 * @param messageCode
	 * @return
	 */
	public Notify getPublishedByCode(String messageCode) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("messageCode", messageCode);
		map.put("status", Notify.STATUS_PUBLISHED);
		map.put("DEL_FLAG_NORMAL", Notify.DEL_FLAG_NORMAL);
		return dao.getByCode(map);
	}
	
	public int countByTargetTypeAndAction(String remindTargetType, String remindTargetAction, String id) {
		return dao.countByTargetTypeAndAction(remindTargetType, remindTargetAction, id);
	}
	
	public Notify getByTargetTypeAndAction(String remindTargetType, String remindTargetAction) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("remindTargetType", remindTargetType);
		map.put("remindTargetAction", remindTargetAction);
		map.put("DEL_FLAG_NORMAL", Notify.DEL_FLAG_NORMAL);
		return dao.getByTargetTypeAndAction(map);
	}

	@Transactional(readOnly = false)
	public void publish(Notify notify) {
		if (Notify.TYPE_CUSTOM.equals(notify.getType())) {
			return;
		}
		switch (notify.getStatus()) {
		case Notify.STATUS_NEW:
			notify.setStatus(Notify.STATUS_UNPUBLISH);
			break;
		case Notify.STATUS_UNPUBLISH:
			notify.setStatus(Notify.STATUS_PUBLISHED);
			break;
		case Notify.STATUS_PUBLISHED:
			notify.setStatus(Notify.STATUS_UNPUBLISH);
			break;
		}
		super.save(notify);
	}

	@Async
	@Transactional(readOnly=false)
	public void customSave(Notify notify) throws ServiceException, IOException {
		if(notify.getNotifyMemberVO()!=null&&StringUtils.isNotBlank(notify.getNotifyMemberVO().getType())){
			notify.setType(Notify.TYPE_CUSTOM);
			notify.setStatus(Notify.STATUS_PUBLISHED);
			super.save(notify);
			for (Member member : memberService.findList(notify.getNotifyMemberVO())) {
				MemberNotify memberNotify = new MemberNotify(member, notify, MemberNotify.FALSE_FLAG);
				memberNotify.setContent(notify.getContent());
				memberNotify.preInsert();
				memberNotifyDao.insert(memberNotify);
				if (Notify.TRUE_FLAG.equals(notify.getSmsFlag())) {
					SendMsgUtil.send(member.getUsercode(), notify.getContent());
				}
			}
		}
		else if (notify.getMemberIds()!=null&&notify.getMemberIds().length>0) {
			notify.setType(Notify.TYPE_CUSTOM);
			notify.setStatus(Notify.STATUS_PUBLISHED);
			super.save(notify);
			Member member = null;
			for (int i = 0; i < notify.getMemberIds().length; i++) {
				member = memberService.get(notify.getMemberIds()[i]);
				MemberNotify memberNotify = new MemberNotify(member, notify, MemberNotify.FALSE_FLAG);
				memberNotify.setContent(notify.getContent());
				memberNotify.preInsert();
				memberNotifyDao.insert(memberNotify);
				if (Notify.TRUE_FLAG.equals(notify.getSmsFlag())) {
					SendMsgUtil.send(member.getUsercode(), notify.getContent());
				}
			}
		}
	}
	
}